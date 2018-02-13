//
//  NRChatViewController+Message.h
//  NewsReport
//
//  Created by Facebook on 2018/2/13.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRChatViewController.h"

/*!
 *  会话消息扩展类
 */


@interface NRChatViewController (Message)

/**
 *  发送消息
 */
- (void)sendMessage:(NRMessage *)message;

@end
