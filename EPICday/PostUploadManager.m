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

@import Photos;

@interface PostUploadManager ()

@property (copy, nonatomic) AWSS3TransferUtilityUploadCompletionHandlerBlock uploadCompletionHandler;

@end

@implementation PostUploadManager

static NSString * const PostUploadManagerBucketName = @"epicday";
static NSString * const PostUploadManagerContentType = @"image/jpeg";
static NSString * const PostUploadManagerCompletionValuesDictKey = @"PostUploadManagerCompletionValuesDictKey";
static NSString * const PostUploadManagerCompletionValuesImageUrlKey = @"PostUploadManagerCompletionValuesImageUrlKey";
static NSString * const PostUploadManagerCompletionValuesPhotoRefUrlKey = @"PostUploadManagerCompletionValuesPhotoRefUrlKey";
static NSString * const PostUploadManagerCompletionValuesPostRefUrlKey = @"PostUploadManagerCompletionValuesPostRefUrlKey";

+ (instancetype)sharedManager {
    static PostUploadManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [self new];
    });
    return sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        __weak typeof(self) weakSelf = self;
        self.uploadCompletionHandler = ^(AWSS3TransferUtilityUploadTask *task, NSError *error) {
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf handleUploadTaskComplete:task];
        };
        AWSS3TransferUtility *transferUtility = [AWSS3TransferUtility defaultS3TransferUtility];
        [transferUtility enumerateToAssignBlocksForUploadTask:^(AWSS3TransferUtilityUploadTask * _Nonnull uploadTask, __autoreleasing AWSS3TransferUtilityUploadProgressBlock * _Nullable uploadProgressBlockReference, __autoreleasing AWSS3TransferUtilityUploadCompletionHandlerBlock * _Nullable completionHandlerReference) {
            __strong typeof(self) strongSelf = weakSelf;
            *completionHandlerReference = strongSelf.uploadCompletionHandler;
        } downloadTask:nil];
    }
    return self;
}

- (BFTask *)postPhotoFromData:(NSData *)imageData withExifAttachments:(NSDictionary *)exifAttachments inChannel:(Channel *)channel withPostRef:(Firebase *)postRef {
    UIBackgroundTaskIdentifier taskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:taskId];
    }];
    Firebase *photoRef = [[[channel.ref root] childByAppendingPath:@"photos"] childByAutoId];
    NSDictionary *dimensions = @{
                                 @"width": exifAttachments[@"{Exif}"][(__bridge NSString *)kCGImagePropertyExifPixelYDimension],
                                 @"height": exifAttachments[@"{Exif}"][(__bridge NSString *)kCGImagePropertyExifPixelXDimension]
                                 };
    [photoRef setValue:@{
                         @"channel": channel.ref.key,
                         @"timestamp": @([[NSDate date] timeIntervalSince1970]),
                         @"post": postRef.key,
                         @"user": channel.ref.authData.uid,
                         @"dimensions": dimensions
                         }];
    CGSize imgSize = CGSizeMake([dimensions[@"width"] floatValue], [dimensions[@"height"] floatValue]);
    BFTask *thumbnailTask = [self createThumbnailForPhotoRef:photoRef inPostRef:postRef withImageData:imageData andSize:imgSize];
    BFTask *s3UploadTask = [self uploadPhotoRef:photoRef toS3FromData:imageData inChannel:channel withPostRef:postRef];
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
        Firebase *postRef = [[[channel.ref root] childByAppendingPath:@"posts"] childByAutoId];
        [postRef setValue:@{
                            @"channel": channel.ref.key,
                            @"timestamp": @([[NSDate date] timeIntervalSince1970]),
                            @"user": channel.ref.authData.uid
                            }];
        [channel.ref updateChildValues:@{[NSString stringWithFormat:@"posts/%@", postRef.key]: @YES}];
        NSMutableArray *uploadTasks = @[].mutableCopy;
        for (UIImage *filteredImage in filteredImages) {
            Firebase *photoRef = [[[channel.ref root] childByAppendingPath:@"photos"] childByAutoId];
            NSDictionary *dimensions = @{
                                         @"width": @(filteredImage.size.width),
                                         @"height": @(filteredImage.size.height)
                                         };
            [photoRef setValue:@{
                                 @"channel": channel.ref.key,
                                 @"timestamp": @([[NSDate date] timeIntervalSince1970]),
                                 @"post": postRef.key,
                                 @"user": channel.ref.authData.uid,
                                 @"dimensions": dimensions
                                 }];
            NSData *filteredImageData = UIImageJPEGRepresentation(filteredImage, 1.0);
            BFTask *thumbnailTask = [self createThumbnailForPhotoRef:photoRef inPostRef:postRef withImageData:filteredImageData andSize:filteredImage.size];
            BFTask *s3UploadTask = [self uploadPhotoRef:photoRef toS3FromData:filteredImageData inChannel:channel withPostRef:postRef];
            BFTask *task = [BFTask taskForCompletionOfAllTasks:@[thumbnailTask, s3UploadTask]];
            [uploadTasks addObject:task];
        }
        return [BFTask taskForCompletionOfAllTasks:uploadTasks];
    }];
}

