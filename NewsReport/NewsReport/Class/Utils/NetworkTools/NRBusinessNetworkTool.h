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





/*!
 *  上传图片消息

 @param image 压缩后图片
 @param imageName 图片名称
 @param imageType 图片类型
 @param successfull successfull description
 @param failure failure description
 */
+(void)PostUpMessageWithImage:(UIImage *)image withImageName:(NSString *)imageName withImageType:(NSString *)imageType CompleteSuccessfull:(void (^)(id responseObject))successfull  failure:(void (^)(id error))failure;

@end
