//
//  PostCollectionViewHeader.m
//  EPICday
//
//  Created by Tim on 1/26/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "PostCollectionViewHeader.h"

#import "UIColor+EPIC.h"
#import "UIFont+EPIC.h"
#import "User.h"

#import <Bolts/Bolts.h>
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface PostCollectionViewHeader ()

@property (nonatomic) BOOL hasInstalledViewConstraints;

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel, *timeLabel;

@end

@implementation PostCollectionViewHeader

+ (NSString *)defaultIdentifier {
    static NSString * const PostCollectionViewHeaderIdentifier = @"PostCollectionViewHeaderIdentifier";
    return PostCollectionViewHeaderIdentifier;
}

+ (void)registerWithCollectionView:(UICollectionView *)collectionView {
    [collectionView registerClass:self
       forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
              withReuseIdentifier:[self defaultIdentifier]];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
    }
    return self;
}

- (void)setPost:(Post *)post {
    _post = post;
    [self updateUIWithPost:post];
}

- (void)createViews {
    
    self.backgroundColor = [UIColor epicLightGrayColor];
    
    self.avatarImageView = [UIImageView new];
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImageView.layer.cornerRadius = 5;
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.avatarImageView];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [UIFont epicBoldFontOfSize:16];
    self.nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.nameLabel];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.font = [UIFont epicLightFontOfSize:12];
    self.timeLabel.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.timeLabel];
}

- (void)updateConstraints {
    [self installViewConstraintsIfNecessary];
    [super updateConstraints];
}

- (void)installViewConstraintsIfNecessary {
    if (!self.hasInstalledViewConstraints) {
        self.hasInstalledViewConstraints = YES;
        
        const CGFloat kMargin = 15;
        const CGFloat kVerticalMargin = 5;
        
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(kMargin);
            make.top.equalTo(self.mas_top).with.offset(kVerticalMargin);
            make.bottom.equalTo(self.mas_bottom).with.offset(-kVerticalMargin);
            make.width.equalTo(self.avatarImageView.mas_height);
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarImageView.mas_right).with.offset(kMargin);
            make.centerY.equalTo(self.mas_centerY);
        }];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-kMargin);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
}

- (void)updateUIWithPost:(Post *)post {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    });
    [[[RACObserve(post, timestamp) takeUntil:self.rac_prepareForReuseSignal] map:^id(NSDate *timestamp) {
        return [dateFormatter stringFromDate:timestamp];
    }] subscribeNext:^(NSString *timestampString) {
        self.timeLabel.text = timestampString;
    }];
    User *user = [User userFromRef:post.userRef];
    [[RACObserve(user, displayName) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(NSString *displayName) {
        self.nameLabel.text = displayName;
    }];
    [[RACObserve(user, avatarUrl) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(NSURL *avatarUrl) {
        [self.avatarImageView sd_setImageWithURL:avatarUrl];
    }];
//    BFTask *task = nil;
//    if (!post.user.isDataAvailable) {
//        task = [post.user fetchInBackground];
//    } else {
//        task = [BFTask taskWithResult:post.user];
//    }
//    [task continueWithExecutor:[BFExecutor mainThreadExecutor] withBlock:^id _Nullable(BFTask * _Nonnull task) {
//        if (post.user[@"profilePhotoUrl"]) {
//            NSURL *avatarUrl = [NSURL URLWithString:post.user[@"profilePhotoUrl"]];
//            [self.avatarImageView sd_setImageWithURL:avatarUrl];
//        }
//        self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", post.user[@"first_name"], post.user[@"last_name"]];
//        self.timeLabel.text = [dateFormatter stringFromDate:post.createdAt];
//        return nil;
//    }];
}

@end
