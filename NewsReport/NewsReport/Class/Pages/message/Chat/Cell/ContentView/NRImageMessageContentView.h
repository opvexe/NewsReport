//
//  NRImageMessageContentView.h
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRChatMessageContentView.h"
#import "NRProgressView.h"
@interface NRImageMessageContentView : NRChatMessageContentView

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) NRProgressView *progressView;
@end
