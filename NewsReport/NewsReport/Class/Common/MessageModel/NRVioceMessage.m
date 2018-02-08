//
//  NRIMSoundElem.m
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRVioceMessage.h"

@implementation NRVioceMessage
@synthesize recFileName = _recFileName;
@synthesize path = _path;
@synthesize url = _url;
@synthesize time = _time;


- (instancetype)init
{
    if (self = [super init]) {
        [self setMessageType:MessageTypeVoice];
    }
    return self;
}

- (NSString *)recFileName
{
    if (_recFileName == nil) {
        _recFileName = [self.content objectForKey:@"path"];
    }
    return _recFileName;
}
- (void)setRecFileName:(NSString *)recFileName
{
    _recFileName = recFileName;
    [self.content setObject:recFileName forKey:@"path"];
}

- (NSString *)path
{
    if (_path == nil) {
        _path = [NSFileManager pathUserChatVoice:self.recFileName];;
    }
    return _path;
}

- (NSString *)url
{
    if (_url == nil) {
        _url = [self.content objectForKey:@"url"];
    }
    return _url;
}
- (void)setUrl:(NSString *)url
{
    _url = url;
    [self.content setObject:url forKey:@"url"];
}

- (CGFloat)time
{
    return [[self.content objectForKey:@"time"] doubleValue];
}
- (void)setTime:(CGFloat)time
{
    [self.content setObject:[NSNumber numberWithDouble:time] forKey:@"time"];
}


- (NSString *)conversationContent
{
    return @"[语音消息]";
}

- (NSString *)messageCopy
{
    return [self.content mj_JSONString];
}


@end
