//
//  NRVoiceMessageContentView.h
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRChatMessageContentView.h"

@interface NRVoiceMessageContentView : NRChatMessageContentView

@property (nonatomic,strong) UILabel *durationLabel;//语音时长
@property (nonatomic,strong) UIImageView *voiceImageView;
@property (nonatomic,strong) UIView *redView;

@end
