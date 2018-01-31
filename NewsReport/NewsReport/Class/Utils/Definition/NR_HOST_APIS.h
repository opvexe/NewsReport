//
//  NR_HOST_APIS.h
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#ifndef NR_HOST_APIS_h
#define NR_HOST_APIS_h

/*!
 * API接口
 */
#define HOST_API_URL    @"http://124.205.145.238:9001"

/*!
 * 登录接口
 */
#define PostLoginAuthenticationURL      FormatString(@"%@/im/login/Loginvalidate",HOST_API_URL)



#endif /* NR_HOST_APIS_h */
