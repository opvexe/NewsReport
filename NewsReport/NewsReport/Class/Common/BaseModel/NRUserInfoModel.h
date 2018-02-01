//
//  NRIMUserModel.h
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * 当前用户信息
 */
@interface NRUserInfoModel : NSObject

/*!
 用户ID
 */
@property(nonatomic, assign) NSInteger userId;

/*!
 用户名称
 */
@property(nonatomic, copy) NSString *nickName;

/*!
 用户手机号
 */
@property (nonatomic,copy) NSString *tel;

/*!
 用户头像的URL
 */
@property(nonatomic, copy) NSString *userIcon;

/*!
 用户Token
 */
@property (nonatomic,copy) NSString *token;

/*!
 登录用户名
 */
@property (nonatomic,copy) NSString *userName;

/*!
 * 视频ID
 */
@property (nonatomic,assign) NSInteger mediaId;

/*!
 * 部门
 */
@property (nonatomic,assign) NSInteger depId;

/*!
 * 精度
 */
@property (nonatomic,assign) float latitude;

/*!
 * 维度
 */
@property (nonatomic,assign) float longitude;

@end
