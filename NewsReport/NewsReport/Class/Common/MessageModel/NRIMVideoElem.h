//
//  NRIMVideoElem.h
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRIMElem.h"

@interface NRIMVideoElem : NRIMElem


/**
 *  视频的路径（设置path时，优先上传文件）
 */
@property (strong, nonatomic) NSString *fileURLPath;

- (instancetype)initWithMessage:(NRIMElem *)message;

@end
