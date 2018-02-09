//
//  NRConversation.h
//  NewsReport
//
//  Created by Facebook on 2018/2/5.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  消息会话类
 */

@interface NRConversation : NRBaseModel

/**
 *  会话类型（个人，讨论组，企业号）
 */
@property (nonatomic, assign) ConversationType convType;

/**
 *  用户ID
 */
@property (nonatomic, strong) NSString *partnerID;

/**
 *  用户名
 */
@property (nonatomic, strong) NSString *partnerName;

/**
 *  头像地址（网络）
 */
@property (nonatomic, strong) NSString *avatarURL;

/**
 *  头像地址（本地）
 */
@property (nonatomic, strong) NSString *avatarPath;

/**
 *  时间
 */
@property (nonatomic, strong) NSDate *date;

/**
 *  消息展示内容
 */
@property (nonatomic, strong) NSString *content;

/**
 *  提示红点类型
 */
@property (nonatomic, assign, readonly) ClueType clueType;

/**
 *  未读已读
 */
@property (nonatomic, assign, readonly) BOOL isRead;

/**
 *  未读数量
 */
@property (nonatomic, assign) NSInteger unreadCount;

@end
