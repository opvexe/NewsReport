//
//  NRBaseViewControllerProtocol.h
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NRBaseViewControllerProtocol <NSObject>
@optional
/**
 *  获取数据
 */
-(void)NRGetDataSoucre;
/**
 *  添加视图
 */
-(void)NRAddSubviews;
/**
 *  初始视图
 */
- (void)NRInitConfingViews;
/**
 *  配置数据
 */
- (void)NRSetupViewModel;

@end
