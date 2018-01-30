//
//  NRChatBaseEventImpl.m
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRChatBaseEventImpl.h"

@implementation NRChatBaseEventImpl


/*!
 * 本地用户的登陆结果回调事件通知。
 *
 * @param dwErrorCode 服务端反馈的登录结果：0 表示登陆成功，否则为服务端自定义的出错代码（按照约定通常为>=1025的数）
 */
- (void) onLoginMessage:(int) dwErrorCode{
    if (dwErrorCode == COMMON_CODE_OK) {
        NSLog(@"IM服务器登录/连接成功！");
    }else{
        NSLog(@"IM服务器登录/连接失败，错误代码：%d", dwErrorCode);
    }
    [NRNotificationCenter postNotificationName:NRIMMessageLoginStatusConfigurationNotificationCenterKey object:nil userInfo:@{@"key":[NSNumber numberWithInt:dwErrorCode]}];
}

/*!
 * 与服务端的通信断开的回调事件通知。
 */
- (void) onLinkCloseMessage:(int)dwErrorCode{
    NSLog(@"与IM服务器的连接已断开, 自动登陆/重连将启动!，error：%d", dwErrorCode);
    [NRNotificationCenter postNotificationName:NRIMMessageLinkStatusConfigurationNotificationCenterKey object:nil userInfo:@{@"key":[NSNumber numberWithInt:dwErrorCode]}];
}


@end

