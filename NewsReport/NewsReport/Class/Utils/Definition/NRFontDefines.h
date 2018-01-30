//
//  NRFontDefines.h
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#ifndef NRFontDefines_h
#define NRFontDefines_h

/*!
 *  字体
 */

#define FontPingFangSC(Size) [UIFont fontWithName:@"PingFangSC-Regular" size:Size*LSSCALWIDTH]

#define FontPingFangBoldSC(Size) [UIFont fontWithName:@"PingFangSC-Bold" size:Size*LSSCALWIDTH]

#define FontPingFangLG(Size) [UIFont fontWithName:@"PingFangSC-Light" size:Size*LSSCALWIDTH]

#define FontHelFont(Size) [UIFont fontWithName:@"Helvetica" size:Size*LSSCALWIDTH]

#define FontNormal(Size) [UIFont systemFontOfSize:Size*LSSCALWIDTH]

#endif /* NRFontDefines_h */
