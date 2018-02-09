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

/*!
 * 发送图片消息接口
 */
#define PostUpImageMessageURL            FormatString(@"%@/im/message/uploadFile",HOST_API_URL)


/*!
 * 获取用户通讯录好友列表接口
 */
#define PostContactURL                   FormatString(@"%@/im/member/getAllUserInfoNoSelf",HOST_API_URL)



#define     IEXPRESSION_HOST_URL        @"http://123.57.155.230/ibiaoqing/admin/"
#define     IEXPRESSION_NEW_URL         [IEXPRESSION_HOST_URL stringByAppendingString:@"expre/listBy.do?pageNumber=%ld&status=Y&status1=B"]
#define     IEXPRESSION_BANNER_URL      [IEXPRESSION_HOST_URL stringByAppendingString: @"advertisement/getAll.do?status=on"]
#define     IEXPRESSION_PUBLIC_URL      [IEXPRESSION_HOST_URL stringByAppendingString:@"expre/listBy.do?pageNumber=%ld&status=Y&status1=B&count=yes"]
#define     IEXPRESSION_SEARCH_URL      [IEXPRESSION_HOST_URL stringByAppendingString:@"expre/listBy.do?pageNumber=1&status=Y&eName=%@&seach=yes"]
#define     IEXPRESSION_DETAIL_URL      [IEXPRESSION_HOST_URL stringByAppendingString:@"expre/getByeId.do?pageNumber=%ld&eId=%@"]

#endif /* NR_HOST_APIS_h */
