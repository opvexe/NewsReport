//
//  NRFileMessageContentView.h
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRChatMessageContentView.h"

@interface NRFileMessageContentView : NRChatMessageContentView


@property (strong, nonatomic) UIView *bgView;

@property (strong, nonatomic) UIImageView *markImgView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *sizeLabel;

@property (strong, nonatomic) UIImageView *progressImgView;

@property (strong, nonatomic) UIButton *cancelBtn;

@end
