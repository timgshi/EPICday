//
//  PostUploadManager.m
//  EPICday
//
//  Created by Tim on 2/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "PostUploadManager.h"

#import "Models.h"

#import <Bolts/Bolts.h>
#import <GPUImage/GPUImage.h>
#import <ImageIO/ImageIO.h>
#import <Firebase/Firebase.h>
#import <AWSS3/AWSS3.h>
#import "SDImageCache.h"

@import Photos;

@interface PostUploadManager ()

//@property (copy, nonatomic) AWSS3TransferUtilityUploadCompletionHandlerBlock uploadCompletionHandler;

@end

@implementation PostUploadManager

static NSString * const PostUploadManagerBucketName = @"epicday";
static NSString * const PostUploadManagerContentType = @"image/jpeg";
static NSString * const PostUploadManagerCompletionValuesDictKey = @"PostUploadManagerCompletionValuesDictKey";
static NSString * const PostUploadManagerCompletionValuesImageUrlKey = @"PostUploadManagerCompletionValuesImageUrlKey";
static NSString * const PostUploadManagerCompletionValuesPhotoRefUrlKey = @"PostUploadManagerCompletionValuesPhotoRefUrlKey";
static NSString * const PostUploadManagerCompletionValueIsThumbnailKey = @"PostUploadManagerCompletionValueIsThumbnailKey";

+ (instancetype)sharedManager {
    static PostUploadManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [self new];
    });
    return sharedManager;
}

- (BFTask *)postPhotoFromData:(NSData *)imageData withSize:(CGSize)size inChannel:(Channel *)channel {
    UIBackgroundTaskIdentifier taskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:taskId];
    }];
    Firebase *photoRef = [[channel.ref childByAppendingPath:@"photos"] childByAutoId];
    NSDictionary *dimensions = @{
                                 @"width": @(size.width),
                                 @"height": @(size.height)
                                 };
    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
    [photoRef setValue:@{
                         @"channel": channel.ref.key,
                         @"timestamp": @(timestamp),
                         @"inverseTimestamp": @(0 - timestamp),
                         @"user": channel.ref.authData.uid,
                         @"dimensions": dimensions,
                         }];
    BFTask *thumbnailTask = [self createThumbnailForPhotoRef:photoRef channel:channel imageData:imageData andSize:size];
    BFTask *s3UploadTask = [self uploadPhotoRef:photoRef toS3FromData:imageData inChannel:channel isThumbnail:NO];
    BFTask *saveTask = [self saveImageDataToLibrary:imageData];
    return [[BFTask taskForCompletionOfAllTasks:@[thumbnailTask, s3UploadTask, saveTask]] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
        [[UIApplication sharedApplication] endBackgroundTask:taskId];
        return nil;
    }];
}

- (BFTask *)postPhotosFromUnfilteredGalleryImageAsData:(NSArray *)assets inSelectedChannel:(Channel *)channel {
    NSMutableArray *filteredImages = @[].mutableCopy;
    NSMutableArray *filteringTasks = @[].mutableCopy;
    NSURL *filterAcvUrl = [[NSBundle mainBundle] URLForResource:@"Castillero" withExtension:@"acv"];
    for (NSData *imageData in assets) {
        BFTask *task = [[BFTask taskWithResult:@YES] continueWithExecutor:[BFExecutor executorWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)] withBlock:^id _Nullable(BFTask * _Nonnull task) {
            GPUImageFilter *filter = [[GPUImageToneCurveFilter alloc] initWithACVURL:filterAcvUrl];
            GPUImagePicture *image = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithData:imageData]];
            [image addTarget:filter];
            [filter useNextFrameForImageCapture];
            [image processImage];
            @autoreleasepool {
                UIImage *filteredImage = [filter imageFromCurrentFramebuffer];
                [filteredImages addObject:filteredImage];
            }
            return [BFTask taskWithResult:@YES];
        }];
        [filteringTasks addObject:task];
    }
    return [[BFTask taskForCompletionOfAllTasks:filteringTasks] continueWithExecutor:[BFExecutor executorWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)] withBlock:^id _Nullable(BFTask * _Nonnull task) {

        NSMutableArray *uploadTasks = @[].mutableCopy;
        for (UIImage *filteredImage in filteredImages) {
            Firebase *photoRef = [[channel.ref childByAppendingPath:@"photos"] childByAutoId];
            NSDictionary *dimensions = @{
                                         @"width": @(filteredImage.size.width),
                                         @"height": @(filteredImage.size.height)
                                         };
            NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
            [photoRef setValue:@{
                                 @"channel": channel.ref.key,
                                 @"timestamp": @(timestamp),
                                 @"inverseTimestamp": @(0 - timestamp),
                                 @"user": channel.ref.authData.uid,
                                 @"dimensions": dimensions
                                 }];
            NSData *filteredImageData = UIImageJPEGRepresentation(filteredImage, 1.0);
            BFTask *thumbnailTask = [self createThumbnailForPhotoRef:photoRef channel:channel imageData:filteredImageData andSize:filteredImage.size];
            BFTask *s3UploadTask = [self uploadPhotoRef:photoRef toS3FromData:filteredImageData inChannel:channel isThumbnail:NO];
            BFTask *task = [BFTask taskForCompletionOfAllTasks:@[thumbnailTask, s3UploadTask]];
            [uploadTasks addObject:task];
        }
        return [BFTask taskForCompletionOfAllTasks:uploadTasks];
    }];
}

