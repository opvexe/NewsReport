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
//  ProtocalType.h
//  MibileIMSDK4i_X (MobileIMSDK v3.0 at Summer 2017)
//
//  Created by JackJiang on 14/10/22.
//  Copyright (c) 2017年 52im.net. All rights reserved.
//

/*! @define ProtocalType
 * 协议类型.
 *
 * @author Jack Jiang, 2014-10-22
 * @version 1.0
 */

#ifndef MobileIMSDK4i_ProtocalType_h
#define MobileIMSDK4i_ProtocalType_h


#endif

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - from client
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*! 由客户端发出 - 协议类型：客户端登陆 */
#define FROM_CLIENT_TYPE_OF_LOGIN       0
/*! 由客户端发出 - 协议类型：心跳包 */
#define FROM_CLIENT_TYPE_OF_KEEP_ALIVE  1
/*! 由客户端发出 - 协议类型：发送通用数据 */
#define FROM_CLIENT_TYPE_OF_COMMON_DATA 2
/*! 由客户端发出 - 协议类型：客户端退出登陆 */
#define FROM_CLIENT_TYPE_OF_LOGOUT      3
/*! 由客户端发出 - 协议类型：QoS保证机制中的消息应答包（目前只支持客户端间的QoS机制哦） */
#define FROM_CLIENT_TYPE_OF_RECIVED     4
/*! 由客户端发出 - 协议类型：C2S时的回显指令（此指令目前仅用于测试时） */
#define FROM_CLIENT_TYPE_OF_ECHO        5


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - from server
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*! 由服务端发出 - 协议类型：响应客户端的登陆 */
#define FROM_SERVER_TYPE_OF_RESPONSE_LOGIN      50
/*! 由服务端发出 - 协议类型：响应客户端的心跳包 */
#define FROM_SERVER_TYPE_OF_RESPONSE_KEEP_ALIVE 51
/*! 由服务端发出 - 协议类型：反馈给客户端的错误信息 */
#define FROM_SERVER_TYPE_OF_RESPONSE_FOR_ERROR  52
/*! 由服务端发出 - 协议类型：反馈回显指令给客户端 */
#define FROM_SERVER_TYPE_OF_RESPONSE_ECHO       53


