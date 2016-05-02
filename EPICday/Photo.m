//
//  Photo.m
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "Photo.h"

#import <Bolts/Bolts.h>
#import <Firebase/Firebase.h>

@interface Photo ()

@property (nonatomic, copy) NSString *thumbnailDataString;

@end

@implementation Photo

+ (instancetype)photoFromRef:(Firebase *)ref inPost:(Post *)post withInitialLoadTaskSource:(BFTaskCompletionSource *)taskSource {
    Photo *photo = [self new];
    photo.ref = ref;
    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSDictionary *valuesDict = (NSDictionary *)snapshot.value;
        photo.channel = post.channel;
        photo.post = post;
        photo.timestamp = [NSDate dateWithTimeIntervalSince1970:[valuesDict[@"timestamp"] doubleValue]];
        photo.dimensions = valuesDict[@"dimensions"];
        photo.imageUrl = [NSURL URLWithString:valuesDict[@"imageUrl"]];
        [taskSource trySetResult:@YES];
    }];
    return photo;
}

+ (BFTask *)photoFromRef:(Firebase *)ref inPost:(Post *)post {
    BFTaskCompletionSource *taskSource = [BFTaskCompletionSource taskCompletionSource];
    Photo *photo = [self new];
    photo.ref = ref;
    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSDictionary *valuesDict = (NSDictionary *)snapshot.value;
        photo.post = post;
        photo.channel = post.channel;
        photo.post = post;
        photo.timestamp = [NSDate dateWithTimeIntervalSince1970:[valuesDict[@"timestamp"] doubleValue]];
        photo.dimensions = valuesDict[@"dimensions"];
        photo.imageUrl = [NSURL URLWithString:valuesDict[@"imageUrl"]];
        photo.thumbnailDataString = valuesDict[@"thumbnailBase64"];
        [photo createThumbnailFromDataString];
        [taskSource trySetResult:photo];
    }];
    return taskSource.task;
}

- (NSString *)objectId {
    return self.ref.key;
}

- (CGSize)size {
    return CGSizeMake([self.dimensions[@"width"] floatValue], [self.dimensions[@"height"] floatValue]);
}

- (NSUInteger)hash {
    return [self.objectId hash];
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        Photo *p2 = (Photo *)object;
        return [p2.objectId isEqualToString:self.objectId];
    }
    return NO;
}

- (void)createThumbnailFromDataString
{
    NSData *thumbnailData = [[NSData alloc] initWithBase64EncodedString:self.thumbnailDataString options:0];
    self.thumbnail = [UIImage imageWithData:thumbnailData];
}

@end
