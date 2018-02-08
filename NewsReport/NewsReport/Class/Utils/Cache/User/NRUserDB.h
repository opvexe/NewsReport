//
//  NRUserInfoDB.h
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NRUser;

@interface NRUserDB : NSObject

/*!
 *  初始化单利
 */
+(instancetype)shareDB;
/*!
 *  存储数据
 */
-(BOOL)saveModel:(NRUser *)model;
/*!
 *  删除数据
 */
-(BOOL)delModelWithGid:(NSString * )gid;

/*!
 *  查找数据
 */
-(NRUser *)findWithGid:(NSString * )gid;

/*!
 *  保存数据(数组)
 */
-(BOOL)saveDataSocre:(NSArray*)dataSoucre;

/*!
 *  查找数据
 */
-(NSMutableArray*)findAllModel;
/*!
 *  删除表
 */
-(BOOL )clearTable;
@end
