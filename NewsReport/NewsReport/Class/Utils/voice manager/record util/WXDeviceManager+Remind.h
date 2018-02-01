//
//  WXDeviceManager+Remind.h
//  WXRecording
//
//  Created by Facebook on 2018/1/29.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "WXDeviceManager.h"
#import <AudioToolbox/AudioToolbox.h>
@interface WXDeviceManager (Remind)

/*!
 *  播放接收到新消息时的声音
 */
- (SystemSoundID)playNewMessageSound;

/*!
 *  震动
 */
- (void)playVibration;
@end
