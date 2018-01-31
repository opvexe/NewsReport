//
//  NRTabBarControllerConfig.m
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRTabBarControllerConfig.h"
#import "NRConversationListViewController.h"
#import "NRFriendViewController.h"
#import "NRPortraitViewController.h"
#import "NRRootViewController.h"
#import "NRBaseNavigationViewController.h"

@interface NRTabBarControllerConfig ()

@property (nonatomic, strong) CYLTabBarController *tabBarController;

@end

@implementation NRTabBarControllerConfig


- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        
        UIEdgeInsets imageInsets = UIEdgeInsetsZero;
        UIOffset titlePositionAdjustment = UIOffsetZero;
        
        NRRootViewController *tabBarController = [NRRootViewController tabBarControllerWithViewControllers:self.viewControllers
                                                                                     tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                                                               imageInsets:imageInsets
                                                                                   titlePositionAdjustment:titlePositionAdjustment];
        
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}
- (NSArray *)viewControllers {
    NRConversationListViewController *conversationViewController = [[NRConversationListViewController alloc] init];
    UIViewController *conversationNavigationController = [[NRBaseNavigationViewController alloc]
                                                     initWithRootViewController:conversationViewController];
    
    NRFriendViewController *friendViewController = [[NRFriendViewController alloc] init];
    UIViewController *friendNavigationController = [[NRBaseNavigationViewController alloc]
                                                    initWithRootViewController:friendViewController];
    
    NRPortraitViewController *portraitViewController = [[NRPortraitViewController alloc]init];
    UIViewController *portraitNavigationController = [[NRBaseNavigationViewController alloc]
                                                      initWithRootViewController:portraitViewController];
    
    
    
    NSArray *viewControllers = @[
                                 conversationNavigationController,
                                 friendNavigationController,
                                 portraitNavigationController
                                 ];
    return viewControllers;
}
- (NSArray *)tabBarItemsAttributesForController {
    
    NSDictionary *conversationTabBarItemsAttributes = @{
                                                   CYLTabBarItemTitle : @"消息",
                                                   CYLTabBarItemImage : @"Message_Icon_Normal",
                                                   CYLTabBarItemSelectedImage : @"Message_Icon_Selected",
                                                   };
    NSDictionary *friendTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"朋友",
                                                  CYLTabBarItemImage : @"Message_Icon_Normal",
                                                  CYLTabBarItemSelectedImage : @"Message_Icon_Selected",
                                                  };
    NSDictionary *portraitTabBarItemsAttributes = @{
                                                    CYLTabBarItemTitle : @"我的",
                                                    CYLTabBarItemImage : @"Message_Icon_Normal",
                                                    CYLTabBarItemSelectedImage : @"Message_Icon_Selected",
                                                    };
    
    
    NSArray *tabBarItemsAttributes = @[
                                       conversationTabBarItemsAttributes,
                                       friendTabBarItemsAttributes,
                                       portraitTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    tabBarController.tabBarHeight = LS_TabbarHeight;
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = TABARNORMALCOLOR;
    normalAttrs[NSFontAttributeName] = FontPingFangSC(10);
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = TABARHIGHTLIGHTCOLOR;
    selectedAttrs[NSFontAttributeName] = FontPingFangSC(10);
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}
- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

