//
//  NRIMFileElem.m
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRFileMessage.h"

@implementation NRFileMessage

- (instancetype)init
{
    if (self = [super init]) {
        [self setMessageType:MessageTypeFile];
    }
    return self;
}





- (NSString *)conversationContent
{
    return @"[文件消息]";
}

- (NSString *)messageCopy
{
    return [self.content mj_JSONString];
}

@end
