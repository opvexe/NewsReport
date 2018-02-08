//
//  NRIMSoundElem.h
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRVioceMessage : NRMessage

@property (nonatomic, strong) NSString *recFileName;

@property (nonatomic, strong, readonly) NSString *path;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, assign) CGFloat time;

@property (nonatomic, assign) VoiceMessageStatus msgStatus;

//多媒体消息：是否正在播放
@property (nonatomic) BOOL isMediaPlaying;
//多媒体消息：是否播放过
@property (nonatomic) BOOL isMediaPlayed;

@end
