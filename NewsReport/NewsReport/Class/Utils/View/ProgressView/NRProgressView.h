//
//  NRProgressView.h
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface NRProgressView : UIView

@property (nonatomic) IBInspectable BOOL indeterminate;
@property (nonatomic) IBInspectable CGFloat progress;
@property (nonatomic) IBInspectable BOOL showsText;

@property (nonatomic) IBInspectable CGFloat lineWidth;
@property (nonatomic) IBInspectable CGFloat radius;
@property (nonatomic) IBInspectable UIColor *tintColor; 
@property (nonatomic) UIView *backgroundView;

@property (nonatomic, readonly) UILabel *textLabel;
@property (nonatomic) IBInspectable UIColor *textColor;
@property (nonatomic) IBInspectable CGFloat textSize;

@property (nonatomic) UIBlurEffect *blurEffect NS_AVAILABLE_IOS(8_0);
@property (nonatomic) IBInspectable BOOL usesVibrancyEffect; 

@property (nonatomic, copy) void(^animationDidStopBlock)(void);

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
