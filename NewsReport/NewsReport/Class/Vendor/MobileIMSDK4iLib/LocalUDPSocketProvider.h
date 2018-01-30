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
//  LocalUDPSocketProvider.h
//  MibileIMSDK4i_X (MobileIMSDK v3.0 at Summer 2017)
//
//  Created by JackJiang on 14/10/22.
//  Copyright (c) 2017年 52im.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncUdpSocket.h"
#import "CompletionDefine.h"

/*!
 * 本地 UDP Socket 实例封装实用类。
 * <p>
 * 本类提供存取本地UDP Socket通信对象引用的方便方法，封装了
 * Socket有效性判断以及异常处理等，以便确保调用者通过方法 {@link #getLocalUDPSocket()}
 * 拿到的Socket对象是健康有效的。
 * <p>
 * 依据作者对MobileIMSDK API的设计理念，本类将以单例的形式提供给调用者使用。
 *
 * @author Jack Jiang, 2014-10-22
 * @version 1.0
 * @since 2.1
 */
@interface LocalUDPSocketProvider : NSObject <GCDAsyncUdpSocketDelegate>

/// 获取本类的单例。使用单例访问本类的所有资源是唯一的合法途径。
+ (LocalUDPSocketProvider *)sharedInstance;

/*!
 * 重置并新建一个全新的Socket对象。
 *
 * @return 新建的全新Socket对象引用
 * @see GCDAsyncUdpSocket
 * @see [ConfigEntity getLocalUDPPort]
 */
- (GCDAsyncUdpSocket *)resetLocalUDPSocket;

/*!
 * 获得本地UDPSocket的实例引用.
 * <p>
 * 本方法内封装了Socket有效性判断以及异常处理等，以便确保调用者通过本方法
 * 拿到的Socket对象是健康有效的。
 *
 * @return 如果该实例正常则返回它的引用，否则返回null
 * @see [LocalUDPSocketProvider isLocalUDPSocketReady]
 * @see [LocalUDPSocketProvider resetLocalUDPSocket]
 */
- (GCDAsyncUdpSocket *) getLocalUDPSocket;

/*!
 * 设置UDP Socket连接结果事件观察者.
 * 注意：此回调一旦设置后只会被调用一次，即无论是被"- (void)udpSocket:didConnectToAddress:"还是“- (void)udpSocket:didNotConnect:”调用，都将在调用完成后被置nil.
 *
 * @param networkConnectionLostObserver
 */
- (void) setConnectionObserver:(ConnectionCompletion)connObserver;

/*!
 *  @Author Jack Jiang, 14-10-27 17:10:47
 *
 *  尝试连接指定的socket.
 *  <p>
 *  UDP是无连接的，此处的连接何解？此处的连接仅是逻辑意义上的操作，实施方法实际动作是进行状态设置等
 *  操作，而带来的方便是每次send数据时就无需再指明主机和端口了.
 *  <p>
 *  本框架中，在发送数据前，请首先确保isConnected == YES。
 *  <p>
 *  一个注意点是：此connect实际上是异步的，真正意义上能连接上目标主机需等到真正的IMAP包到来。但此机
 *  无需等到异步返回，只需保证coonect从形式上成功即可，即使连接不上主机后绪的QoS保证等机制也会起到错
 *  误告之等。
 *
 *  @param errPtr 本参数为Error的地址，本方法执行返回时如有错误产生则不为空，否则为nil
 *  @param finish 连接结果回调
 *
 *  @return 0 表示connect的意图是否成功发出（实际上真正连接是通过异常的delegate方法回来的，不在此方法考虑之列），否则表示错误码
 *  @see GCDAsyncUdpSocket, ConnectionCompletion
 */
- (int)tryConnectToHost:(NSError **)errPtr withSocket:(GCDAsyncUdpSocket *)skt completion:(ConnectionCompletion)finish;

/*!
 * 本类中的Socket对象是否是健康的。
 *
 * @return true表示是健康的，否则不是
 */
- (BOOL) isLocalUDPSocketReady;

/*!
 * 强制关闭本地UDP Socket侦听。
 * <p>
 * 一旦调用本方法后，再次调用[LocalUDPSocketProvider getLocalUDPSocket]将会返回一个全新的Socket对象引用。
 * <p>
 * <b>本方法通常在两个场景下被调用：</b><br>
 * 1) 真正需要关闭Socket时（如所在的APP通出时）；<br>
 * 2) 当调用者检测到网络发生变动后希望重置以便获得健康的Socket引用对象时。
 *
 * @see [GCDAsyncUdpSocket close]
 */
- (void) closeLocalUDPSocket;

@end
