//
//  NRIMImageElem.h
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  图片消息Elem
 */
@interface NRIMImageElem : NRIMElem

/**
 *  接收图片地址
 */
@property (nonatomic,copy) NSString *imageUrl;

- (instancetype)initWithMessage:(NRIMElem *)message;

@end
