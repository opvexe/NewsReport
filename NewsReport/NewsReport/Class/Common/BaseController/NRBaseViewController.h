//
//  NRBaseViewController.h
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRBaseViewControllerProtocol.h"

typedef NS_ENUM(NSUInteger, ToastPositionType) {
    ToastPositionTypeTop,
    ToastPositionTypeCenter,
    ToastPositionTypeBottom,
};

@interface NRBaseViewController : UIViewController<NRBaseViewControllerProtocol>

/**
 *  右自定义view
 */
@property (nonatomic,strong) UIView *navigationRightView;
/**
 *  左边
 */
@property (nonatomic,strong) UIView *navigationleftView;

/**
 *  push 方法
 */
- (void)pushViewControllerWithViewControllerClass:(Class)viewControllerClass;

/**
 *  返回 方法
 */
- (void)popBack;

/**
 *  隐藏键盘
 */
- (void)dismissKeyBoard;


- (void)makeToast:(NSString *)message;

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(ToastPositionType )position;

-(void)makeToast:(NSString *)message backImageView:(NSString *)image;


/**
 *  返回
 */
- (void)addPopBackBarButtonItem;
/**
 *  网络失败 显示 视图
 */
-(void)networkErrorWithView:(UIView*)view;
/**
 *  刷 新数据
 */
-(void)reloadDataSoucre;


-(void)switchRootController;
@end
