//
//  NRChatMessageCell.m
//  NewsReport
//
//  Created by Facebook on 2018/1/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRChatMessageCell.h"

@implementation NRChatMessageCell


+(id)CellWithChatTableView:(UITableView *)tableview{
    NRChatMessageCell *cell = [tableview dequeueReusableCellWithIdentifier:NSStringFromClass([NRChatMessageCell class])];
    if (!cell) {
        cell = [[NRChatMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([NRChatMessageCell class])];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
 
        //头像
        self.headImageView = [[UIImageView alloc] init];
        self.headImageView.image = NRImageNamed(@"icon_avatar");
        self.headImageView.layer.masksToBounds = YES;
        self.headImageView.layer.cornerRadius = 5;
        self.headImageView.userInteractionEnabled = YES;
        self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.headImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTapGestureRecognizer)]];
        [self.contentView addSubview:self.headImageView];
        
        //昵称
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = [UIColor lightGrayColor];
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.nameLabel];
        
        //已读
        self.hasReadLabel = [[UILabel alloc] init];
        self.hasReadLabel.textColor = [UIColor lightGrayColor];
        self.hasReadLabel.font = [UIFont systemFontOfSize:13];
        self.hasReadLabel.text = @"已读";
        self.hasReadLabel.hidden = YES;
        self.hasReadLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.hasReadLabel];
        
        //重新发送
        self.reSendBtn = [[UIButton alloc] init];
        self.reSendBtn.hidden = YES;
        [self.reSendBtn setImage:[UIImage imageNamed:@"messageSendFail"] forState:(UIControlStateNormal)];
        [self.reSendBtn addTarget:self action:@selector(reSendBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:self.reSendBtn];
        
        //正在发送
        self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activity.backgroundColor = [UIColor clearColor];
        self.activity.hidden = YES;
        [self.contentView addSubview:self.activity];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.messageModel.isSender) {//是主人，在右边
        //头像
        self.headImageView.frame = CGRectMake(SCREEN_WIDTH - 10 - HeadImageWidth, 5, HeadImageWidth, HeadImageHeight);
        //昵称
        self.nameLabel.hidden = YES;
        //气泡
        self.bubbleView.frame = CGRectMake(SCREEN_WIDTH - 10 - HeadImageWidth - self.messageModel.contentWidth - 5, 5, self.messageModel.contentWidth, self.messageModel.contentHeight);
        //已读
        self.hasReadLabel.frame = CGRectMake(_bubbleView.frame.origin.x - 30, CGRectGetMaxY(_bubbleView.frame) - 30, 30, 20);
        //重新发送
        self.reSendBtn.frame = CGRectMake(_bubbleView.frame.origin.x - 30, (_bubbleView.bounds.size.height - 30)/2, 30, 30);
        //正在发送
        self.activity.frame = CGRectMake(_bubbleView.frame.origin.x - 20, (_bubbleView.bounds.size.height - 20)/2, 20, 20);
        
        if (self.messageModel.messageChatType != MessageChatSingle) {
            self.hasReadLabel.hidden = YES;
        }
    } else {//是好友，在左边
        //头像
        self.headImageView.frame = CGRectMake(10, 5, HeadImageWidth, HeadImageHeight);
        self.hasReadLabel.hidden = YES;
        self.reSendBtn.hidden = YES;
        self.activity.hidden = YES;
        
        if (self.messageModel.messageChatType == MessageChatSingle) {
            self.nameLabel.hidden = YES;
            _bubbleView.frame = CGRectMake(10 + HeadImageWidth + 5, 5, self.messageModel.contentWidth, self.messageModel.contentHeight);
        } else {
            self.nameLabel.hidden = NO;
            //昵称
            self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.headImageView.frame) + 10, 5, NameLabelWidth, NameLabelHeight);
            self.nameLabel.textAlignment = NSTextAlignmentLeft;
            _bubbleView.frame = CGRectMake(10 + HeadImageWidth + 5, 5 + NameLabelHeight + 5, self.messageModel.contentWidth, self.messageModel.contentHeight);
        }
    }
}

- (void)refreshData:(NRIMElem *)messageModel{
    _messageModel = messageModel;
    if (_bubbleView == nil) {
        if (messageModel.messageType == MessageTypeText) {
            _bubbleView =  [[NRTextMessageContentView alloc] init];
        }
        if (messageModel.messageType == MessageTypeImage) {
            _bubbleView =  [[NRImageMessageContentView alloc] init];
        }
        
        if (messageModel.messageType == MessageTypeVideo) {
            _bubbleView =  [[NRVideoMessageContentView alloc] init];
        }
        
        if (messageModel.messageType == MessageTypeLocation) {
            _bubbleView =  [[NRLocationMessageContentView alloc] init];
        }
        
        if (messageModel.messageType == MessageTypeVoice) {
            _bubbleView =  [[NRVoiceMessageContentView alloc] init];
        }
        
        if (messageModel.messageType == MessageTypeFile) {
            _bubbleView =  [[NRFileMessageContentView alloc] init];
        }
        
        _bubbleView.delegate = self;
        [self.contentView addSubview:_bubbleView];
    }
    
    _nameLabel.text = messageModel.senderUserInfo.nickName;
    [_bubbleView refreshData:messageModel];
    
    switch (self.messageModel.messageStatus) {
        case MessageSendStateSending:
        {
            _reSendBtn.hidden = YES;
            [_activity setHidden:NO];
            [_activity startAnimating];
        }
            break;
        case MessageSendSuccess:
        {
            _reSendBtn.hidden = YES;
            [_activity stopAnimating];
            if (self.messageModel.isMessageRead) {
                _hasReadLabel.hidden = NO;
            } else {
                _hasReadLabel.hidden = YES;
            }
        }
            break;
        case MessageSendFail:
        {
            [_activity stopAnimating];
            [_activity setHidden:YES];
            _reSendBtn.hidden = NO;
        }
            break;
        default:
            break;
    }
}

