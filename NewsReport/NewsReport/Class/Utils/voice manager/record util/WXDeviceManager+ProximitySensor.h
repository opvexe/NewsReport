//
//  WXDeviceManager+ProximitySensor.h
//  WXRecording
//
//  Created by Facebook on 2018/1/29.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "WXDeviceManager.h"
@interface WXDeviceManager (ProximitySensor)

@property (nonatomic, readonly) BOOL isSupportProximitySensor;
@property (nonatomic, readonly) BOOL isCloseToUser;
@property (nonatomic, readonly) BOOL isProximitySensorEnabled;

- (BOOL)enableProximitySensor;
- (BOOL)disableProximitySensor;
- (void)sensorStateChanged:(NSNotification *)notification;

@end
