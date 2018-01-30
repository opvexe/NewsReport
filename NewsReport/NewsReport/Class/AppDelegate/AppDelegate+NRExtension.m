//
//  AppDelegate+NRExtension.m
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "AppDelegate+NRExtension.h"
#import "NRLoginViewController.h"
#import "NRTabBarControllerConfig.h"

@implementation AppDelegate (NRExtension)


/*!
 *  切换根视图
 */
-(void)switchRootController{
    
        NRTabBarControllerConfig  *tabBarControllerConfig = [NRTabBarControllerConfig new];
        self.window .rootViewController = tabBarControllerConfig.tabBarController;
//    self.window.rootViewController   = [[NRLoginViewController alloc] init];
}

/*!
 *  初始化第三方
 */
-(void)registrationThirdLib{
    
     [[NRIMClientManager sharedInstance] initMobileIMSDK];
}
@end
