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
//  LocalUDPDataReciever.h
//  MibileIMSDK4i_X (MobileIMSDK v3.0 at Summer 2017)
//
//  Created by JackJiang on 14/10/27.
//  Copyright (c) 2017年 52im.net. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * 数据接收处理独立线程。
 * <p>
 * 主要工作是将收到的数据进行解析并按MobileIMSDK框架的协议进行调度和处理。
 * 本类是MobileIMSDK框架数据接收处理的唯一实现类，也是整个框架算法最为关
 * 键的部分。
 * <p>
 * <b>本线程的启停，目前属于MobileIMSDK算法的一部分，暂时无需也不建议由应用层自行调用。</b>
 *
 * @author Jack Jiang, 2014-10-27
 * @version 1.0
 * @since 2.1
 */
@interface LocalUDPDataReciever : NSObject

/// 获取本类的单例。使用单例访问本类的所有资源是唯一的合法途径。
+ (LocalUDPDataReciever *)sharedInstance;

/*!
 *  解析收到的原始消息数据并按照MobileIMSDK定义的协议进行调度和处理。
 *  <p>
 *  本方法目前由 LocalUDPSocketProvider 自动调用。
 *
 *  @param originalProtocalJSONData 收到的MobileIMSDK框架原始通信报文数据内容
 *  @see LocalUDPSocketProvider
 */
- (void) handleProtocal:(NSData *)originalProtocalJSONData;

@end
