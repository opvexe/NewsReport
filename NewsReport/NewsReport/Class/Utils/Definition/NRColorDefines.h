//
//  NRColorDefines.h
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#ifndef NRColorDefines_h
#define NRColorDefines_h

/*!
 *  颜色
 */

#define  ColorRandom  [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]


#define  NRColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

#define   TABARHIGHTLIGHTCOLOR  UIColorFromRGB(0xFF758C)
//主色调
#define   Maser_Color  UIColorFromRGB(0xFF758C)

#define  TABARNORMALCOLOR  UIColorFromRGB(0x646464)

#define  SubheadTitleColor  UIColorFromRGB(0x909090)

#define MainTitle_Color  UIColorFromRGB(0X323232)



//消息
#define MESSAGE_NICKNAME_Color UIColorFromRGB(0X323232)

#define MESSAGE_Describe_Color UIColorFromRGB(0X646464)

#define MESSAGE_Time_Color UIColorFromRGB(0X909090)

#define MESSAGE_Line_Color UIColorFromRGB(0Xeeeeee)

#endif /* NRColorDefines_h */
