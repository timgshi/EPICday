//
//  FilteredCaptureViewController.m
//  EPICday
//
//  Created by Tim on 2/5/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "FilteredCaptureViewController.h"

#import "Channel.h"

#import "BigCameraButton.h"
#import "ChannelBarView.h"
#import "UIColor+EPIC.h"
#import "UIFont+EPIC.h"

#import <Bolts/Bolts.h>
#import <GPUImage/GPUImage.h>
#import <Masonry/Masonry.h>
#import <ImageIO/ImageIO.h>
#import <Firebase/Firebase.h>
#import <AWSS3/AWSS3.h>

@import Photos;

@interface FilteredCaptureViewController ()

@property (nonatomic, strong) ChannelBarView *channelBarView;

@property (nonatomic, strong) UIView *cameraControlContainerView;
@property (nonatomic, strong) BigCameraButton *cameraButton;
@property (nonatomic, strong) UIButton *switchCameraButton, *stillImageButton, *videoButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *photoCountLabel;

@property (nonatomic, strong) Firebase *currentPostRef;
@property (nonatomic) NSInteger photoCount;

//@property (nonatomic, strong) GPUImageVideoCamera *captureCamera;
@property (nonatomic, strong) GPUImageStillCamera *captureCamera;
@property (nonatomic, strong) GPUImageFilter *captureFilter;
@property (nonatomic, strong) GPUImageView *capturePreviewView;

@property (nonatomic, strong) dispatch_queue_t captureQueue;

@end

@implementation FilteredCaptureViewController


- (Firebase *)currentPostRef {
    if (!_currentPostRef) {
        _currentPostRef = [[[self.selectedChannel.ref root] childByAppendingPath:@"posts"] childByAutoId];
        [_currentPostRef setValue:@{
                                    @"channel": self.selectedChannel.ref.key,
                                    @"timestamp": @([[NSDate date] timeIntervalSince1970]),
                                    @"user": self.selectedChannel.ref.authData.uid
                                    }];
        [self.selectedChannel.ref updateChildValues:@{[NSString stringWithFormat:@"posts/%@", _currentPostRef.key]: @YES}];
    }
    return _currentPostRef;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.captureQueue = dispatch_queue_create("com.EPICday.capture-queue", DISPATCH_QUEUE_CONCURRENT);
    
    CGFloat statusBarHeight = CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
    
    self.view.backgroundColor = [UIColor epicDarkGrayColor];
    
    self.channelBarView = [ChannelBarView barViewWithChannel:self.selectedChannel];
    [self.view addSubview:self.channelBarView];
    [self.channelBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(55 + statusBarHeight));
    }];
    
    self.cameraControlContainerView = [UIView new];
    self.cameraControlContainerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.cameraControlContainerView];
    [self.cameraControlContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@120);
    }];
    self.cameraButton = [BigCameraButton button];
    [self.cameraButton addTarget:self
                          action:@selector(snapStillImage)
                forControlEvents:UIControlEventTouchUpInside];
    [self.cameraControlContainerView addSubview:self.cameraButton];
    [self.cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.cameraControlContainerView.mas_bottom).with.offset(-10);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@72);
        make.width.equalTo(self.cameraButton.mas_height);
    }];
    self.switchCameraButton = [self cameraControlButtonWithTitle:@"switch camera" andAction:nil];
    [self.cameraControlContainerView addSubview:self.switchCameraButton];
    self.stillImageButton = [self cameraControlButtonWithTitle:@"photo" andAction:nil];
    [self.cameraControlContainerView addSubview:self.stillImageButton];
    self.videoButton = [self cameraControlButtonWithTitle:@"video" andAction:nil];
    [self.cameraControlContainerView addSubview:self.videoButton];
    [self.stillImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cameraControlContainerView.mas_top);
        make.width.equalTo(self.cameraControlContainerView.mas_width).dividedBy(3);
        make.centerX.equalTo(self.cameraControlContainerView.mas_centerX);
    }];
    [self.switchCameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stillImageButton.mas_top);
        make.width.equalTo(self.stillImageButton.mas_width);
        make.right.equalTo(self.stillImageButton.mas_left);
    }];
    [self.videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stillImageButton.mas_top);
        make.width.equalTo(self.stillImageButton.mas_width);
        make.left.equalTo(self.stillImageButton.mas_right);
    }];
    
    self.stillImageButton.hidden = YES;
    self.switchCameraButton.hidden = YES;
    self.videoButton.hidden = YES;
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:[UIImage imageNamed:@"ic_arrow_back_white"] forState:UIControlStateNormal];
    [self.backButton addTarget:self
                        action:@selector(backButtonPressed)
              forControlEvents:UIControlEventTouchUpInside];
    [self.cameraControlContainerView addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cameraButton.mas_centerY);
        make.left.equalTo(self.cameraControlContainerView.mas_left).with.offset(15);
    }];
    
    self.photoCountLabel = [UILabel new];
    self.photoCount = 0;
    self.photoCountLabel.text = [@(self.photoCount) stringValue];
    self.photoCountLabel.textColor = [UIColor whiteColor];
    self.photoCountLabel.font = [UIFont epicBoldFontOfSize:32];
    self.photoCountLabel.textAlignment = NSTextAlignmentRight;
    [self.cameraControlContainerView addSubview:self.photoCountLabel];
    [self.photoCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cameraButton.mas_centerY);
        make.right.equalTo(self.cameraControlContainerView.mas_right).with.offset(-15);
    }];
    
