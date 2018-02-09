//
//  NRIMLocationElem.m
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRLocationMessage.h"

@implementation NRLocationMessage







- (NSString *)conversationContent
{
    return @"[定位消息]";
}

- (NSString *)messageCopy
{
    return [self.content mj_JSONString];
}

@end
