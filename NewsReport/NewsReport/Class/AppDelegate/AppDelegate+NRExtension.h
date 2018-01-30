//
//  AppDelegate+NRExtension.h
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (NRExtension)

/*!
 *  切换根视图
 */
-(void)switchRootController;

/*!
 *  初始化第三方
 */
-(void)registrationThirdLib;

@end
