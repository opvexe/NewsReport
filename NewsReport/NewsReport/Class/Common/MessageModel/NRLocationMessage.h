//
//  NRIMLocationElem.h
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRMessage.h"

@interface NRLocationMessage : NRMessage

/**
 *  定位地址
 */
@property (nonatomic,copy) NSString *address;


- (instancetype)initWithMessage:(NRMessage *)message;
@end
