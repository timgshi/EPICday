//
//  PostUploadManager.h
//  EPICday
//
//  Created by Tim on 2/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BFTask;
@class Channel;
@class Firebase;

@interface PostUploadManager : NSObject

+ (instancetype)sharedManager;

- (BFTask *)postPhotoFromData:(NSData *)imageData withSize:(CGSize)size inChannel:(Channel *)channel;
- (BFTask *)postPhotosFromUnfilteredGalleryImageAsData:(NSArray *)assets inSelectedChannel:(Channel *)channel;

@end