- (BFTask *)uploadPhotoRef:(Firebase *)photoRef toS3FromData:(NSData *)imageData inChannel:(Channel *)channel withPostRef:(Firebase *)postRef {
    return [[BFTask taskWithResult:@YES] continueWithExecutor:[BFExecutor executorWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)]
                                                    withBlock:^id _Nullable(BFTask * _Nonnull task) {
                                                        
                                                        NSString *key = [NSString stringWithFormat:@"photos/%@.jpg", photoRef.key];
                                                        NSURL *tmpDirURL = [NSURL fileURLWithPath:NSTemporaryDirectory() isDirectory:YES];
                                                        NSURL *fileURL = [[tmpDirURL URLByAppendingPathComponent:photoRef.key] URLByAppendingPathExtension:@"jpg"];
                                                        [imageData writeToURL:fileURL atomically:YES];
                                                        AWSS3TransferUtility *transferUtility = [AWSS3TransferUtility defaultS3TransferUtility];
                                                        AWSS3TransferUtilityUploadExpression *uploadExpression = [AWSS3TransferUtilityUploadExpression new];
                                                        [uploadExpression setValue:@"public-read" forRequestParameter:@"x-amz-acl"];
                                                        return [[transferUtility uploadFile:fileURL
                                                                                     bucket:PostUploadManagerBucketName
                                                                                        key:key
                                                                                contentType:PostUploadManagerContentType
                                                                                 expression:uploadExpression
                                                                           completionHander:self.uploadCompletionHandler] continueWithBlock:^id _Nullable(AWSTask<AWSS3TransferUtilityUploadTask *> * _Nonnull task) {
                                                            NSDictionary *completionValues = @{
                                                                                               PostUploadManagerCompletionValuesImageUrlKey:[NSString stringWithFormat:@"https://s3.amazonaws.com/%@/%@", PostUploadManagerBucketName, key],
                                                                                               PostUploadManagerCompletionValuesPhotoRefUrlKey: [photoRef description],
                                                                                               PostUploadManagerCompletionValuesPostRefUrlKey: [postRef description]
                                                                                               };
                                                            [self storeCompletionValuesDict:completionValues forUploadTask:task];
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

- (BFTask *)createThumbnailForPhotoRef:(Firebase *)photoRef inPostRef:(Firebase *)postRef withImageData:(NSData *)imageData andSize:(CGSize)size {
    return [[BFTask taskWithResult:@YES] continueWithExecutor:[BFExecutor executorWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)]
                                                    withBlock:^id _Nullable(BFTask * _Nonnull task) {
         return [[self getThumbnailImageDataFromData:imageData withSize:size] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
             NSData *thumbnailData = task.result;
             NSString *thumbnailString = [thumbnailData base64EncodedStringWithOptions:0];
             [photoRef updateChildValues:@{@"thumbnailBase64": thumbnailString}];
             [postRef updateChildValues:@{[NSString stringWithFormat:@"photos/%@", photoRef.key]: @YES}];
             return nil;
         }];

    }];
}

- (BFTask *)getThumbnailImageDataFromData:(NSData *)imageData withSize:(CGSize)size {
    return [[BFTask taskWithResult:@YES] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
        CGImageSourceRef imageRef = CGImageSourceCreateWithData((CFDataRef)imageData, nil);
        NSDictionary *options = @{(__bridge NSString *)kCGImageSourceThumbnailMaxPixelSize: @(MAX(size.width, size.height) * 0.2),
                                  (__bridge NSString *)kCGImageSourceCreateThumbnailFromImageAlways: @YES};
        CGImageRef thumbnailRef = CGImageSourceCreateThumbnailAtIndex(imageRef, 0, (__bridge CFDictionaryRef)options);
        UIImage *thumbnailImage = [UIImage imageWithCGImage:thumbnailRef];
        NSData *thumbnailData = UIImageJPEGRepresentation(thumbnailImage, 1.0);
        CGImageRelease(thumbnailRef);
        return [BFTask taskWithResult:thumbnailData];
    }];
    
}

- (void)storeCompletionValuesDict:(NSDictionary *)dict forUploadTask:(AWSTask *)task {
    AWSS3TransferUtilityUploadTask *uploadTask = task.result;
    NSString *dictKey = [NSString stringWithFormat:@"%@/%@", PostUploadManagerCompletionValuesDictKey, @(uploadTask.taskIdentifier)];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:dictKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)handleUploadTaskComplete:(AWSS3TransferUtilityUploadTask *)uploadTask {
    NSString *dictKey = [NSString stringWithFormat:@"%@/%@", PostUploadManagerCompletionValuesDictKey, @(uploadTask.taskIdentifier)];
    NSDictionary *completionDict = [[NSUserDefaults standardUserDefaults] objectForKey:dictKey];
    NSString *imageUrl = completionDict[PostUploadManagerCompletionValuesImageUrlKey];
    Firebase *photoRef = [[Firebase alloc] initWithUrl:completionDict[PostUploadManagerCompletionValuesPhotoRefUrlKey]];
    Firebase *postRef = [[Firebase alloc] initWithUrl:completionDict[PostUploadManagerCompletionValuesPostRefUrlKey]];
    
    [photoRef updateChildValues:@{@"imageUrl": imageUrl}];
    [postRef updateChildValues:@{[NSString stringWithFormat:@"photos/%@", photoRef.key]: @YES}];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:dictKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
