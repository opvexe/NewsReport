//
//  NRBusinessNetworkTool.h
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRBusinessNetworkTool : NSObject

/*!
 * 用户登录API

 @param password 密码
 @param username 用户注册名
 @param successfull successfull description
 @param failure failure description
 */
+(void)PostLoginWithUserPassword:(NSString *)password username:(NSString *)username CompleteSuccessfull:(void (^)(id responseObject))successfull  failure:(void (^)(id error))failure;


@end
