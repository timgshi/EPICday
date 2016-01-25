//
//  ChannelStreamCollectionViewController.m
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "ChannelStreamCollectionViewController.h"

#import "PhotoCollectionViewCell.h"
#import "Post.h"
#import "Photo.h"

@interface ChannelStreamCollectionViewController ()

@property (nonatomic, strong) Channel *channel;
@property (nonatomic, strong) NSArray *posts;

@end

@implementation ChannelStreamCollectionViewController

+ (instancetype)streamCollectionVCForChannel:(Channel *)channel {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    ChannelStreamCollectionViewController *streamVC = [[self alloc] initWithCollectionViewLayout:flowLayout];
    streamVC.channel = channel;
    return streamVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PhotoCollectionViewCell registerWithCollectionView:self.collectionView];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.posts.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    Post *post = self.posts[section];
    return post.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[PhotoCollectionViewCell defaultIdentifier]
                                                                              forIndexPath:indexPath];
    
    
    
    return cell;
}

@end
