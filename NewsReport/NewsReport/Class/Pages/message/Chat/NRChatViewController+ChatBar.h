//
//  NRChatViewController+ChatBar.h
//  NewsReport
//
//  Created by Facebook on 2018/2/13.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRChatViewController.h"

/*!
 *  会话键盘扩展类
 */

@interface NRChatViewController (ChatBar)<ChatKeyBoardDelegate,ChatKeyBoardDataSource,WXDeviceManagerProximitySensorDelegate>

@end
