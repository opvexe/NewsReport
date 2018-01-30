//
//  NRBaseViewController.m
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRBaseViewController.h"
#import "NRTabBarControllerConfig.h"
#import "NRBarButtonItem.h"
#import "AppDelegate.h"

@interface NRBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation NRBaseViewController

- (void)dismissKeyBoard{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTextField)];
    [self.view addGestureRecognizer:tap];
    tap.delegate  = self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (![touch.view isEqual:self.view]) {
        return NO;
    }
    return YES;
}

- (void)addPopBackBarButtonItem{
    NRBarButtonItem *item = [NRBarButtonItem buttonWithImageNormal:@"back_Icon" imageSelected:@"back_IconG" target:self selector:@selector(popBack)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:item];
}

- (void)setNavigationRightView:(UIView *)navigationRightView{
    _navigationRightView = navigationRightView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navigationRightView];
}

-(void)setNavigationleftView:(UIView *)navigationleftView{
    _navigationleftView = navigationleftView;
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:navigationleftView];
}

- (void)pushViewControllerWithViewControllerClass:(Class)viewControllerClass{
    NRBaseViewController *bvc = [[viewControllerClass alloc] init];
    if (bvc) {
        [self.navigationController pushViewController:bvc animated:YES
         ];
    }
}

- (void)makeToast:(NSString *)message{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view makeToast:message duration:1.0f position:CSToastPositionCenter];
    });
    
}

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(ToastPositionType)position{
    NSString *positionType =@"CSToastPositionTop";
    switch (position) {
        case ToastPositionTypeTop:
            positionType =@"CSToastPositionTop";
            break;
        case ToastPositionTypeBottom:
            positionType =@"CSToastPositionBottom";
            break;
        case ToastPositionTypeCenter:
            positionType =@"CSToastPositionCenter";
            break;
        default:
            break;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.view makeToast:message duration:duration position:positionType];
    });
}

-(void)makeToast:(NSString *)message backImageView:(NSString *)image {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view makeToast:message duration:1.0f position:CSToastPositionCenter title:nil image:[UIImage imageNamed:image] style:nil completion:nil];
    });
}

/**
 *  刷新
 */
-(void)reloadDataSoucre{
    
}

/**
 *  网络失败 显示 视图
 */
-(void)networkErrorWithView:(UIView*)view{
    
}

/**
 *  关闭键盘
 */
- (void)closeTextField{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

/**
 *  返回
 */
-(void)popBack{
    
    if(self.navigationController!=nil){
        if (self.navigationController.childViewControllers.count ==1) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        return;
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/**
 *  获取数据
 */
-(void)HYSGetDataSoucre{
    
}
/**
 *  添加视图
 */
-(void)HYSAddSubviews{
    
}
/**
 *  初始视图
 */
- (void)HYSInitConfingViews{
    
}
/**
 *  配置数据
 */
- (void)HYSSetupViewModel{
    
}


-(void)switchRootController{
    NRTabBarControllerConfig  *tabBarControllerConfig = [NRTabBarControllerConfig new];
    [UIApplication sharedApplication].delegate.window.rootViewController = tabBarControllerConfig.tabBarController;
}

@end

