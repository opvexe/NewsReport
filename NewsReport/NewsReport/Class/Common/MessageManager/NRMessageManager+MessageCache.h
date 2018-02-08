//
//  NRMessageManager+MessageCache.h
//  NewsReport
//
//  Created by Facebook on 2018/2/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRMessageManager.h"

@interface NRMessageManager (MessageCache)

/**
 *  查询聊天记录
 */
- (void)messageRecordForPartner:(NSString *)partnerID
                       fromDate:(NSDate *)date
                          count:(NSUInteger)count
                       complete:(void (^)(NSArray *, BOOL))complete;

/**
 *  查询聊天文件
 */
- (void)chatFilesForPartnerID:(NSString *)partnerID
                    completed:(void (^)(NSArray *))completed;


/**
 *  查询聊天图片
 */
- (void)chatImagesAndVideosForPartnerID:(NSString *)partnerID
                              completed:(void (^)(NSArray *))completed;


/**
 *  删除单条聊天记录
 */
- (BOOL)deleteMessageByMsgID:(NSString *)msgID;

/**
 *  删除与某好友的聊天记录
 */
- (BOOL)deleteMessagesByPartnerID:(NSString *)partnerID;

/**
 *  删除所有聊天记录
 */
- (BOOL)deleteAllMessages;

@end
