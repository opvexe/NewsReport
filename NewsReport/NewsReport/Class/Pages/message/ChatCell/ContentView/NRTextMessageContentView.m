//
//  NRTextMessageContentView.m
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRTextMessageContentView.h"

@implementation NRTextMessageContentView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.numberOfLines = 0;
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_textLabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_textLabel sizeToFit];
    
    if (self.messageModel.isSender) {//右边
        _textLabel.frame = CGRectMake(15, 10, self.messageModel.contentWidth - 20 - 15, self.messageModel.contentHeight - 10 - 20);
        _textLabel.textColor = [UIColor whiteColor];
    } else {//左边
        _textLabel.frame = CGRectMake(18, 10, self.messageModel.contentWidth - 20 - 15, self.messageModel.contentHeight - 10 - 20);
        _textLabel.textColor = [UIColor blackColor];
    }
}

- (void)refreshData:(NRIMTextElem *)messageModel{
    [super refreshData:messageModel];
    _textLabel.text = messageModel.text;
}

@end
