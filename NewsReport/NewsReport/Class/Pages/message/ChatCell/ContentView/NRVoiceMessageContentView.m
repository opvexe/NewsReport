//
//  NRVoiceMessageContentView.m
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRVoiceMessageContentView.h"

@implementation NRVoiceMessageContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage * image = [UIImage imageNamed:@"icon_receiver_voice_playing.png"];
        _voiceImageView = [[UIImageView alloc] initWithImage:image];
        NSArray * animateNames = @[@"icon_receiver_voice_playing_001.png",@"icon_receiver_voice_playing_002.png",@"icon_receiver_voice_playing_003.png"];
        NSMutableArray * animationImages = [[NSMutableArray alloc] initWithCapacity:animateNames.count];
        for (NSString * animateName in animateNames) {
            UIImage * animateImage = [UIImage imageNamed:animateName];
            [animationImages addObject:animateImage];
        }
        _voiceImageView.animationImages = animationImages;
        _voiceImageView.animationDuration = 1.0;
        [self addSubview:_voiceImageView];
        
        _durationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _durationLabel.backgroundColor = [UIColor clearColor];
        _durationLabel.font = [UIFont systemFontOfSize:14.f];
        [self addSubview:_durationLabel];
        
        _redView = [[UIView alloc] init];
        _redView.backgroundColor = [UIColor redColor];
        _redView.layer.masksToBounds = YES;
        _redView.layer.cornerRadius = 5;
        _redView.hidden = YES;
        [self addSubview:_redView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.messageModel.isSender) {//右边
        _durationLabel.frame = CGRectMake(15, 10, 40, 20);
        _durationLabel.textAlignment = NSTextAlignmentLeft;
        _durationLabel.textColor = [UIColor whiteColor];
        _voiceImageView.frame = CGRectMake(self.messageModel.contentWidth - 15 - 20, 10, 20, 20);
        _redView.hidden = YES;
    } else {//左边
        _durationLabel.frame = CGRectMake(self.messageModel.contentWidth - 15 - 40, 10, 40, 20);
        _durationLabel.textAlignment = NSTextAlignmentRight;
        _durationLabel.textColor = [UIColor blackColor];
        _voiceImageView.frame = CGRectMake(15, 10, 20, 20);
        _redView.frame = CGRectMake(self.messageModel.contentWidth - 12, -3, 10, 10);
    }
}

- (void)refreshData:(NRVioceMessage *)messageModel{
    [super refreshData:messageModel];
    _durationLabel.text = [NSString stringWithFormat:@"%d''",(int)messageModel.second];
    if (messageModel.isMediaPlaying) {
        [_voiceImageView startAnimating];
    } else {
        [_voiceImageView stopAnimating];
    }
    
    if (messageModel.isMediaPlayed) {
        _redView.hidden = YES;
    } else {
        _redView.hidden = NO;
    }
}

@end
