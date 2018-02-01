//
//  WXRecordView.h
//  WXRecording
//
//  Created by Facebook on 2018/1/29.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    EaseRecordViewTypeTouchDown,
    EaseRecordViewTypeTouchUpInside,
    EaseRecordViewTypeTouchUpOutside,
    EaseRecordViewTypeDragInside,
    EaseRecordViewTypeDragOutside,
}EaseRecordViewType;

@interface WXRecordView : UIView

@property (nonatomic) NSArray *voiceMessageAnimationImages UI_APPEARANCE_SELECTOR;

@property (nonatomic) NSString *upCancelText UI_APPEARANCE_SELECTOR;

@property (nonatomic) NSString *loosenCancelText UI_APPEARANCE_SELECTOR;

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

@end
