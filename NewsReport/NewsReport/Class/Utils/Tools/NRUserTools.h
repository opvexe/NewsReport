//
//  NRUserTools.h
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NR_UserName @"com.userName"
#define NR_Password @"com.password"
#define NR_UserID   @"com.userID"

@interface NRUserTools : NSObject

/*!
 初始化单利
 */
+ (NRUserTools *)defaultCenter;

/*!
 保存登录用户名
 */
- (void)updateUserName:(NSString *)userName;

/*!
 保存登录密码
 */
- (void)updatePassword:(NSString *)password;

/*!
 用户ID
 */
-(void)updateUserID:(NSString *)userID;



/*!
 * 获取登录用户名
 */
- (NSString *)getUserName;
/*!
 * 获取用户ID
 */
- (NSString *)getUserID;

/*!
 * 获取用户登录密码
 */
- (NSString *)getUserPassword;
@end
