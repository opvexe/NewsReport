//
//  NRDBConversationStore.h
//  NewsReport
//
//  Created by Facebook on 2018/2/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRDBBaseStore.h"

@interface NRDBConversationStore : NRDBBaseStore

/**
 *  新的会话（未读）
 */
- (BOOL)addConversationByUid:(NSString *)uid fid:(NSString *)fid type:(NSInteger)type date:(NSDate *)date;

/**
 *  更新会话状态（已读）
 */
- (void)updateConversationByUid:(NSString *)uid fid:(NSString *)fid;

/**
 *  查询所有会话
 */
- (NSArray *)conversationsByUid:(NSString *)uid;

/**
 *  未读消息数
 */
- (NSInteger)unreadMessageByUid:(NSString *)uid fid:(NSString *)fid;

/**
 *  删除单条会话
 */
- (BOOL)deleteConversationByUid:(NSString *)uid fid:(NSString *)fid;

/**
 *  删除用户的所有会话
 */
- (BOOL)deleteConversationsByUid:(NSString *)uid;

@end
