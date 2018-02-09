//
//  NRConversationListCell.m
//  NewsReport
//
//  Created by Facebook on 2018/1/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRConversationListCell.h"

#define     REDPOINT_WIDTH          10.0f

@interface NRConversationListCell ()

@property(nonatomic,strong)FLAnimatedImageView *headPortraitImageView;
@property(nonatomic,strong)UILabel *portraitLabel;
@property(nonatomic,strong)UILabel *timestampLabel;
@property(nonatomic,strong)TTTAttributedLabel *messageLabel;
@property(nonatomic,strong)UILabel *messageCountLabel;
@property(nonatomic,strong)UIView *redPointView;

@end

@implementation NRConversationListCell

+(id)CellWithTableView:(UITableView *)tableview{
    NRConversationListCell *cell = [tableview dequeueReusableCellWithIdentifier:NSStringFromClass([NRConversationListCell class])];
    if (!cell) {
        cell = [[NRConversationListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([NRConversationListCell class])];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle  = UITableViewCellSelectionStyleNone ;
        
        self.headPortraitImageView = [[FLAnimatedImageView alloc]init];
        self.headPortraitImageView.contentMode =UIViewContentModeScaleAspectFill;
        self.headPortraitImageView.cornerRadius = Number(5.0);
        [self.contentView addSubview:self.headPortraitImageView];
        
        self.portraitLabel = [[UILabel alloc]init];
        self.portraitLabel.font= FontHelFont(16);
        self.portraitLabel.textColor = MESSAGE_NICKNAME_Color;
        [self.contentView addSubview:self.portraitLabel];
        
        self.messageLabel = [[TTTAttributedLabel alloc]initWithFrame:CGRectZero];
        self.messageLabel.font= FontHelFont(14);
        self.messageLabel.textColor = MESSAGE_Describe_Color;
        [self.contentView addSubview:self.messageLabel];
        
        self.timestampLabel = [[UILabel alloc]init];
        self.timestampLabel.font= FontHelFont(14);
        self.timestampLabel.textColor = MESSAGE_Time_Color;
        [self.contentView addSubview:self.timestampLabel];
        
        self.messageCountLabel = [[UILabel alloc]init];
        self.messageCountLabel.font= FontHelFont(14);
        self.messageCountLabel.textColor = UIColorFromRGB(0x323232);
        [self.contentView addSubview:self.messageCountLabel];
        
        self.redPointView =  [[UIView alloc] init];
        [self.redPointView setBackgroundColor:[UIColor redColor]];
        [self.redPointView.layer setMasksToBounds:YES];
        [self.redPointView.layer setCornerRadius:REDPOINT_WIDTH / 2.0];
        [self.redPointView setHidden:YES];
        [self.contentView addSubview:self.redPointView];
        
        [self updateConstraintsView];
    }
    return self;
}


-(void)updateConstraintsView{
    
    [self.headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(Number(10.0));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(Number(40.0), Number(40.0)));
    }];
    
    [self.portraitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headPortraitImageView.mas_right).offset(Number(10.0));
        make.top.mas_equalTo(self.headPortraitImageView.mas_top);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.portraitLabel.mas_left);
        make.top.mas_equalTo(self.portraitLabel.mas_bottom).offset(Number(5.0));
    }];
    
    [self.timestampLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.portraitLabel.mas_top);
        make.right.mas_equalTo(self.contentView).offset(-Number(10.0));
    }];
    
    [self.redPointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.headPortraitImageView.mas_right).mas_offset(-2);
        make.centerY.mas_equalTo(self.headPortraitImageView.mas_top).mas_offset(2);
        make.width.and.height.mas_equalTo(REDPOINT_WIDTH);
    }];
}

-(void)InitDataWithModel:(NRConversation *)model{
    
    _conversation = model;

    [self.headPortraitImageView sd_setImageWithURL:URLFromString(model.avatarURL) placeholderImage:NRImageNamed(DEFAULT_AVATAR_PATH)];
    [self.portraitLabel setText:convertToString(model.partnerName)];
    [self.messageLabel setText:convertToString(model.content)];
    [self.timestampLabel setText:convertToString(model.date.formattedDateDescription)];
    
    self.conversation.isRead ? [self markAsRead] : [self markAsUnread];
}


/**
 *  标记为未读
 */
- (void) markAsUnread
{
    if (_conversation) {
        switch (_conversation.clueType) {
            case ClueTypePointWithNumber:
                break;
            case ClueTypePoint:
                [self.redPointView setHidden:NO];
                break;
            case ClueTypeNone:
                break;
            default:
                break;
        }
    }
}

/**
 *  标记为已读
 */
- (void) markAsRead
{
    if (_conversation) {
        switch (_conversation.clueType) {
            case ClueTypePointWithNumber:
                break;
            case ClueTypePoint:
                [self.redPointView setHidden:YES];
                break;
            case ClueTypeNone:
                break;
            default:
                break;
        }
    }
}

@end

