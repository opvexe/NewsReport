//
//  NRConversation.m
//  NewsReport
//
//  Created by Facebook on 2018/2/5.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRConversation.h"

@implementation NRConversation

- (void)setConvType:(ConversationType)convType{
    _convType = convType;
    switch (convType) {
        case ConversationTypeSingle:
        case ConversationTypeGroup:
            _clueType = ClueTypePointWithNumber;
            break;
        case ConversationTypePublic:
        case ConversationTypeServerGroup:
            _clueType = ClueTypePoint;
            break;
        default:
            break;
    }
}

- (BOOL)isRead{
    return self.unreadCount == 0;
}

@end
