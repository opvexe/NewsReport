//
//  NRBaseNavigationViewController.m
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRBaseNavigationViewController.h"

@interface NRBaseNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation NRBaseNavigationViewController

+ (void)load
{
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    [navigationBarAppearance setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setShadowImage:[UIImage imageNamed:@"NavigationBarLine"]];
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageWithColor:UIColorFromRGB(0xffffff)];
        
        textAttributes = @{
                           NSFontAttributeName : FontPingFangSC(18),
                           NSForegroundColorAttributeName :UIColorFromRGB(0x646464),
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageWithColor:UIColorFromRGB(0xffffff)];
        textAttributes = @{
                           UITextAttributeFont : FontPingFangSC(18),
                           UITextAttributeTextColor :UIColorFromRGB(0x646464),
                           UITextAttributeTextShadowColor : [UIColor clearColor],
                           UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 如果滑动移除控制器的功能失效，清空代理(让导航控制器重新设置这个功能)
    self.interactivePopGestureRecognizer.delegate = self;
    //    // 禁止使用系统自带的滑动手势,防止从滑动，返回存在未知bug。
    self.interactivePopGestureRecognizer.enabled = YES;
}

/*!
 *  重新
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    return [super pushViewController:viewController animated:animated];
}

@end
