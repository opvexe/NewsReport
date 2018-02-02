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
        [self addSubview:self.bgImgView];
    }
    
    return self;
}

- (void)refreshData:(NRIMElem *)messageModel{
    _messageModel = messageModel;
    
    if (_messageModel.isSender) {
        [self.bgImgView setImage:[[UIImage imageNamed:@"chat_to_bg_normal_sender"]
                                                          resizableImageWithCapInsets:UIEdgeInsetsMake(30, 16, 16, 24)
                                                          resizingMode:UIImageResizingModeStretch]];
        [self.bgImgView setHighlightedImage:[[UIImage imageNamed:@"chat_to_bg_normal_sender"]
                                                                     resizableImageWithCapInsets:UIEdgeInsetsMake(30, 16, 16, 24)
                                                                     resizingMode:UIImageResizingModeStretch]];
    } else {
        [self.bgImgView setImage:[[UIImage imageNamed:@"chat_to_bg_normal_recive"]
                                                          resizableImageWithCapInsets:UIEdgeInsetsMake(30, 16, 16, 24)
                                                          resizingMode:UIImageResizingModeStretch]];
        
        [self.bgImgView setHighlightedImage:[[UIImage imageNamed:@"chat_to_bg_normal_recive"]
                                                                     resizableImageWithCapInsets:UIEdgeInsetsMake(30, 16, 16, 24)
                                                                     resizingMode:UIImageResizingModeStretch]];
    }
     self.bgImgView.layer.mask.contents = (__bridge id _Nullable)(self.bgImgView.image.CGImage);
    
    
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

