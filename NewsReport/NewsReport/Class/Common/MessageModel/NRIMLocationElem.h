//
//  NRIMLocationElem.h
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRIMElem.h"

@interface NRIMLocationElem : NRIMElem

/**
 *  定位地址
 */
@property (nonatomic,copy) NSString *address;


- (instancetype)initWithMessage:(NRIMElem *)message;
@end
