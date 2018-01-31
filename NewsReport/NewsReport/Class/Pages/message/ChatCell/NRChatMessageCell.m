//
//  NRChatMessageCell.m
//  NewsReport
//
//  Created by Facebook on 2018/1/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRChatMessageCell.h"

@implementation NRChatMessageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
 
        //头像
        self.headImageView = [[UIImageView alloc] init];
        self.headImageView.image = [UIImage imageNamed:@"friend_head_default"];
        self.headImageView.layer.masksToBounds = YES;
        self.headImageView.layer.cornerRadius = 5;
        self.headImageView.userInteractionEnabled = YES;
        self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.headImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTapGestureRecognizer)]];
        [self.contentView addSubview:self.headImageView];
        
        //昵称
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = [UIColor lightGrayColor];
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.nameLabel];
        
        //已读
        self.hasReadLabel = [[UILabel alloc] init];
        self.hasReadLabel.textColor = [UIColor lightGrayColor];
        self.hasReadLabel.font = [UIFont systemFontOfSize:13];
        self.hasReadLabel.text = @"已读";
        self.hasReadLabel.hidden = YES;
        self.hasReadLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.hasReadLabel];
        
        //重新发送
        self.reSendBtn = [[UIButton alloc] init];
        self.reSendBtn.hidden = YES;
        [self.reSendBtn setImage:[UIImage imageNamed:@"messageSendFail"] forState:(UIControlStateNormal)];
        [self.reSendBtn addTarget:self action:@selector(reSendBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:self.reSendBtn];
        
        //正在发送
        self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activity.backgroundColor = [UIColor clearColor];
        self.activity.hidden = YES;
        [self.contentView addSubview:self.activity];
        
    }
    return self;
}




@end
