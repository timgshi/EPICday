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

+ (instancetype)dataSourceWithChannel:(Channel *)channel
                     inCollectionView:(UICollectionView *)collectionView
                        withCellClass:(Class)cellClass
                   andReuseIdentifier:(NSString *)reuseIdentifier;

- (Photo *)photoAtIndexPath:(NSIndexPath *)indexPath;

@end
