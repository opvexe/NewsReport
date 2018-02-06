//
//  NRChatMessageCell.h
//  NewsReport
//
//  Created by Facebook on 2018/1/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRChatMessageContentView.h"
#import "NRTextMessageContentView.h"
#import "NRImageMessageContentView.h"
#import "NRFileMessageContentView.h"
#import "NRVoiceMessageContentView.h"
#import "NRVideoMessageContentView.h"
#import "NRLocationMessageContentView.h"


@protocol NRChatMessageCellDelegate <NSObject>
@optional

/*!
 * 点击消息
 */
- (void)clickCellMessageContentViewWithMessageModel:(NRMessage *)messageModel;
/*!
 * 点击头像
 */
- (void)clickCellHeadImageWithMessageModel:(NRMessage *)messageModel;
/*!
 * 长按消息
 */
- (void)longPressCellMessageContentViewWithMessageModel:(NRMessage *)messageModel;
/*!
 * 撤回消息
 */
- (void)reSendCellWithMessageModel:(NRMessage *)messageModel;
@end

@interface NRChatMessageCell : UITableViewCell <NRChatMessageCellDelegate,NRChatMessageContentViewDelegate>

/*!
 * 代理
 */
@property (weak, nonatomic) id <NRChatMessageCellDelegate> delegate;
/*!
 * 头像
 */
@property (nonatomic, strong) UIImageView *headImageView;
/*!
 * 昵称
 */
@property (nonatomic, strong) UILabel *nameLabel;
/*!
 * 已读
 */
@property (strong, nonatomic) UILabel *hasReadLabel;
/*!
 * 重新发送
 */
@property (strong, nonatomic) UIButton *reSendBtn;
/*!
 * 正在发送
 */
@property (nonatomic, strong) UIActivityIndicatorView *activity;
/*!
 * 内容区域
 */
@property (nonatomic, strong) NRChatMessageContentView *bubbleView;
/*!
 * 消息模型
 */
@property(nonatomic,strong)NRMessage *messageModel;

#pragma mark < 私有方法 >
+ (CGFloat)cellHeightWithModel:(NRMessage *)messageModel;

+ (NSString *)cellIdentifierWithModel:(NRMessage *)messageModel;

- (void)refreshData:(NRMessage *)messageModel;

+(id)CellWithChatTableView:(UITableView *)tableview;

@end

