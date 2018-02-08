//
//  NRMessageManager.m
//  NewsReport
//
//  Created by Facebook on 2018/2/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRMessageManager.h"
#import "NRMessageManager+ConversationCache.h"

static NRMessageManager *messageManager;

@implementation NRMessageManager

+ (NRMessageManager *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        messageManager = [[NRMessageManager alloc] init];
    });
    return messageManager;
}



/*!
 * 发送消息
 */
- (void)sendMessage:(NRMessage *)message
           progress:(void (^)(NRMessage *, CGFloat))progress
            success:(void (^)(NRMessage *))success
            failure:(void (^)(NRMessage *))failure{
    
    BOOL ok = [self.messageStore addMessage:message];
    if (!ok) {
        NSLog(@"存储Message到DB失败");
    }else {      // 存储到conversation
        ok = [self addConversationByMessage:message];
        if (!ok) {
            NSLog(@"存储Conversation到DB失败");
        }
    }
    
}

- (NRDBMessageStore *)messageStore
{
    if (_messageStore == nil) {
        _messageStore = [[NRDBMessageStore alloc] init];
    }
    return _messageStore;
}

- (NRDBConversationStore *)conversationStore
{
    if (_conversationStore == nil) {
        _conversationStore = [[NRDBConversationStore alloc] init];
    }
    return _conversationStore;
}

- (NSString *)userID
{
    return [[NRUserHelper defaultCenter]getUserID];
}

@end
