//
//  CaptureViewController.m
//  EPICday
//
//  Created by Tim on 1/27/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "CaptureViewController.h"

#import "ChannelBarView.h"
#import "Photo.h"
#import "Post.h"

#import <AVFoundation/AVFoundation.h>
#import <Bolts/Bolts.h>
#import <Masonry/Masonry.h>
#import <ImageIO/ImageIO.h>
@import Photos;

@interface CaptureViewController ()

@property (nonatomic, strong) ChannelBarView *channelBarView;

@property (nonatomic, strong) UIView *captureLayerView;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *capturePreviewLayer;
@property (nonatomic, strong) AVCaptureStillImageOutput *captureOutput;
@property (nonatomic) dispatch_queue_t sessionQueue;

@property (nonatomic, strong) Post *currentPost;

@end

@implementation CaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat statusBarHeight = CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
    
    self.channelBarView = [ChannelBarView barViewWithSelectedChannel:self.selectedChannel];
    [self.view addSubview:self.channelBarView];
    [self.channelBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(statusBarHeight);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@55);
    }];
    
    [self setupScanCapture];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
#if !(TARGET_IPHONE_SIMULATOR)
    [self.captureSession startRunning];
#endif
}

- (void)setupScanCapture {
    
    // Communicate with the session and other session objects on this queue.
    self.sessionQueue = dispatch_queue_create( "session queue", DISPATCH_QUEUE_SERIAL );
    
    self.captureLayerView = [UIView new];
    self.captureLayerView.clipsToBounds = YES;
    self.captureLayerView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.captureLayerView];
    [self.captureLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.channelBarView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
    }];
    
#if !(TARGET_IPHONE_SIMULATOR)
    
    self.captureSession = [[AVCaptureSession alloc] init];
    
    dispatch_async(self.sessionQueue, ^{
        
        AVCaptureDevice *inputDevice = [self backCamera];
        AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:nil];
        if (!captureInput) {
            return;
        }
        
        self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
        if ([self.captureSession canAddInput:captureInput]) {
            [self.captureSession addInput:captureInput];
        }
        
        self.captureOutput = [AVCaptureStillImageOutput new];
        NSDictionary *outputSettings = @{AVVideoCodecKey : AVVideoCodecJPEG};
        [self.captureOutput setOutputSettings:outputSettings];
        if ([self.captureSession canAddOutput:self.captureOutput]) {
            [self.captureSession addOutput:self.captureOutput];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!self.capturePreviewLayer) {
                self.capturePreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
            }
            
            self.capturePreviewLayer.frame = self.captureLayerView.bounds;
            self.capturePreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            [self.captureLayerView.layer addSublayer:self.capturePreviewLayer];
        });
    });
    
#endif // !(TARGET_IPHONE_SIMULATOR)
}

- (AVCaptureDevice *)backCamera {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == AVCaptureDevicePositionBack) {
            return device;
        }
    }
    return nil;
}

- (void)cameraButtonPressed {
    
    dispatch_async( self.sessionQueue, ^{
        AVCaptureConnection *connection = [self.captureOutput connectionWithMediaType:AVMediaTypeVideo];
        AVCaptureVideoPreviewLayer *previewLayer = (AVCaptureVideoPreviewLayer *)self.capturePreviewLayer;
        
        // Update the orientation on the still image output video connection before capturing.
        connection.videoOrientation = previewLayer.connection.videoOrientation;
        
        // Flash set to Auto for Still Capture.
//        [AAPLCameraViewController setFlashMode:AVCaptureFlashModeAuto forDevice:self.videoDeviceInput.device];
        
        // Capture a still image.
        [self.captureOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:^( CMSampleBufferRef imageDataSampleBuffer, NSError *error ) {
            if ( imageDataSampleBuffer ) {
                CFDictionaryRef exifAttachments = CMGetAttachment(imageDataSampleBuffer, kCGImagePropertyExifDictionary, NULL);
                NSDictionary *exifAttachmentsDict = CFBridgingRelease(exifAttachments);
                // The sample buffer is not retained. Create image data before saving the still image to the photo library asynchronously.
                NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                [self uploadPhotoFromData:imageData exifAttachments:exifAttachmentsDict];
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
                                
                                // Delete the temporary file.
                                [[NSFileManager defaultManager] removeItemAtURL:temporaryFileURL error:nil];
                            }];
                        }
                    }
                }];
            }
            else {
                NSLog( @"Could not capture still image: %@", error );
            }
        }];
    } );

}

- (void)uploadPhotoFromData:(NSData *)imageData exifAttachments:(NSDictionary *)exifAttachments {
    [[self createCurrentPostIfNecessary] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
        Photo *photo = [Photo object];
        PFFile *imageFile = [PFFile fileWithData:imageData contentType:@"image/jpeg"];
        photo.image = imageFile;
        photo.post = self.currentPost;
        photo.channel = self.selectedChannel;
        photo.originalTimestamp = exifAttachments[(__bridge NSString *)kCGImagePropertyExifDateTimeOriginal];
        photo.user = [PFUser currentUser];
        photo.dimensions = @{@"width": exifAttachments[(__bridge NSString *)kCGImagePropertyExifPixelXDimension],
                             @"height": exifAttachments[(__bridge NSString *)kCGImagePropertyExifPixelYDimension]};
        return [photo saveInBackground];
    }];
}

- (BFTask *)createCurrentPostIfNecessary {
    if (!self.currentPost) {
        self.currentPost = [Post object];
        self.currentPost.channel = self.selectedChannel;
        self.currentPost.user = [PFUser currentUser];
        return [self.currentPost saveInBackground];
    } else {
        return [BFTask taskWithResult:self.currentPost];
    }
}

@end
