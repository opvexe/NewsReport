//
//  UIImage+NRExtension.h
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (NRExtension)

/*!
 * 颜色转图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)radius;

/*!
 * 颜色转图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/*!
 * 颜色转图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
