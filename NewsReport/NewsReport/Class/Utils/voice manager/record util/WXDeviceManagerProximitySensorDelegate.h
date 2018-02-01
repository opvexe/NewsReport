//
//  WXDeviceManagerProximitySensorDelegate.h
//  WXRecording
//
//  Created by Facebook on 2018/1/26.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WXDeviceManagerProximitySensorDelegate <NSObject>

/*!
 * 当手机靠近耳朵时或者离开耳朵时的回调方法
 
 @param isCloseToUser YES为靠近了用户, NO为远离了用户
 */
- (void)proximitySensorChanged:(BOOL)isCloseToUser;

@end
