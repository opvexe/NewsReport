//
//  WXAudioPlayer.h
//  WXRecording
//
//  Created by Facebook on 2018/1/26.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

/*！
 * 音频播放类
 */
@interface WXAudioPlayer : NSObject

/*!
 * 当前是否正在播放
 */
+ (BOOL)isPlaying;

/*!
 * 播放音频路径
 */
+ (NSString *)playingFilePath;

/*!
 * 播放音频路径(wav)
 */
+ (void)asyncPlayingWithPath:(NSString *)aFilePath
                  completion:(void(^)(NSError *error))completon;

/*!
 * 停止播放音频
 */
+ (void)stopCurrentPlaying;

@end
