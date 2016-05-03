//
//  ChannelStreamDataSource.h
//  EPICday
//
//  Created by Tim on 2/4/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Channel;
@class Photo;

@interface ChannelStreamDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, strong) Channel *channel;
@property (nonatomic) Class cellClass;
@property (nonatomic, copy) NSString *reuseIdentifier;
@property(strong, nonatomic) void (^populateCell)(UICollectionViewCell *cell, Photo *photo);
@property (nonatomic, readonly) BOOL isLoading;

+ (instancetype)dataSourceWithChannel:(Channel *)channel
                     inCollectionView:(UICollectionView *)collectionView
                   andReuseIdentifier:(NSString *)reuseIdentifier;

- (void)loadNextPage;

- (Photo *)photoAtIndexPath:(NSIndexPath *)indexPath;

@end
