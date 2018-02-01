//
//  WXDeviceManager+Microphone.h
//  WXRecording
//
//  Created by Facebook on 2018/1/29.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "WXDeviceManager.h"

@interface WXDeviceManager (Microphone)

/*!
 *   判断麦克风是否可用
 */
- (BOOL)emCheckMicrophoneAvailability;

/*!
 *  获取录制音频时的音量(0~1)
 */
- (double)emPeekRecorderVoiceMeter;
@end
