//
//  NRBaseViewController.m
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRBaseViewController.h"
#import "NRTabBarControllerConfig.h"
#import "AppDelegate.h"

@interface NRBaseViewController ()

@end

@implementation NRBaseViewController





-(void)switchRootController{
    NRTabBarControllerConfig  *tabBarControllerConfig = [NRTabBarControllerConfig new];
    [UIApplication sharedApplication].delegate.window.rootViewController = tabBarControllerConfig.tabBarController;
}

@end
