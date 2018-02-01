//
//  WXAudioPlayer.m
//  WXRecording
//
//  Created by Facebook on 2018/1/26.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "WXAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

static WXAudioPlayer *audioPlayerUtil = nil;

@interface WXAudioPlayer () <AVAudioPlayerDelegate> {
    AVAudioPlayer *_player;
    void (^playFinish)(NSError *error);
}

@end
@implementation WXAudioPlayer

+ (WXAudioPlayer *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioPlayerUtil = [[self alloc] init];
    });
    return audioPlayerUtil;
}

+ (BOOL)isPlaying{
    return [[WXAudioPlayer sharedInstance] isPlaying];
}

+ (NSString *)playingFilePath{
    return [[WXAudioPlayer sharedInstance] playingFilePath];
}

+ (void)asyncPlayingWithPath:(NSString *)aFilePath
                  completion:(void(^)(NSError *error))completon{
    [[WXAudioPlayer sharedInstance] asyncPlayingWithPath:aFilePath
                                              completion:completon];
}

+ (void)stopCurrentPlaying{
    [[WXAudioPlayer sharedInstance] stopCurrentPlaying];
}

- (BOOL)isPlaying
{
    return !!_player;
}

- (NSString *)playingFilePath
{
    NSString *path = nil;
    if (_player && _player.isPlaying) {
        path = _player.url.path;
    }
    
    return path;
}

- (void)asyncPlayingWithPath:(NSString *)aFilePath
                  completion:(void(^)(NSError *error))completon{
    playFinish = completon;
    NSError *error = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:aFilePath]) {
        error = [NSError errorWithDomain:@"文件路径不存在"
                                    code:-1
                                userInfo:nil];
        if (playFinish) {
            playFinish(error);
        }
        playFinish = nil;
        
        return;
    }
    
    NSURL *wavUrl = [[NSURL alloc] initFileURLWithPath:aFilePath];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:wavUrl error:&error];
    if (error || !_player) {
        _player = nil;
        error = [NSError errorWithDomain:@"初始化AVAudioPlayer失败!"
                                    code:-1
                                userInfo:nil];
        if (playFinish) {
            playFinish(error);
        }
        playFinish = nil;
        return;
    }
    
    _player.delegate = self;
    [_player prepareToPlay];
    [_player play];
}

- (void)stopCurrentPlaying{
    if(_player){
        _player.delegate = nil;
        [_player stop];
        _player = nil;
    }
    if (playFinish) {
        playFinish = nil;
    }
}

- (void)dealloc{
    if (_player) {
        _player.delegate = nil;
        [_player stop];
        _player = nil;
    }
    playFinish = nil;
}

#pragma mark   < AVAudioPlayerDelegate >
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
                       successfully:(BOOL)flag{
    if (playFinish) {
        playFinish(nil);
    }
    if (_player) {
        _player.delegate = nil;
        _player = nil;
    }
    playFinish = nil;
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player
                                 error:(NSError *)error{
    if (playFinish) {
        NSError *error = [NSError errorWithDomain:@"播放失败!"
                                             code:-1
                                         userInfo:nil];
        playFinish(error);
    }
    if (_player) {
        _player.delegate = nil;
        _player = nil;
    }
}

@end

