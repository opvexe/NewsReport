//
//  NRMessageViewController.h
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 * 会话类
 */
@interface NRChatViewController : NRBaseViewController
/*!
 目标会话ID
 */
@property(nonatomic, strong) NSString *targetId;
/*!
 目标会话名字
 */
@property (nonatomic,copy) NSString *userName;

@end
