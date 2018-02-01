//
//  WXDeviceManager+Media.h
//  WXRecording
//
//  Created by Facebook on 2018/1/29.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "WXDeviceManager.h"

typedef NS_ENUM(NSInteger, EMAudioSession){
    EM_DEFAULT = 0,
    EM_AUDIOPLAYER,
    EM_AUDIORECORDER
};
@interface WXDeviceManager (Media)
/*！
 * 播放音频
 */
- (void)asyncPlayingWithPath:(NSString *)aFilePath
                  completion:(void(^)(NSError *error))completon;
/*！
 * 停止播放
 */
- (void)stopPlaying;

- (void)stopPlayingWithChangeCategory:(BOOL)isChange;
/*！
 * 当前是否正常播放
 */
-(BOOL)isPlaying;
/*！
 * 开始录音
 */
- (void)asyncStartRecordingWithFileName:(NSString *)fileName
                             completion:(void(^)(NSError *error))completion;

/*！
 * 停止录音
 */
-(void)asyncStopRecordingWithCompletion:(void(^)(NSString *recordPath,
                                                 NSInteger aDuration,
                                                 NSError *error))completion;
/*！
 * 取消录音
 */
-(void)cancelCurrentRecording;


// 当前是否正在录音
-(BOOL)isRecording;
@end
