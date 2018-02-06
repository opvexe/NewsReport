//
//  NRChatMessageContentView.h
//  NewsReport
//
//  Created by Facebook on 2018/1/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NRChatMessageContentViewDelegate <NSObject>

@optional
/*!
 * 点击消息
 */
- (void)clickMessageContentViewWithMessageModel:(NRMessage *)messageModel;

/*!
 * 长按消息
 */
- (void)longPressMessageContentViewWithMessageModel:(NRMessage *)messageModel;

@end
@interface NRChatMessageContentView : UIControl<NRChatMessageContentViewDelegate>
/*!
 * 代理
 */
@property (nonatomic,weak) id <NRChatMessageContentViewDelegate> delegate;

/*!
 * 背景泡泡
 */
@property (nonatomic,strong) UIImageView * bgImgView;

/*!
 * 消息模型
 */
@property (nonatomic, strong) NRMessage *messageModel;

#pragma mark < 私有方法 >
- (void)refreshData:(NRMessage *)messageModel;
@end

