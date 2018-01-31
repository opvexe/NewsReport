//
//  NRChatTransDataEventImpl.m
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRChatTransDataEventImpl.h"
#import "NRIMElem.h"
#import "ErrorCode.h"

@implementation NRChatTransDataEventImpl

/*!
 * 收到消息回调
 */
- (void) onTransBuffer:(NSString *)fingerPrintOfProtocal withUserId:(NSString *)dwUserid andContent:(NSString *)dataContent andTypeu:(int)typeu{
    NSLog(@"消息类型:[%d]|发送方:%@||消息体:%@||uid+时间戳:%@", typeu, dwUserid, dataContent,fingerPrintOfProtocal);
    NRIMElem *message = [self NRIMMessageBobyType:typeu messageContent:dataContent messageSender:dwUserid messageTime:fingerPrintOfProtocal];
    [NRNotificationCenter postNotificationName:NRIMMessageReceiveConfigurationNotificationCenterKey object:nil userInfo:@{@"key":message}];
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

/*!
 * 包装消息体
 */

-(NRIMElem *)NRIMMessageBobyType:(int)elem messageContent:(NSString *)content messageSender:(NSString *)sender messageTime:(NSString *)fingerPrintOfProtocal{
    
    NSString *type    = convertToString([NSString stringWithFormat:@"%d",elem]);
    NRIMElem *message = [[NRIMElem alloc]init];
    message.sender    = convertToString(sender);
    message.timestamp = convertToString(fingerPrintOfProtocal);             ///uid + 时间戳
    
    if ([type hasPrefix:@"1"]) {    ///单聊
        message.messageChatType = MessageChatSingle;
        switch (elem) {
            case 11:
            {
                message.messageType  = MessageTypeText;
                NRIMTextElem *textElem  = (NRIMTextElem *)message;
                textElem.text = convertToString(content);
            }
                break;
            case 12:
            {
                message.messageType  = MessageTypeImage;
            }
                break;
            case 13:
            {
                message.messageType  = MessageTypeVoice;
            }
                break;
            case 14:
            {
                message.messageType  = MessageTypeVideo;
            }
                break;
                
            default:
            {
                message.messageType  = MessageTypeUnknow;
            }
                break;
        }
    }else if ([type hasPrefix:@"2"]){           ///群聊
        message.messageChatType = MessageChatGroup;
        switch (elem) {
            case 11:
            {
                message.messageType  = MessageTypeText;
                NRIMTextElem *textElem  = (NRIMTextElem *)message;
                textElem.text = convertToString(content);
            }
                break;
            case 12:
            {
                message.messageType  = MessageTypeImage;
            }
                break;
            case 13:
            {
                message.messageType  = MessageTypeVoice;
            }
                break;
            case 14:
            {
                message.messageType  = MessageTypeVideo;
            }
                break;
                
            default:
            {
                message.messageType  = MessageTypeUnknow;
            }
                break;
        }
    }else{
        
        NSLog(@"未知消息");
    }
    
    return message;
}


@end

