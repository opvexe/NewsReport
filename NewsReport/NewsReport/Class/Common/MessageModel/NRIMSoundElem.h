//
//  NRIMSoundElem.h
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  语音消息Elem
 */
@interface NRIMSoundElem : NRIMElem

/**
 *  语音文件的路径，接收时使用getSound获得数据
 */
@property(nonatomic,strong) NSString * path;

- (instancetype)initWithMessage:(NRIMElem *)message;
@end
