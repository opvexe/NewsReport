//
//  NRMessageQoSEventImpl.m
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRMessageQoSEventImpl.h"

@implementation NRMessageQoSEventImpl

/*!
 * 消息未送达的回调事件通知.
 */
- (void) messagesLost:(NSMutableArray*)lostMessages
{
    NSLog(@"收到系统的未实时送达事件通知，当前共有%li个包QoS保证机制结束，判定为【无法实时送达】！", (unsigned long)[lostMessages count]);
    
}


/*!
 * 消息已被对方收到的回调事件通知.
 */
- (void) messagesBeReceived:(NSString *)theFingerPrint{
    if(theFingerPrint != nil){
        NSLog(@"收到对方已收到消息事件的通知，fp=%@", theFingerPrint);
        [NRNotificationCenter postNotificationName:NRIMMessageReceiveConfigurationNotificationCenterKey object:nil userInfo:@{@"key":theFingerPrint}];
    }
}

@end

