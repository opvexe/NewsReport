//
//  NRCallBaseViewController.h
//  NewsReport
//
//  Created by Facebook on 2018/2/2.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 * 通话基类
 */

@interface NRCallBaseViewController : UIViewController

/*!
 会话目标ID
 */
@property(nonatomic, strong, readonly) NSString *targetId;

/*!
 媒体类型
 */
@property(nonatomic, assign, readonly) CallMediaType mediaType;

#pragma mark   <  UI控件  >
/*!
 背景View
 */
@property(nonatomic, strong) UIView *backgroundView;

/*!
 蒙层View
 */
@property(nonatomic, strong) UIVisualEffectView *blurView;

/*!
 最小化Button
 */
@property(nonatomic, strong) UIButton *minimizeButton;

/*!
 加人Button
 */
@property(nonatomic, strong) UIButton *inviteUserButton;

/*!
 通话时长Label
 */
@property(nonatomic, strong) UILabel *timeLabel;

/*!
 提示Label
 */
@property(nonatomic, strong) UILabel *tipsLabel;

/*!
 静音Button
 */
@property(nonatomic, strong) UIButton *muteButton;

/*!
 扬声器Button
 */
@property(nonatomic, strong) UIButton *speakerButton;

/*!
 接听Button
 */
@property(nonatomic, strong) UIButton *acceptButton;

/*!
 挂断Button
 */
@property(nonatomic, strong) UIButton *hangupButton;

/*!
 关闭摄像头的Button
 */
@property(nonatomic, strong) UIButton *cameraCloseButton;

/*!
 切换前后摄像头的Button
 */
@property(nonatomic, strong) UIButton *cameraSwitchButton;




@end
