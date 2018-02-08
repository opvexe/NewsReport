//
//  NRMessageManager+ConversationCache.h
//  NewsReport
//
//  Created by Facebook on 2018/2/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRMessageManager.h"

@interface NRMessageManager (ConversationCache)

/**
 *  增加会话消息
 */
- (BOOL)addConversationByMessage:(NRMessage *)message;

/**
 *  查询会话消息
 */
- (void)conversationRecord:(void (^)(NSArray *))complete;

/**
 *  删除会话消息
 */
- (BOOL)deleteConversationByPartnerID:(NSString *)partnerID;

@end
