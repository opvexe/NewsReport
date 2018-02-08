//
//  NRVideoMessageContentView.h
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRChatMessageContentView.h"
#import "NRProgressView.h"

@interface NRVideoMessageContentView : NRChatMessageContentView

@property (strong, nonatomic) UIImageView *videoImageView;

@property (strong, nonatomic) UIImageView *playVideoImageView;

@property (strong, nonatomic) NRProgressView *progressView;

@end
