//
//  NRFriendHeaderView.m
//  NewsReport
//
//  Created by Facebook on 2018/2/5.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRFriendHeaderView.h"

@interface NRFriendHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end
@implementation NRFriendHeaderView

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIView *bgView = [UIView new];
        [bgView setBackgroundColor:UIColorFromRGB(0xfafafa)];
        [self setBackgroundView:bgView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel setFrame:CGRectMake(10, 0, self.width - 15, self.height)];
}

- (void) setTitle:(NSString *)title
{
    _title = title;
    [_titleLabel setText:title];
}

- (UILabel *) titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:14.5f]];
        [_titleLabel setTextColor:[UIColor grayColor]];
    }
    return _titleLabel;
}

@end
