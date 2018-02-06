//
//  NSObject+NRSendMessage.h
//  NewsReport
//
//  Created by Facebook on 2018/2/2.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NRMessage.h"

typedef void (^CompletecBlock)(int code);

@interface NSObject (NRSendMessage)
/*!
 * 发送文本消息

 @param text 文本内容
 */
-(void)sendMessageWithText:(NRMessage *)text CompletecBlock:(CompletecBlock)block;



/*!
 * 发送图片消息

 @param image 图片
 @param origal 缩略图
 */
-(void)sendMessageWithImage:(NRMessage *)image isOrignal:(BOOL)origal CompletecBlock:(CompletecBlock)block;


/*!
 * 发送语音消息
 
 @param data 语音二进制文件
 @param dur 语音时长
 */
-(void)sendMessageWithSound:(NSData *)data duration:(NSInteger)dur;


/*！
 * 发送视频消息

 @param videoPath 视频路径
 */
-(void)sendMessageWithVideo:(NSString *)videoPath;


/*！
 * 发送文件消息

 @param filePath 文件路径
 */
- (void)sendMessageWithFilePath:(NSURL *)filePath;


@end
