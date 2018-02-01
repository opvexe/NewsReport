//
//  NRIMVideoElem.h
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRIMElem.h"

@interface NRIMVideoElem : NRIMElem

@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) UIImage *thumbnailImage;

@property (strong, nonatomic) NSString *fileURLPath;
@end
