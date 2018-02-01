//
//  NRFMDataManger.h
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"


typedef void(^DBMangeBlock)(FMDatabase *_db);

@interface NRFMDataManger : NSObject

/*!
 *  初始化
 */
+(instancetype)shareFMDataMange;
/*!
 *  创建数据库
 *
 *  @param isAsynch 是否异步
 */
-(void)creatDBMange:(BOOL )isAsynch dbBlock:( DBMangeBlock )block;

/*!
 *  获取磁盘大小
 */
-(unsigned long long)getFileSize;

/*!
 *  清理数据库
 */
-(void)clearDB;

@end
