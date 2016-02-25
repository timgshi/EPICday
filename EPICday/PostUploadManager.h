//
//  PostUploadManager.h
//  EPICday
//
//  Created by Tim on 2/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostUploadManager : NSObject

+ (instancetype)sharedManager;

- (BFTask *)postPhotoFromData:(NSData *)imageData withExifAttachments:(NSDictionary *)exifAttachments inChannel:(Channel *)channel withPostRef:(Firebase *)postRef;

@end
