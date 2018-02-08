//
//  NRConversationListCell.h
//  NewsReport
//
//  Created by Facebook on 2018/1/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRConversation.h"

@interface NRConversationListCell : NRBaseTableViewCell

@property (nonatomic, strong) NRConversation *conversation;

/**
 *  标记为未读
 */
- (void) markAsUnread;

/**
 *  标记为已读
 */
- (void) markAsRead;

@end
