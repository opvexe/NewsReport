//
//  NRChatTransDataEventImpl.m
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRChatTransDataEventImpl.h"
#import "ErrorCode.h"

@implementation NRChatTransDataEventImpl

/*!
 * 收到消息回调
 */
- (void) onTransBuffer:(NSString *)fingerPrintOfProtocal withUserId:(NSString *)dwUserid andContent:(NSString *)dataContent andTypeu:(int)typeu{
    NSLog(@"[%d]收到来自用户%@的消息:%@", typeu, dwUserid, dataContent);
    
}


/*!
 * 错误回调
 */
- (void) onErrorResponse:(int)errorCode withErrorMsg:(NSString *)errorMsg{
    if(errorCode == ForS_RESPONSE_FOR_UNLOGIN){
        NSString *content = [NSString stringWithFormat:@"服务端会话已失效，自动登陆/重连将启动! (%d)", errorCode];
        NSLog(@"%@",content);
    }else{
        NSString *content = [NSString stringWithFormat:@"Server反馈错误码：%d,errorMsg%@", errorCode, errorMsg];
        NSLog(@"%@",content);
    }
    
}


@end

