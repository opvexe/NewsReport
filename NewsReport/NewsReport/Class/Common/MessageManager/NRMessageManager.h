//
//  NRMessageManager.h
//  NewsReport
//
//  Created by Facebook on 2018/2/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NRDBConversationStore.h"
#import "NRDBMessageStore.h"

/*!
 * 消息管理类
 */

@interface NRMessageManager : NSObject

/*!
 * 消息管理单利类
 */
+ (NRMessageManager *)sharedInstance;

/*!
 * 发送消息
 */
- (void)sendMessage:(NRMessage *)message
           progress:(void (^)(NRMessage *, CGFloat))progress
            success:(void (^)(NRMessage *))success
            failure:(void (^)(NRMessage *))failure;

/*!
 * 消息ID
 */
@property (nonatomic, strong, readonly) NSString *userID;

/*!
 * 消息本地存储类
 */
@property (nonatomic, strong) NRDBMessageStore *messageStore;

/*!
 * 会话本地存储类
 */
@property (nonatomic, strong) NRDBConversationStore *conversationStore;
@end
