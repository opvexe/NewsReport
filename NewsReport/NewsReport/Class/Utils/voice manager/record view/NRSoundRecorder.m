//
//  NRSoundRecorder.m
//  NewsReport
//
//  Created by Facebook on 2018/2/5.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRSoundRecorder.h"
#import "WXDeviceManager+Microphone.h"

@interface NRSoundRecorder()
@property (nonatomic, strong) MBProgressHUD *HUD;
//Views
@property (nonatomic, strong) UIImageView *imageViewAnimation;
@property (nonatomic, strong) UIImageView *talkPhone;
@property (nonatomic, strong) UIImageView *cancelTalk;
@property (nonatomic, strong) UIImageView *shotTime;
@property (nonatomic, strong) UILabel *textLable;
@property (nonatomic, strong) UILabel *countDownLabel;

@end
@implementation NRSoundRecorder
{
    NSTimer *_timer;
}
/*!
 *  初始化单利
 */
+ (NRSoundRecorder *)shareInstance {
    static NRSoundRecorder *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        if (sharedInstance == nil) {
            sharedInstance = [[NRSoundRecorder alloc] init];
        }
    });
    return sharedInstance;
}

/*!
 *  录音按钮按下
 */
-(void)recordButtonTouchDown{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                              target:self
                                            selector:@selector(levelTimerCallback:)
                                            userInfo:nil
                                             repeats:YES];
}

/*!
 *  开始录音
 */
- (void)startSoundRecord:(UIView *)view{
    [self initHUBViewWithView:view];
    [self recordButtonTouchDown];
}


/*!
 *  移除视图
 */
- (void)removeHUD {
    if (_HUD) {
        [_HUD removeFromSuperview];
        _HUD = nil;
    }
}

/*!
 *  手指在录音按钮内部时离开 (完成录音)
 */
-(void)recordButtonTouchUpInside{
    [self removeHUD];
    [_timer invalidate];
}

/*!
 *   手指在录音按钮外部时离开( 取消录音 )
 */
-(void)recordButtonTouchUpOutside{
    [self removeHUD];
    [_timer invalidate];
}

/*!
 *   手指移动到录音按钮内部 (继续录音)
 */
-(void)recordButtonDragInside{
    [self resetNormalRecord];
}

/*!
 *   手指移动到录音按钮外部 (将要取消录音)
 */
-(void)recordButtonDragOutside{
    [self readyCancelSound];
}


/*!
 *  即将取消录音视图
 */
- (void)readyCancelSound {
    _imageViewAnimation.hidden = YES;
    _talkPhone.hidden = YES;
    _cancelTalk.hidden = NO;
    _shotTime.hidden = YES;
    _countDownLabel.hidden = YES;
    
    _textLable.frame = CGRectMake(0, CGRectGetMaxY(_imageViewAnimation.frame) + 20, 130, 25);
    _textLable.text = @"手指松开，取消发送";
    _textLable.backgroundColor = [UIColor redColor];
    _textLable.layer.masksToBounds = YES;
    _textLable.layer.cornerRadius = 3;
}


/*!
 *   正常录音视图
 */
- (void)resetNormalRecord {
    _imageViewAnimation.hidden = NO;
    _talkPhone.hidden = NO;
    _cancelTalk.hidden = YES;
    _shotTime.hidden = YES;
    _countDownLabel.hidden = YES;
    _textLable.frame = CGRectMake(0, CGRectGetMaxY(_imageViewAnimation.frame) + 20, 130, 25);
    _textLable.text = @"手指上滑，取消发送";
    _textLable.backgroundColor = [UIColor clearColor];
}


/*!
 *   录音时间太短视图
 */
- (void)showShotTimeSign:(UIView *)view {
    _imageViewAnimation.hidden = YES;
    _talkPhone.hidden = YES;
    _cancelTalk.hidden = YES;
    _shotTime.hidden = NO;
    _countDownLabel.hidden = YES;
    [_textLable setFrame:CGRectMake(0, 100, 130, 25)];
    _textLable.text = @"说话时间太短";
    _textLable.backgroundColor = [UIColor clearColor];
}

