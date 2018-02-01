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
#import "NRShareMessageContentView.h"
#import "NRLocationMessageContentView.h"
#import "NRRedMoneyMessageContentView.h"


@protocol NRChatMessageCellDelegate <NSObject>
@optional

/*!
 * 点击消息
 */
- (void)clickCellMessageContentViewWithMessageModel:(NRIMElem *)messageModel;
/*!
 * 点击头像
 */
- (void)clickCellHeadImageWithMessageModel:(NRIMElem *)messageModel;
/*!
 * 长按消息
 */
- (void)longPressCellMessageContentViewWithMessageModel:(NRIMElem *)messageModel;
/*!
 * 撤回消息
 */
- (void)reSendCellWithMessageModel:(NRIMElem *)messageModel;
@end

@interface NRChatMessageCell : UITableViewCell <NRChatMessageCellDelegate>

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
@property(nonatomic,strong)NRIMElem *messageModel;

#pragma mark < 私有方法 >
+ (CGFloat)cellHeightWithModel:(NRIMElem *)messageModel;

+ (NSString *)cellIdentifierWithModel:(NRIMElem *)messageModel;

- (void)refreshData:(NRIMElem *)messageModel;

+(id)CellWithChatTableView:(UITableView *)tableview;

@end

