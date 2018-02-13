//
//  NRChatViewController+Proxy.h
//  NewsReport
//
//  Created by Facebook on 2018/2/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRChatViewController.h"

@interface NRChatViewController (Proxy)

/**
 *  发送消息
 */
- (void)sendMessage:(NRMessage *)message;

@end
