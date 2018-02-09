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




/*!
 * 获取用户通讯录好友列表信息

 @param userID 用户标识
 @param successfull successfull description
 @param failure failure description
 */
+(void)PostContactWithUserID:(NSString *)userID CompleteSuccessfull:(void (^)(id responseObject))successfull  failure:(void (^)(id error))failure;

































#pragma mark  #表情组
/**
 *  精选表情
 */
+(void)requestExpressionChosenListByPageIndex:(NSInteger)page  CompleteSuccessfull:(void (^)(id responseObject))successfull  failure:(void (^)(id error))failure;


/**
 *   精选表情Banner
 */
+(void)requestExpressionChosenBannerCompleteSuccessfull:(void (^)(id responseObject))successfull  failure:(void (^)(id error))failure;

/**
 *  网络表情
 */
+(void)requestExpressionPublicListByPageIndex:(NSInteger)page  CompleteSuccessfull:(void (^)(id responseObject))successfull  failure:(void (^)(id error))failure;

/**
 *  表情搜索
 */
+(void)requestExpressionSearchByKeyword:(NSString *)keyword  CompleteSuccessfull:(void (^)(id responseObject))successfull  failure:(void (^)(id error))failure;

/**
 *  表情详情
 */
+(void)requestExpressionGroupDetailByGroupID:(NSString *)groupID
                                    pageIndex:(NSInteger)pageIndex  CompleteSuccessfull:(void (^)(id responseObject))successfull  failure:(void (^)(id error))failure;

@end