//    self.captureCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1920x1080 cameraPosition:AVCaptureDevicePositionBack];
    self.captureCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetPhoto
                                                             cameraPosition:AVCaptureDevicePositionBack];
    self.captureCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.captureCamera.horizontallyMirrorFrontFacingCamera = NO;
    self.captureCamera.horizontallyMirrorRearFacingCamera = NO;
    
    NSURL *filterAcvUrl = [[NSBundle mainBundle] URLForResource:@"Castillero" withExtension:@"acv"];
    self.captureFilter = [[GPUImageToneCurveFilter alloc] initWithACVURL:filterAcvUrl];
    
    self.capturePreviewView = [GPUImageView new];
    self.capturePreviewView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    [self.view addSubview:self.capturePreviewView];
    [self.capturePreviewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.channelBarView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.cameraControlContainerView.mas_top);
    }];
    
    [self.captureCamera addTarget:self.captureFilter];
    [self.captureFilter addTarget:self.capturePreviewView];
    
    [self.captureCamera startCameraCapture];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIDeviceOrientationDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self handleDeviceOrientationChange];
    }];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.captureCamera stopCameraCapture];
}

- (UIButton *)cameraControlButtonWithTitle:(NSString *)title andAction:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont epicLightFontOfSize:14];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - Rotations

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)handleDeviceOrientationChange {
    UIInterfaceOrientation orient = UIInterfaceOrientationPortrait;
    GPUImageRotationMode inputRotationMode = kGPUImageNoRotation;
    switch ([[UIDevice currentDevice] orientation])
    {
        case UIDeviceOrientationLandscapeLeft:
            orient = UIInterfaceOrientationLandscapeRight;
            inputRotationMode = kGPUImageRotateRight;
            break;
            
        case UIDeviceOrientationLandscapeRight:
            orient = UIInterfaceOrientationLandscapeLeft;
            inputRotationMode = kGPUImageRotateLeft;
            break;
            
        case UIDeviceOrientationPortrait:
            orient = UIInterfaceOrientationPortrait;
            inputRotationMode = kGPUImageNoRotation;
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            orient = UIInterfaceOrientationPortraitUpsideDown;
            inputRotationMode = kGPUImageRotate180;
            break;
            
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationFaceDown:
        case UIDeviceOrientationUnknown:
            orient = self.captureCamera.outputImageOrientation;
            break;
    }
    self.captureCamera.outputImageOrientation = orient;
    [self.capturePreviewView setInputRotation:inputRotationMode atIndex:0];
}

#pragma mark Actions

