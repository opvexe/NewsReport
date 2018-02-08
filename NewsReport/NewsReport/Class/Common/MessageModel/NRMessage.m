//
//  NRIMElem.m
//  NewsReport
//
//  Created by Facebook on 2018/1/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRMessage.h"

@implementation NRMessage

+ (NRMessage *)createMessageByType:(MessageType)type{
    NSString *className;
    if (type == MessageTypeText) {
        className = @"NRTextMessage";
    }
    else if (type == MessageTypeImage) {
        className = @"NRImageMessage";
    }
    else if (type == MessageTypeFile) {
        className = @"NRFileMessage";
    }
    else if (type == MessageTypeVideo) {
        className = @"NRVideoMessage";
        
    }else if (type == MessageTypeVoice){
        className = @"NRVioceMessage";
        
    }else if (type == MessageTypeLocation){
        className = @"NRLocationMessage";
    }
    if (className) {
        return [[NSClassFromString(className) alloc] init];
    }
    return nil;
}

- (id)init{         ///消息标识 uid +时间戳
    if (self = [super init]) {
        self.messageID = [NSString stringWithFormat:@"%@+%lld", convertToString(self.userID),(long long)([[NSDate date] timeIntervalSince1970] * 10000)];
    }
    return self;
}


- (NSMutableDictionary *)content{
    if (_content == nil) {
        _content = [[NSMutableDictionary alloc] init];
    }
    return _content;
}


#pragma mark < NRTessageProtocol >
- (NSString *)messageCopy{
        return @"子类未定义";
}

- (NSString *)conversationContent{
        return @"子类未定义";
}
@end


