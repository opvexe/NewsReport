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
//  ProtocalQoS4SendProvider.h
//  MibileIMSDK4i_X (MobileIMSDK v3.0 at Summer 2017)
//
//  Created by JackJiang on 14/10/24.
//  Copyright (c) 2017年 52im.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocal.h"
#import "CompletionDefine.h"

/*!
 * QoS机制中提供消息送达质量保证的守护线程。
 * <br>
 * 本类是QoS机制的核心，极端情况下将弥补因UDP协议天生的不可靠性而带来的
 * 丢包情况。
 * <p>
 * 当前MobileIMSDK的QoS机制支持全部的C2C、C2S、S2C共3种消息交互场景下的
 * 消息送达质量保证.
 * 
 * @warning 本线程的启停，目前属于MobileIMSDK算法的一部分，暂时无需也不建议由应用层自行调用。</b>
 * <p>
 * <b>FIXME: </b>按照目前MobileIMSDK通信机制的设计原理，有1种非常极端的情况目前的QoS
 * 重传绝对不会成功，那就是当对方非正常退出，而本地并未及时（在服务会话超时时间内）收到
 * 他下线通知，此时间间隔内发的消息，本地将尝试重传。但对方在重传重试期限内正常登陆也将
 * 绝不会收到，为什么呢？因为对方再次登陆时user_id已经更新成新的了，之前的包记录的发送
 * 目的地还是老user_id。这种情况可以改善，那就是这样的包里还记录它的登陆名，服务端将据
 * user_id尝试给目标发消息，但user_id不存在的情况下（即刚才这种情况）可以用登陆名尝试
 * 找到它的新user_id，从而向新user_id发消息就可以让对方收到了。目前为了最大程度保证算
 * 法的合理性和简洁性暂不实现这个了，好在客户端业务层可无条件判定并提示该消息没有成功发
 * 送，那此种情况在应用层的体验上也是可接受的！
 *
 * @author Jack Jiang, 2014-10-24
 * @version 1.1
 * @since 2.1
 */
@interface ProtocalQoS4SendProvider : NSObject

/// 获取本类的单例。使用单例访问本类的所有资源是唯一的合法途径。
+ (ProtocalQoS4SendProvider *)sharedInstance;

/*!
 * 启动线程。
 * <p>
 * 无论本方法调用前线程是否已经在运行中，都会尝试首先调用 stop 方法，
 * 以便确保线程被启动前是真正处于停止状态，这也意味着可无害调用本方法。
 *
 * @warning 本线程的启停，目前属于MobileIMSDK算法的一部分，暂时无需也不建议由应用层自行调用。
 *
 * @param immediately true表示立即执行线程作业，否则直到 AUTO_RE$LOGIN_INTERVAL
 * 执行间隔的到来才进行首次作业的执行
 */
- (void) startup:(BOOL)immediately;

/*!
 * 无条件中断本线程的运行。
 * 
 * @warning 本线程的启停，目前属于MobileIMSDK算法的一部分，暂时无需也不建议由应用层自行调用。
 */
- (void) stop;

/*!
 * 线程是否正在运行中。
 *
 * @return true表示是，否则线路处于停止状态
 */
- (BOOL) isRunning;

/*!
 * 该包是否已存在于队列中。
 *
 * @param fingerPrint 消息包的特纹特征码（理论上是唯一的）
 * @return
 */
- (BOOL) exist:(NSString *)fingerPrint;

/*!
 * 推入一个消息包的指纹特征码.
 * <br><b>注意：</b>本方法只会将指纹码推入，而不是将整个Protocal对象放入列表中。
 *
 * @param p
 */
- (void) put:(Protocal *)p;

/*!
 * 移除一个消息包.
 * <p>
 * 此操作是在步异线程中完成，目的是尽一切可能避免可能存在的阻塞本类中的守望护线程.
 *
 * @param fingerPrint 消息包的特纹特征码（理论上是唯一的）
 * @return
 */
- (void) remove:(NSString *) fingerPrint;

/*!
 * 队列大小.
 *
 * @return
 * @see HashMap#size()
 */
- (unsigned long) size;

/*!
 *  @Author Jack Jiang, 14-11-07 22:11:28
 *
 *  Just for DEBUG.
 */
- (void) setDebugObserver:(ObserverCompletion)debugObserver;

@end
