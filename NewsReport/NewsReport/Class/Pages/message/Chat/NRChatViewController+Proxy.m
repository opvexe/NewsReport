//
//  NRChatViewController+Proxy.m
//  NewsReport
//
//  Created by Facebook on 2018/2/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRChatViewController+Proxy.h"
#import "NRMessageManager.h"

@implementation NRChatViewController (Proxy)

/**
 *  发送消息
 */
- (void)sendMessage:(NRMessage *)message{
    
    message.ownerTyper = MessageOwnerSelf;
    message.userID = [[NRUserHelper defaultCenter] getUserID];      ///发送ID
    message.fromUser = (id<NRChatUserProtocol>)[[NRUserDB shareDB]findWithGid:[[NRUserHelper defaultCenter] getUserID]]; //发送者
    message.date = [NSDate date];
    
    if ([self.partner chat_userType] == ChatUserTypeUser) {
        
        message.partnerType = PartnerTypeUser;
        message.friendID = [self.partner chat_userID];
        
    }else{
        
        message.partnerType = PartnerTypeGroup;
        message.groupID = [self.partner chat_userID];
    }
    
    [[NRMessageManager sharedInstance] sendMessage:message progress:^(NRMessage * message, CGFloat pregress) {
        
    } success:^(NRMessage * message) {
        
        NSLog(@"send success");
    } failure:^(NRMessage * message) {
        
        NSLog(@"send failure");
    }];
}


@end
