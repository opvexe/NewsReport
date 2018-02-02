//
//  WXAudioRecorder.m
//  WXRecording
//
//  Created by Facebook on 2018/1/29.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "WXAudioRecorder.h"

static WXAudioRecorder *audioRecorderUtil = nil;
@interface WXAudioRecorder () <AVAudioRecorderDelegate> {
    NSDate *_startDate;
    NSDate *_endDate;
    
    void (^recordFinish)(NSString *recordPath);
}
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSDictionary *recordSetting;

@end
@implementation WXAudioRecorder

+(WXAudioRecorder *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioRecorderUtil = [[self alloc] init];
    });
    
    return audioRecorderUtil;
}

-(instancetype)init{
    if (self = [super init]) {}
    return self;
}

+(BOOL)isRecording{
    return [[WXAudioRecorder sharedInstance] isRecording];
}

+ (void)asyncStartRecordingWithPreparePath:(NSString *)aFilePath
                                completion:(void(^)(NSError *error))completion{
    [[WXAudioRecorder sharedInstance] asyncStartRecordingWithPreparePath:aFilePath
                                                              completion:completion];
}

+(void)asyncStopRecordingWithCompletion:(void(^)(NSString *recordPath))completion{
    [[WXAudioRecorder sharedInstance] asyncStopRecordingWithCompletion:completion];
}

+(void)cancelCurrentRecording{
    [[WXAudioRecorder sharedInstance] cancelCurrentRecording];
}

+(AVAudioRecorder *)recorder{
    return [WXAudioRecorder sharedInstance].recorder;
}

- (NSDictionary *)recordSetting
{
    if (!_recordSetting) {
        _recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [NSNumber numberWithFloat: 11025.0],AVSampleRateKey, //采样率mp3不会失真
                          [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                          [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,//采样位数 默认 16
                          [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,//通道的数目 双声道
                          @(AVAudioQualityHigh),AVEncoderAudioQualityKey, ///高的质量
                          nil];
    }
    
    return _recordSetting;
}

-(void)dealloc{
    if (_recorder) {
        _recorder.delegate = nil;
        [_recorder stop];
        [_recorder deleteRecording];
        _recorder = nil;
    }
    recordFinish = nil;
}

-(BOOL)isRecording{
    return !!_recorder;
}

- (void)asyncStartRecordingWithPreparePath:(NSString *)aFilePath
                                completion:(void(^)(NSError *error))completion
{
    NSError *error = nil;
    NSString *wavFilePath = [[aFilePath stringByDeletingPathExtension]
                             stringByAppendingPathExtension:@"wav"];
    NSURL *wavUrl = [[NSURL alloc] initFileURLWithPath:wavFilePath];
    _recorder = [[AVAudioRecorder alloc] initWithURL:wavUrl
                                            settings:self.recordSetting
                                               error:&error];
    if(!_recorder || error)
    {
        _recorder = nil;
        if (completion) {
            error = [NSError errorWithDomain:@"文件格式转换失败"
                                        code:-1
                                    userInfo:nil];
            completion(error);
        }
        return ;
    }
    _startDate = [NSDate date];
    _recorder.meteringEnabled = YES;
    _recorder.delegate = self;
    
    [_recorder record];
    if (completion) {
        completion(error);
    }
}

-(void)asyncStopRecordingWithCompletion:(void(^)(NSString *recordPath))completion{
    recordFinish = completion;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self->_recorder stop];
    });
}

- (void)cancelCurrentRecording
{
    _recorder.delegate = nil;
    if (_recorder.recording) {
        [_recorder stop];
    }
    _recorder = nil;
    recordFinish = nil;
}

#pragma mark < AVAudioRecorderDelegate >
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder
                           successfully:(BOOL)flag
{
    NSString *recordPath = [[_recorder url] path];
    if (recordFinish) {
        if (!flag) {
            recordPath = nil;
        }
        recordFinish(recordPath);
    }
    _recorder = nil;
    recordFinish = nil;
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder
                                   error:(NSError *)error{
    NSLog(@"audioRecorderEncodeErrorDidOccur");
}
@end

