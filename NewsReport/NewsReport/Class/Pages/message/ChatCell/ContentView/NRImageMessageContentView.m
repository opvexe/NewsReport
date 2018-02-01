//
//  NRImageMessageContentView.m
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRImageMessageContentView.h"

@implementation NRImageMessageContentView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 5;
        [self addSubview:_imageView];
        
        _progressView = [[NRProgressView alloc] init];
        _progressView.showsText = YES;
        _progressView.tintColor = [UIColor blueColor];
        _progressView.alpha = 0.5;
        _progressView.hidden = YES;
        [_imageView addSubview:_progressView];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.messageModel.isSender) {//右边
        _imageView.frame = CGRectMake(8, 4, self.messageModel.contentWidth - 8 - 13, self.messageModel.contentHeight - 4 - 13);
    } else {//左边
        _imageView.frame = CGRectMake(13, 4, self.messageModel.contentWidth - 13 - 8, self.messageModel.contentHeight - 4 - 13);
    }
    
    _progressView.frame = _imageView.bounds;
}

- (void)refreshData:(NRIMImageElem *)messageModel{
    [super refreshData:messageModel];
    UIImage *image = messageModel.thumbnailImage;
    _imageView.image = image;
}
@end
