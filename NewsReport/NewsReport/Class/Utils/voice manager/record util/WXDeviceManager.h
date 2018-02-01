//
//  WXDeviceManager.h
//  WXRecording
//
//  Created by Facebook on 2018/1/29.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXDeviceManagerProximitySensorDelegate.h"

@interface WXDeviceManager : NSObject
{
    NSDate              *_recorderStartDate;
    NSDate              *_recorderEndDate;
    NSString            *_currCategory;
    BOOL                _currActive;
    
    
    BOOL _isSupportProximitySensor;
    BOOL _isCloseToUser;
}

@property (nonatomic, assign) id <WXDeviceManagerProximitySensorDelegate> delegate;

+(WXDeviceManager *)sharedInstance;
@end
