//
//  NRSoundRecorder.h
//  NewsReport
//
//  Created by Facebook on 2018/2/5.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRSoundRecorder : NSObject
/*!
 *  单利
 */
+ (NRSoundRecorder *)shareInstance;

/*!
 *  开始录音
 */
- (void)startSoundRecord:(UIView *)view;
/*!
 *  录音按钮按下
 */
-(void)recordButtonTouchDown;

/*!
 *  手指在录音按钮内部时离开
 */
-(void)recordButtonTouchUpInside;

/*!
 *   手指在录音按钮外部时离开
 */
-(void)recordButtonTouchUpOutside;

/*!
 *   手指移动到录音按钮内部
 */
-(void)recordButtonDragInside;

/*!
 *   手指移动到录音按钮外部
 */
-(void)recordButtonDragOutside;

/*!
 *   移除视图
 */
- (void)removeHUD;

/*!
 *   录音时间太短弹出视图
 */
- (void)showShotTimeSign:(UIView *)view;

@end