- (void)backButtonPressed {
    [self.captureCamera stopCameraCapture];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)snapStillImage {
    [self.captureCamera capturePhotoAsJPEGProcessedUpToFilter:self.captureFilter withOrientation:UIImageOrientationUp withCompletionHandler:^(NSData *processedJPEG, NSError *error) {
        NSDictionary *metadata = self.captureCamera.currentCaptureMetadata;
        UIBackgroundTaskIdentifier taskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            [[UIApplication sharedApplication] endBackgroundTask:taskId];
        }];
        BFTask *uploadTask = [self uploadPhotoFromData:processedJPEG withExifAttachments:metadata];
        BFTask *saveTask = [self saveImageDataToLibrary:processedJPEG];
        [[BFTask taskForCompletionOfAllTasks:@[uploadTask, saveTask]] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
            [[UIApplication sharedApplication] endBackgroundTask:taskId];
            return nil;
        }];
    }];
}

- (BFTask *)uploadPhotoFromData:(NSData *)imageData withExifAttachments:(NSDictionary *)exifAttachments {
    self.photoCount++;
    self.photoCountLabel.text = [@(self.photoCount) stringValue];
    return [[BFTask taskWithResult:@YES] continueWithExecutor:[BFExecutor executorWithDispatchQueue:self.captureQueue]
                                             withBlock:^id _Nullable(BFTask * _Nonnull task) {
        Firebase *photoRef = [[[self.selectedChannel.ref root] childByAppendingPath:@"photos"] childByAutoId];
        NSDictionary *dimensions = @{
                                     @"width": exifAttachments[@"{Exif}"][(__bridge NSString *)kCGImagePropertyExifPixelYDimension],
                                     @"height": exifAttachments[@"{Exif}"][(__bridge NSString *)kCGImagePropertyExifPixelXDimension]
                                     };
        [photoRef setValue:@{
                             @"channel": self.selectedChannel.ref.key,
                             @"timestamp": @([[NSDate date] timeIntervalSince1970]),
                             @"post": self.currentPostRef.key,
                             @"user": self.selectedChannel.ref.authData.uid,
                             @"dimensions": dimensions
                             }];
        [[self getThumbnailImageDataFromData:imageData withSize:CGSizeMake([dimensions[@"width"] floatValue], [dimensions[@"height"] floatValue])] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
            NSData *thumbnailData = task.result;
            NSString *thumbnailString = [thumbnailData base64EncodedStringWithOptions:0];
            [photoRef updateChildValues:@{@"thumbnailBase64": thumbnailString}];
            return nil;
        }];
        AWSS3TransferManagerUploadRequest *uploadRequest = [AWSS3TransferManagerUploadRequest new];
        uploadRequest.bucket = @"epicday";
        NSString *key = [NSString stringWithFormat:@"photos/%@.jpg", photoRef.key];
        uploadRequest.key = key;
        NSURL *tmpDirURL = [NSURL fileURLWithPath:NSTemporaryDirectory() isDirectory:YES];
        NSURL *fileURL = [[tmpDirURL URLByAppendingPathComponent:photoRef.key] URLByAppendingPathExtension:@"jpg"];
        [imageData writeToURL:fileURL atomically:YES];
        uploadRequest.body = fileURL;
        uploadRequest.contentType = @"image/jpeg";
        uploadRequest.ACL = AWSS3ObjectCannedACLPublicRead;
        [[[AWSS3TransferManager defaultS3TransferManager] upload:uploadRequest] continueWithBlock:^id _Nullable(AWSTask * _Nonnull task) {
            if (task.error) {
                if ([task.error.domain isEqualToString:AWSS3TransferManagerErrorDomain]) {
                    switch (task.error.code) {
                        case AWSS3TransferManagerErrorCancelled:
                        case AWSS3TransferManagerErrorPaused:
                            break;
                            
                        default:
                            NSLog(@"Error: %@", task.error);
                            break;
                    }
                } else {
                    // Unknown error.
                    NSLog(@"Error: %@", task.error);
                }
            }
            
            if (task.result) {
                [photoRef updateChildValues:@{@"imageUrl": [NSString stringWithFormat:@"https://s3.amazonaws.com/%@/%@", uploadRequest.bucket, uploadRequest.key]}];
                [self.currentPostRef updateChildValues:@{[NSString stringWithFormat:@"photos/%@", photoRef.key]: @YES}];
                // The file uploaded successfully.
            }
            return nil;
        }];
        return nil;
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

@end
