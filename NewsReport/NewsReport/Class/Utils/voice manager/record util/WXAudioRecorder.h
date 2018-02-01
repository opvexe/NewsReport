//
//  WXAudioRecorder.h
//  WXRecording
//
//  Created by Facebook on 2018/1/29.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
/*！
 * 音频录制类
 */
@interface WXAudioRecorder : NSObject

/*！
 *  当前是否正在录音
 */
+(BOOL)isRecording;

/*！
 * 开始录音
 */
+ (void)asyncStartRecordingWithPreparePath:(NSString *)aFilePath
                                completion:(void(^)(NSError *error))completion;

/*！
 * 停止录音
 */
+(void)asyncStopRecordingWithCompletion:(void(^)(NSString *recordPath))completion;

/*！
 * 取消录音
 */
+(void)cancelCurrentRecording;


+(AVAudioRecorder *)recorder;

@end
