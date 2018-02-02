//
//  NRIMFileElem.h
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  文件消息Elem
 */

@interface NRIMFileElem : NRIMElem

/**
 *  文件的路径（设置path时，优先上传文件）
 */
@property(nonatomic,strong) NSString * path;


- (instancetype)initWithMessage:(NRIMElem *)message;
@end