/*!
 * 点击撤回消息
 */
- (void)reSendBtnClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(reSendCellWithMessageModel:)]) {
        [self.delegate reSendCellWithMessageModel:self.messageModel];
    }
}

/*!
 * 点击头像
 */
- (void)headTapGestureRecognizer{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickCellHeadImageWithMessageModel:)]) {
        [self.delegate clickCellHeadImageWithMessageModel:self.messageModel];
    }
}

#pragma mark  < MessageContentViewDelegate >

- (void)clickMessageContentViewWithMessageModel:(NRIMElem *)messageModel{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickCellMessageContentViewWithMessageModel:)]) {
        [self.delegate clickCellMessageContentViewWithMessageModel:messageModel];
    }
}

- (void)longPressMessageContentViewWithMessageModel:(NRIMElem *)messageModel{
    if (self.delegate && [self.delegate respondsToSelector:@selector(longPressCellMessageContentViewWithMessageModel:)]) {
        [self.delegate longPressCellMessageContentViewWithMessageModel:self.messageModel];
    }
}


+ (CGFloat)cellHeightWithModel:(NRIMElem *)messageModel{
    if (messageModel.cellHeight > 0) {
        return messageModel.cellHeight;
    }
    
    CGFloat contentWidth = 0;
    CGFloat contentHeight = 0;
    
    switch (messageModel.messageType) {
        case MessageTypeText:
        {
            NRIMTextElem *message = (NRIMTextElem *)messageModel;
            CGSize textSize = [message.text boundingRectWithSize:CGSizeMake(TextContentViewMaxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
            contentWidth += 20 + textSize.width + 15;
            contentHeight += 10 + textSize.height + 20;
        }
            break;
        case MessageTypeImage:
        {
             NRIMImageElem *message = (NRIMImageElem *)messageModel;
            if (message.thumbnailImageSize.width == 0) {
                contentWidth += ImageContentViewFailWidth;
                contentHeight += ImageContentViewFailHeight;
            } else {
                if (message.thumbnailImageSize.width > message.thumbnailImageSize.height) {
                    contentWidth += ImageContentViewMaxWidth;
                    contentHeight += ImageContentViewMinHeight;
                } else {
                    contentWidth += ImageContentViewMinWidth;
                    contentHeight += ImageContentViewMaxHeight;
                }
            }
        }
            break;
        case MessageTypeVideo:
        {
//            if (messageModel.thumbnailImageSize.width > messageModel.thumbnailImageSize.height) {
//                contentWidth += VideoContentViewMaxWidth;
//                contentHeight += VideoContentViewMinHeight;
//            } else {
//                contentWidth += VideoContentViewMinWidth;
//                contentHeight += VideoContentViewMaxHeight;
//            }
        }
            break;
        case MessageTypeLocation:
        {
            contentWidth += LocationContentViewWidth;
            contentHeight += LocationContentViewHeight;
        }
            break;
        case MessageTypeVoice:
        {
            contentWidth += VoiceContentViewWidth;
            contentHeight += VoiceContentViewHeight;
        }
            break;
        case MessageTypeFile:
        {
            contentWidth += FileContentViewWidth;
            contentHeight += FileContentViewHeight;
        }
            break;
        default:
            break;
    }
    
    CGFloat minHeight = 5 + 50 + 5;
    CGFloat height = 5 + contentHeight + 5;
    
    if (height < minHeight) {
        height = minHeight;
        contentHeight = 50;
    }
    
    if (contentWidth < 60) {
        contentWidth = 60;
    }
    
    if (messageModel.messageChatType != MessageChatSingle) {
        if (!messageModel.isSender) {
            height += (NameLabelHeight + 5);
        }
    }
    
    messageModel.cellHeight = height;
    messageModel.contentWidth = contentWidth;
    messageModel.contentHeight = contentHeight;
    
    return height;
}

+ (NSString *)cellIdentifierWithModel:(NRIMElem *)messageModel{
    NSString *cellIdentifier = nil;
    if (messageModel.isSender) {//发送者
        switch (messageModel.messageType) {
            case MessageTypeText:
                cellIdentifier = NRMessageCellIdentifierSendText;
                break;
            case MessageTypeImage:
                cellIdentifier = NRMessageCellIdentifierSendImage;
                break;
            case MessageTypeVideo:
                cellIdentifier = NRMessageCellIdentifierSendVideo;
                break;
            case MessageTypeLocation:
                cellIdentifier = NRMessageCellIdentifierSendLocation;
                break;
            case MessageTypeVoice:
                cellIdentifier = NRMessageCellIdentifierSendVoice;
                break;
            case MessageTypeFile:
                cellIdentifier = NRMessageCellIdentifierSendFile;
                break;
            default:
                break;
        }
    } else {
        switch (messageModel.messageType) {
            case MessageTypeText:
                cellIdentifier = NRMessageCellIdentifierRecvText;
                break;
            case MessageTypeImage:
                cellIdentifier = NRMessageCellIdentifierRecvImage;
                break;
            case MessageTypeVideo:
                cellIdentifier = NRMessageCellIdentifierRecvVideo;
                break;
            case MessageTypeLocation:
                cellIdentifier = NRMessageCellIdentifierRecvLocation;
                break;
            case MessageTypeVoice:
                cellIdentifier = NRMessageCellIdentifierRecvVoice;
                break;
            case MessageTypeFile:
                cellIdentifier = NRMessageCellIdentifierRecvFile;
                break;
            default:
                break;
        }
    }
    
    return cellIdentifier;
}


@end
