//
//  WXError.h
//  WXRecording
//
//  Created by Facebook on 2018/1/26.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#ifndef WXError_h
#define WXError_h

/*!
 * 引用扩展
 */
#import "WXDeviceManager+Media.h"
#import "WXDeviceManager+Remind.h"
#import "WXDeviceManager+Microphone.h"
#import "WXDeviceManager+ProximitySensor.h"

/*!
 * 错误信息
 */
#define WXErrorAudioRecordDurationTooShort -100
#define WXErrorFileTypeConvertionFailure -101
#define WXErrorAudioRecordStoping -102
#define WXErrorAudioRecordNotStarted -103

#endif /* WXError_h */
