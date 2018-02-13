//
//  NRMessageViewController.h
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRChatUserProtocol.h"

/*!
 * 会话类
 */
@interface NRChatViewController : NRBaseViewController
/*!
 用户信息
 */
@property (nonatomic, strong) id<NRChatUserProtocol> user;

/*!
 聊天对象
 */
@property (nonatomic, strong) id<NRChatUserProtocol> partner;

@end
