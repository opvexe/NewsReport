//
//  NRTessageProtocol.h
//  NewsReport
//
//  Created by Facebook on 2018/2/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * 消息类型
 */

@protocol NRTessageProtocol <NSObject>

/*!
 * 消息体JSON
 */
- (NSString *)messageCopy;

/*!
 * 消息类型描述[图片]
 */
- (NSString *)conversationContent;

@end
