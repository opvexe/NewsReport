//  ----------------------------------------------------------------------
//  Copyright (C) 2017  即时通讯网(52im.net) & Jack Jiang.
//  The MobileIMSDK_X (MobileIMSDK v3.x) Project.
//  All rights reserved.
//
//  > Github地址: https://github.com/JackJiang2011/MobileIMSDK
//  > 文档地址: http://www.52im.net/forum-89-1.html
//  > 即时通讯技术社区：http://www.52im.net/
//  > 即时通讯技术交流群：320837163 (http://www.52im.net/topic-qqgroup.html)
//
//  "即时通讯网(52im.net) - 即时通讯开发者社区!" 推荐开源工程。
//
//  如需联系作者，请发邮件至 jack.jiang@52im.net 或 jb2011@163.com.
//  ----------------------------------------------------------------------
//
//  ErrorCode.h
//  MibileIMSDK4i_X (MobileIMSDK v3.0 at Summer 2017)
//
//  Created by JackJiang on 14/10/21.
//  Copyright (c) 2017年 52im.net. All rights reserved.
//

/*! @define ErrorCode
 *  错误码常量表.
 *  <br>
 *  建议 0~1024 范围内的错误码作为IM核心框架保留，业务层请使用 >1024 的码表示！
 */

#ifndef MobileIMSDK4i_ErrorCode_h
#define MobileIMSDK4i_ErrorCode_h


#endif


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 客户端本地使用地一些通用编码约定
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*! 一切正常 */
#define COMMON_CODE_OK          0
/*! 客户端尚未登陆 */
#define COMMON_NO_LOGIN         1
/*! 未知错误 */
#define COMMON_UNKNOW_ERROR     2
/*! 数据发送失败 */
#define COMMON_DATA_SEND_FAILD  3
/*! 无效的 {@link Protocal}对象 */
#define COMMON_INVALID_PROTOCAL 4


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 由客户端产生的错误码
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*! 与服务端的连接已断开 */
#define ForC_BREOKEN_CONNECT_TO_SERVER      201
/*! 与服务端的网络连接失败 */
#define ForC_BAD_CONNECT_TO_SERVER          202
/*! 客户端SDK尚未初始化 */
#define ForC_CLIENT_SDK_NO_INITIALED        203
/*! 本地网络不可用（未打开） */
#define ForC_LOCAL_NETWORK_NOT_WORKING      204
/*! 要连接的服务端网络参数未设置 */
#define ForC_TO_SERVER_NET_INFO_NOT_SETUP   205


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 由服务端产生的错误码
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*! 客户端尚未登陆，请重新登陆 */
#define ForS_RESPONSE_FOR_UNLOGIN 301





