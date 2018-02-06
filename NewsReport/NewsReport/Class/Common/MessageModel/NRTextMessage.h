//
//  NRIMTextElem.h
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  文本消息Elem
 */
@interface NRTextMessage : NRMessage

/**
 *  消息文本
 */
@property(nonatomic,copy) NSString *text;

/**
 *  额外消息
 */
@property(nonatomic,copy) NSString *exta;

- (instancetype)initWithMessage:(NRMessage *)message;

@end
