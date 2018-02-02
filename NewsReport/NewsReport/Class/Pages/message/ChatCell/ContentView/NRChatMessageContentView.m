//
//  NRChatMessageContentView.m
//  NewsReport
//
//  Created by Facebook on 2018/1/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRChatMessageContentView.h"

@implementation NRChatMessageContentView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(onTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognizer:)];
        longPressGestureRecognizer.minimumPressDuration = 0.8;
        [self addGestureRecognizer:longPressGestureRecognizer];
        
        _bgImgView = [[UIImageView alloc] init];
        _bgImgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_bgImgView];
    }
    
    return self;
}

- (void)refreshData:(NRIMElem *)messageModel{
    self.messageModel = messageModel;
    
    UIImage *image ;
    if (self.messageModel.isSender) {
            image = [UIImage imageNamed:@"chat_to_bg_normal_sender"];
    } else {
            image = [UIImage imageNamed:@"chat_to_bg_normal_recive"];
    }
    self.bgImgView.image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.bgImgView.frame = self.bounds;
}


#pragma mark < NRChatMessageContentViewDelegate >
- (void)onTouchUpInside:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickMessageContentViewWithMessageModel:)]) {
        [self.delegate clickMessageContentViewWithMessageModel:self.messageModel];
    }
}

- (void)longPressGestureRecognizer:(UILongPressGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(longPressMessageContentViewWithMessageModel:)]) {
            [self.delegate longPressMessageContentViewWithMessageModel:self.messageModel];
        }
    }
}

@end