/*!
 *   初始化录音视图
 */
- (void)initHUBViewWithView:(UIView *)view {
    if (_HUD) {
        [_HUD removeFromSuperview];
        _HUD = nil;
    }
    if (view == nil) {
        view = [[[UIApplication sharedApplication] windows] lastObject];
    }
    if (_HUD == nil) {
        _HUD = [[MBProgressHUD alloc] initWithView:view];
        _HUD.opacity = 0.4;
        
        CGFloat left = 22;
        CGFloat top = 0;
        top = 18;
        
        UIView *cv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 130, 120)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(left, top, 37, 70)];
        _talkPhone = imageView;
        _talkPhone.image = [UIImage imageNamed:@"toast_microphone"];
        [cv addSubview:_talkPhone];
        left += CGRectGetWidth(_talkPhone.frame) + 16;
        
        top+=7;
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(left, top, 29, 64)];
        _imageViewAnimation = imageView;
        [cv addSubview:_imageViewAnimation];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 24, 52, 61)];
        _cancelTalk = imageView;
        _cancelTalk.image = [UIImage imageNamed:@"toast_cancelsend"];
        [cv addSubview:_cancelTalk];
        _cancelTalk.hidden = YES;
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(56, 24, 18, 60)];
        self.shotTime = imageView;
        _shotTime.image = [UIImage imageNamed:@"toast_timeshort"];
        [cv addSubview:_shotTime];
        _shotTime.hidden = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 14, 70, 71)];
        self.countDownLabel = label;
        self.countDownLabel.backgroundColor = [UIColor clearColor];
        self.countDownLabel.textColor = [UIColor whiteColor];
        self.countDownLabel.textAlignment = NSTextAlignmentCenter;
        self.countDownLabel.font = [UIFont systemFontOfSize:60.0];
        [cv addSubview:self.countDownLabel];
        self.countDownLabel.hidden = YES;
        
        left = 0;
        top += CGRectGetHeight(_imageViewAnimation.frame) + 20;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(left, top, 130, 14)];
        self.textLable = label;
        _textLable.backgroundColor = [UIColor clearColor];
        _textLable.textColor = [UIColor whiteColor];
        _textLable.textAlignment = NSTextAlignmentCenter;
        _textLable.font = [UIFont systemFontOfSize:14.0];
        _textLable.text = @"手指上滑，取消发送";
        [cv addSubview:_textLable];
        
        _HUD.customView = cv;
        _HUD.mode = MBProgressHUDModeCustomView;
    }
    if ([view isKindOfClass:[UIWindow class]]) {
        [view addSubview:_HUD];
    } else {
        [view.window addSubview:_HUD];
    }
    [_HUD showAnimated:YES];
}

- (void)levelTimerCallback:(NSTimer *)timer {
    if (_imageViewAnimation) {
        double ff  =  [[WXDeviceManager sharedInstance] emPeekRecorderVoiceMeter];
        ff = ff+60;
        if (ff>0&&ff<=10) {
            [_imageViewAnimation setImage:[UIImage imageNamed:@"toast_vol_0"]];
        } else if (ff>10 && ff<20) {
            [_imageViewAnimation setImage:[UIImage imageNamed:@"toast_vol_1"]];
        } else if (ff >=20 &&ff<30) {
            [_imageViewAnimation setImage:[UIImage imageNamed:@"toast_vol_2"]];
        } else if (ff >=30 &&ff<40) {
            [_imageViewAnimation setImage:[UIImage imageNamed:@"toast_vol_3"]];
        } else if (ff >=40 &&ff<50) {
            [_imageViewAnimation setImage:[UIImage imageNamed:@"toast_vol_4"]];
        } else if (ff >= 50 && ff < 60) {
            [_imageViewAnimation setImage:[UIImage imageNamed:@"toast_vol_5"]];
        } else if (ff >= 60 && ff < 70) {
            [_imageViewAnimation setImage:[UIImage imageNamed:@"toast_vol_6"]];
        } else {
            [_imageViewAnimation setImage:[UIImage imageNamed:@"toast_vol_7"]];
        }
    }
}


@end