- (BFTask *)uploadPhotoRef:(Firebase *)photoRef toS3FromData:(NSData *)imageData inChannel:(Channel *)channel isThumbnail:(BOOL)isThumbnail {
    return [[BFTask taskWithResult:@YES] continueWithExecutor:[BFExecutor executorWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)]
                                                    withBlock:^id _Nullable(BFTask * _Nonnull task) {
        
        NSString *dir = isThumbnail ? @"thumbnails" : @"photos";
        NSString *key = [NSString stringWithFormat:@"%@/%@.jpg", dir, photoRef.key];
        NSURL *tmpDirURL = [NSURL fileURLWithPath:NSTemporaryDirectory() isDirectory:YES];
        NSURL *fileURL = [[tmpDirURL URLByAppendingPathComponent:photoRef.key] URLByAppendingPathExtension:@"jpg"];
        [imageData writeToURL:fileURL atomically:YES];
        AWSS3TransferUtility *transferUtility = [AWSS3TransferUtility defaultS3TransferUtility];
        AWSS3TransferUtilityUploadExpression *uploadExpression = [AWSS3TransferUtilityUploadExpression new];
        [uploadExpression setValue:@"public-read" forRequestParameter:@"x-amz-acl"];
                                                        
        NSString *urlString = [NSString stringWithFormat:@"https://s3.amazonaws.com/%@/%@", PostUploadManagerBucketName, key];
        NSString *modelKey = isThumbnail ? @"thumbnailUrl" : @"imageUrl";

        [photoRef updateChildValues:@{modelKey: urlString}];
                                                        
        [[SDImageCache sharedImageCache] storeImage:[UIImage imageWithData:imageData] forKey:urlString];
        return [[transferUtility uploadFile:fileURL
                                     bucket:PostUploadManagerBucketName
                                        key:key
                                contentType:PostUploadManagerContentType
                                 expression:uploadExpression
                           completionHander:nil] continueWithBlock:^id _Nullable(AWSTask<AWSS3TransferUtilityUploadTask *> * _Nonnull task) {
            return nil;
        }];
                                                        
    }];
}

- (BFTask *)saveImageDataToLibrary:(NSData *)imageData {
    BFTaskCompletionSource *taskSource = [BFTaskCompletionSource taskCompletionSource];
    [PHPhotoLibrary requestAuthorization:^( PHAuthorizationStatus status ) {
        if ( status == PHAuthorizationStatusAuthorized ) {
            // To preserve the metadata, we create an asset from the JPEG NSData representation.
            // Note that creating an asset from a UIImage discards the metadata.
            // In iOS 9, we can use -[PHAssetCreationRequest addResourceWithType:data:options].
            // In iOS 8, we save the image to a temporary file and use +[PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:].
            if ( [PHAssetCreationRequest class] ) {
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    [[PHAssetCreationRequest creationRequestForAsset] addResourceWithType:PHAssetResourceTypePhoto data:imageData options:nil];
                } completionHandler:^( BOOL success, NSError *error ) {
                    if ( ! success ) {
                        NSLog( @"Error occurred while saving image to photo library: %@", error );
                    }
                    [taskSource setResult:@YES];
                }];
            }
            else {
                NSString *temporaryFileName = [NSProcessInfo processInfo].globallyUniqueString;
                NSString *temporaryFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:[temporaryFileName stringByAppendingPathExtension:@"jpg"]];
                NSURL *temporaryFileURL = [NSURL fileURLWithPath:temporaryFilePath];
                
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    NSError *error = nil;
                    [imageData writeToURL:temporaryFileURL options:NSDataWritingAtomic error:&error];
                    if ( error ) {
                        NSLog( @"Error occured while writing image data to a temporary file: %@", error );
                    }
                    else {
                        [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:temporaryFileURL];
                    }
                } completionHandler:^( BOOL success, NSError *error ) {
                    if ( ! success ) {
                        NSLog( @"Error occurred while saving image to photo library: %@", error );
                    }
                    [taskSource setResult:@YES];
                    // Delete the temporary file.
                    [[NSFileManager defaultManager] removeItemAtURL:temporaryFileURL error:nil];
                }];
            }
        }
    }];
    return taskSource.task;
}

- (BFTask *)createThumbnailForPhotoRef:(Firebase *)photoRef channel:(Channel *)channel imageData:(NSData *)imageData andSize:(CGSize)size {
    return [[BFTask taskWithResult:@YES] continueWithExecutor:[BFExecutor executorWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)]
                                                    withBlock:^id _Nullable(BFTask * _Nonnull task) {
         return [[self getThumbnailImageDataFromData:imageData withSize:size] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
             NSData *thumbnailData = task.result;
             [self uploadPhotoRef:photoRef toS3FromData:thumbnailData inChannel:channel isThumbnail:YES];
             return nil;
         }];

    }];
}

- (BFTask *)getThumbnailImageDataFromData:(NSData *)imageData withSize:(CGSize)size {
    return [[BFTask taskWithResult:@YES] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
        CGImageSourceRef imageRef = CGImageSourceCreateWithData((CFDataRef)imageData, nil);
        NSDictionary *options = @{(__bridge NSString *)kCGImageSourceThumbnailMaxPixelSize: @(MAX(size.width, size.height) * 0.2),
                                  (__bridge NSString *)kCGImageSourceCreateThumbnailWithTransform: @YES,
                                  (__bridge NSString *)kCGImageSourceCreateThumbnailFromImageAlways: @YES};
        CGImageRef thumbnailRef = CGImageSourceCreateThumbnailAtIndex(imageRef, 0, (__bridge CFDictionaryRef)options);
        UIImage *thumbnailImage = [UIImage imageWithCGImage:thumbnailRef];
        NSData *thumbnailData = UIImageJPEGRepresentation(thumbnailImage, 1.0);
        CGImageRelease(thumbnailRef);
        return [BFTask taskWithResult:thumbnailData];
    }];
}

@end
