//
//  NRIMClientManager.m
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRIMClientManager.h"
#import "ClientCoreSDK.h"
#import "ConfigEntity.h"

@interface NRIMClientManager ()

/* MobileIMSDK是否已被初始化. true表示已初化完成，否则未初始化. */
@property (nonatomic) BOOL _init;
@property (strong, nonatomic) NRChatBaseEventImpl *baseEventListener;
@property (strong, nonatomic) NRChatTransDataEventImpl *transDataListener;
@property (strong, nonatomic) NRMessageQoSEventImpl *messageQoSListener;

@end
static NRIMClientManager *instance = nil;

@implementation NRIMClientManager

/*!
 *  创建单利
 */
+ (NRIMClientManager *)sharedInstance{
    if (instance == nil)
    {
        instance = [[super allocWithZone:NULL] init];
    }
    return instance;
}

/*!
 *  重写init实例方法实现。
 */
- (id)init{
    if (![super init])
        return nil;
    
    [self initMobileIMSDK];
    
    return self;
}

/*!
 *  初始化IMSDK
 */
- (void)initMobileIMSDK{
    if(!self._init){
        [ConfigEntity registerWithAppKey:@"5418023dfd98c579b6001741"];         // 设置AppKey
        [ConfigEntity setServerIp:@"124.205.145.238"];                         // 设置服务器ip和服务器端口
        [ConfigEntity setServerPort:7901];
        [ClientCoreSDK setENABLED_DEBUG:YES];                                  // 开启DEBUG信息输出
        
        ///MARK:事件回调
        self.baseEventListener = [[NRChatBaseEventImpl alloc] init];
        self.transDataListener = [[NRChatTransDataEventImpl alloc] init];
        self.messageQoSListener = [[NRMessageQoSEventImpl alloc] init];
        [ClientCoreSDK sharedInstance].chatBaseEvent = self.baseEventListener;
        [ClientCoreSDK sharedInstance].chatTransDataEvent = self.transDataListener;
        [ClientCoreSDK sharedInstance].messageQoSEvent = self.messageQoSListener;
        
        self._init = YES;
    }
}

/*!
 *  释放IMSDK
 */
- (void)releaseMobileIMSDK{
    [[ClientCoreSDK sharedInstance] releaseCore];
    [self resetInitFlag];
}

/*!
 *  重置init标识
 */
- (void)resetInitFlag{
    self._init = NO;
}


- (NRChatTransDataEventImpl *) getTransDataListener
{
    return self.transDataListener;
}
- (NRChatBaseEventImpl *) getBaseEventListener
{
    return self.baseEventListener;
}
- (NRMessageQoSEventImpl *) getMessageQoSListener
{
    return self.messageQoSListener;
}

@end
