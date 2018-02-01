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

@property (nonatomic,assign) CGSize thumbnailImageSize;

- (instancetype)initWithMessage:(NRIMElem *)message;

@end
