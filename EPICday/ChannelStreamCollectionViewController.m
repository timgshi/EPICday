//
//  ChannelStreamCollectionViewController.m
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "ChannelStreamCollectionViewController.h"

#import <Bolts/Bolts.h>

#import "PhotoCollectionViewCell.h"
#import "Post.h"
#import "PostCollectionViewHeader.h"
#import "Photo.h"
#import "UIColor+EPIC.h"

@interface ChannelStreamCollectionViewController () <UICollectionViewDelegateFlowLayout>

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
    
    self.view.backgroundColor = [UIColor epicDarkGrayColor];
    self.collectionView.backgroundColor = [UIColor epicDarkGrayColor];
    
    [PhotoCollectionViewCell registerWithCollectionView:self.collectionView];
    [PostCollectionViewHeader registerWithCollectionView:self.collectionView];
    
    [[self.channel getRecentPostsAndPhotos] continueWithExecutor:[BFExecutor mainThreadExecutor] withBlock:^id _Nullable(BFTask * _Nonnull task) {
        self.posts = task.result;
        [self.collectionView reloadData];
        return nil;
    }];
}

#pragma mark <UICollectionViewDataSource>

- (Photo *)photoAtIndexPath:(NSIndexPath *)indexPath {
    return [self.posts[indexPath.section] photos][indexPath.item];
}

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
    cell.photo = [self photoAtIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    PostCollectionViewHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[PostCollectionViewHeader defaultIdentifier] forIndexPath:indexPath];
    header.post = self.posts[indexPath.section];
    return header;
}

#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    Photo *photo = [self photoAtIndexPath:indexPath];
    CGFloat width = CGRectGetWidth(self.collectionView.frame) - 30;
    CGFloat ratio = width / photo.size.width;
    CGFloat height = photo.size.height * ratio;
    return CGSizeMake(width, height);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(CGRectGetWidth(collectionView.frame), 44);
}

@end
