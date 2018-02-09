//
//  NRFriendViewController.h
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NRFriendViewController : NRBaseViewController

/*!
 * 好友列表数据
 */
@property (nonatomic, weak) NSMutableArray *data;

/*!
 * 区头数据
 */
@property (nonatomic, weak) NSMutableArray *sectionHeaders;

/*!
 * 好友视图
 */
@property(nonatomic,strong)UITableView *friendTableView;

@end
