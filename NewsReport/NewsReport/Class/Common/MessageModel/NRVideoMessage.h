//
//  NRIMVideoElem.h
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRMessage.h"

@interface NRVideoMessage : NRMessage

@property (nonatomic, strong, readonly) NSString *videoPath;

@property (nonatomic, strong) NSString *videoURL;

@property (nonatomic, strong, readonly) NSString *imagePath;                  // 本地图片Path

@property (nonatomic, strong) NSString *imageURL;                   // 网络图片URL

@property (nonatomic, assign) CGSize imageSize;

//多媒体消息：是否正在播放
@property (nonatomic) BOOL isMediaPlaying;
//多媒体消息：是否播放过
@property (nonatomic) BOOL isMediaPlayed;

@end
