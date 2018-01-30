//
//  NRIMClientManager.h
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NRChatBaseEventImpl.h"
#import "NRChatTransDataEventImpl.h"
#import "NRMessageQoSEventImpl.h"

@interface NRIMClientManager : NSObject

/*!
 *  初始化单利
 */
+ (NRIMClientManager *)sharedInstance;

/*!
 *  初始化IMSDK
 */
- (void)initMobileIMSDK;

/*!
 *  释放IMSDK
 */
- (void)releaseMobileIMSDK;

/*!
 *  重置init标识
 */
- (void)resetInitFlag;

/*!
 *  事件回调类
 */
- (NRChatTransDataEventImpl *) getTransDataListener;
- (NRChatBaseEventImpl *) getBaseEventListener;
- (NRMessageQoSEventImpl *) getMessageQoSListener;
@end
