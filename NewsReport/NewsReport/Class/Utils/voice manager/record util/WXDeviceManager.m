//
//  WXDeviceManager.m
//  WXRecording
//
//  Created by Facebook on 2018/1/29.
//  Copyright © 2018年 Facebook. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "WXDeviceManager.h"
#import "WXDeviceManager+ProximitySensor.h"

static WXDeviceManager *emCDDeviceManager;
@implementation WXDeviceManager


+(WXDeviceManager *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        emCDDeviceManager = [[WXDeviceManager alloc] init];
    });
    
    return emCDDeviceManager;
}

-(instancetype)init{
    if (self = [super init]) {
        [self _setupProximitySensor];
        [self registerNotifications];
    }
    return self;
}

- (void)registerNotifications
{
    [self unregisterNotifications];
    if (_isSupportProximitySensor) {
        static NSString *notif = @"UIDeviceProximityStateDidChangeNotification";
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(sensorStateChanged:)
                                                     name:notif
                                                   object:nil];
    }
}

- (void)unregisterNotifications {
    if (_isSupportProximitySensor) {
        static NSString *notif = @"UIDeviceProximityStateDidChangeNotification";
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:notif
                                                      object:nil];
    }
}

- (void)_setupProximitySensor
{
    UIDevice *device = [UIDevice currentDevice];
    [device setProximityMonitoringEnabled:YES];
    _isSupportProximitySensor = device.proximityMonitoringEnabled;
    if (_isSupportProximitySensor) {
        [device setProximityMonitoringEnabled:NO];
    } else {
        
    }
}

@end
