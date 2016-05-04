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

@end

@implementation Photo

+ (instancetype)photoFromRef:(Firebase *)ref inChannel:(Channel *)channel withInitialLoadTaskSource:(BFTaskCompletionSource *)taskSource {
    Photo *photo = [self new];
    photo.ref = ref;
    photo.channel = channel;
    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSDictionary *valuesDict = (NSDictionary *)snapshot.value;
        [photo fillInValuesFromDictionary:valuesDict];
        [taskSource trySetResult:@YES];
    }];
    return photo;
}

+ (instancetype)photoFromRef:(Firebase *)ref channel:(Channel *)channel valueDictionary:(NSDictionary *)dict
{
    Photo *photo = [Photo new];
    photo.ref = ref;
    photo.channel = channel;
    [photo fillInValuesFromDictionary:dict];
    return photo;
}

+ (BFTask *)photoFromRef:(Firebase *)ref inChannel:(Channel *)channel {
    BFTaskCompletionSource *taskSource = [BFTaskCompletionSource taskCompletionSource];
    Photo *photo = [self new];
    photo.ref = ref;
    photo.channel = channel;
    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSDictionary *valuesDict = (NSDictionary *)snapshot.value;
        [photo fillInValuesFromDictionary:valuesDict];
        [taskSource trySetResult:photo];
    }];
    return taskSource.task;
}

- (void)fillInValuesFromDictionary:(NSDictionary *)valuesDict
{
    self.timestamp = [NSDate dateWithTimeIntervalSince1970:[valuesDict[@"timestamp"] doubleValue]];
    self.dimensions = valuesDict[@"dimensions"];
    self.imageUrl = [NSURL URLWithString:valuesDict[@"imageUrl"]];
    self.thumbnailUrl = [NSURL URLWithString:valuesDict[@"thumbnailUrl"]];
    self.userRef = [[[self.ref root] childByAppendingPath:@"users"] childByAppendingPath:valuesDict[@"user"]];
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

@end
