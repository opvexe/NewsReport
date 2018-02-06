//
//  NRIMUserModel.h
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * 用户信息
 */
@interface NRUser : NRBaseModel

/*!
 用户ID
 */
@property(nonatomic, copy) NSString *userId;

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
@property (nonatomic,copy) NSString *mediaId;

/*!
 * 部门
 */
@property (nonatomic,copy) NSString *depId;
/*!
 * 备注
 */
@property (nonatomic, strong) NSString *remarkName;
/*!
 * 精度
 */
@property (nonatomic,copy) NSString *latitude;

/*!
 * 维度
 */
@property (nonatomic,copy) NSString *longitude;


#pragma mark < 列表用 >
/**
 *  拼音
 *
 *  来源：备注 > 昵称 > 用户名
 */
@property (nonatomic, strong) NSString *pinyin;

@property (nonatomic, strong) NSString *pinyinInitial;

@end
