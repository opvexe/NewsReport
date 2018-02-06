//
//  NRFriendTableViewCell.m
//  NewsReport
//
//  Created by Facebook on 2018/2/5.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRFriendTableViewCell.h"

#define     FRIENDS_SPACE_X         10.0f
#define     FRIENDS_SPACE_Y         9.0f

@interface NRFriendTableViewCell ()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end
@implementation NRFriendTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftSeparatorSpace = FRIENDS_SPACE_X;
        
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.usernameLabel];
        [self.contentView addSubview:self.subTitleLabel];
        
        [self updateViewConstraintsView];
    }
    return self;
}

- (void)setUser:(NRUser *)user{
    _user = user;
//    if (user.avatarPath) {
//        [self.avatarImageView setImage:[UIImage imageNamed:user.avatarPath]];
//    }
//    else {
//        [self.avatarImageView sd_setImageWithURL:URLFromString(user.avatarURL) placeholderImage:[UIImage imageNamed:DEFAULT_AVATAR_PATH]];
//    }
    
//    [self.usernameLabel setText:user.showName];
//    [self.subTitleLabel setText:user.detailInfo.remarkInfo];
//    if (user.detailInfo.remarkInfo.length > 0 && self.subTitleLabel.isHidden) {
//        [self.subTitleLabel setHidden:NO];
//        [self.usernameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(self.avatarImageView).mas_offset(-9.5);
//        }];
//    }
//    else if (user.detailInfo.remarkInfo.length == 0 && !self.subTitleLabel.isHidden){
//        [self.usernameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(self.avatarImageView);
//        }];
//    }
}

- (void)updateViewConstraintsView{
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FRIENDS_SPACE_X);
        make.top.mas_equalTo(FRIENDS_SPACE_Y);
        make.bottom.mas_equalTo(- FRIENDS_SPACE_Y + 0.5);
        make.width.mas_equalTo(self.avatarImageView.mas_height);
    }];
    
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_right).mas_offset(FRIENDS_SPACE_X);
        make.centerY.mas_equalTo(self.avatarImageView);
        make.right.mas_lessThanOrEqualTo(self.contentView).mas_offset(-20);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.usernameLabel);
        make.top.mas_equalTo(self.usernameLabel.mas_bottom).mas_offset(2);
        make.right.mas_lessThanOrEqualTo(self.contentView).mas_offset(-20);
    }];
}


- (UIImageView *)avatarImageView{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] init];
    }
    return _avatarImageView;
}

- (UILabel *)usernameLabel{
    if (_usernameLabel == nil) {
        _usernameLabel = [[UILabel alloc] init];
        [_usernameLabel setFont: [UIFont systemFontOfSize:17.0f]];
    }
    return _usernameLabel;
}

- (UILabel *)subTitleLabel{
    if (_subTitleLabel == nil) {
        _subTitleLabel = [[UILabel alloc] init];
        [_subTitleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_subTitleLabel setTextColor:[UIColor grayColor]];
        [_subTitleLabel setHidden:YES];
    }
    return _subTitleLabel;
}


@end
