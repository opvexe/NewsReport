//
//  NRConversationListModel.h
//  NewsReport
//
//  Created by Facebook on 2018/1/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRConversationListModel : NRBaseModel
/*!
 * 用户名
 */
@property (nonatomic,copy) NSString *name;

/*!
 * 消息
 */
@property (nonatomic,copy) NSString *signature;

/*!
 * 头像
 */
@property (nonatomic,copy) NSString *portraitUrl;
/*!
 * 时间
 */
@property (nonatomic,copy) NSString *time;
/*!
 * 未读消息数
 */
@property (nonatomic,copy) NSString *badgeValue;
/*!
 * 备注
 */
@property (nonatomic,copy) NSString *remark;

@end

