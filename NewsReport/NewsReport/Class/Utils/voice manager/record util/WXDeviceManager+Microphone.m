//
//  WXDeviceManager+Microphone.m
//  WXRecording
//
//  Created by Facebook on 2018/1/29.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "WXDeviceManager+Microphone.h"
#import "WXAudioRecorder.h"

@implementation WXDeviceManager (Microphone)

- (BOOL)emCheckMicrophoneAvailability{
    __block BOOL ret = NO;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if ([session respondsToSelector:@selector(requestRecordPermission:)]) {
        [session performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            ret = granted;
        }];
    } else {
        ret = YES;
    }
    return ret;
}

- (double)emPeekRecorderVoiceMeter{
    double ret = 0.0;
    if ([WXAudioRecorder recorder].isRecording) {
        [[WXAudioRecorder recorder] updateMeters];
        //获取音量的平均值  [recorder averagePowerForChannel:0];
        //音量的最大值  [recorder peakPowerForChannel:0];
        double lowPassResults = pow(10, (0.05 * [[WXAudioRecorder recorder] peakPowerForChannel:0]));
        ret = lowPassResults;
    }
    return ret;
}
@end
