//
//  NRMessageManager+ConversationCache.m
//  NewsReport
//
//  Created by Facebook on 2018/2/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRMessageManager+ConversationCache.h"
#import "NRMessageManager+MessageCache.h"

@implementation NRMessageManager (ConversationCache)

- (BOOL)addConversationByMessage:(NRMessage *)message{
    NSString *partnerID = message.friendID;
    NSInteger type = 0;
    if (message.partnerType == PartnerTypeGroup) {
        partnerID = message.groupID;
        type = 1;
    }
    BOOL ok = [self.conversationStore addConversationByUid:message.userID fid:partnerID type:type date:message.date];
    
    return ok;
}

- (void)conversationRecord:(void (^)(NSArray *))complete
{
    NSArray *data = [self.conversationStore conversationsByUid:self.userID];
    complete(data);
}

- (BOOL)deleteConversationByPartnerID:(NSString *)partnerID
{
    BOOL ok = [self deleteMessagesByPartnerID:partnerID];
    if (ok) {
        ok = [self.conversationStore deleteConversationByUid:self.userID fid:partnerID];
    }
    return ok;
}

@end
