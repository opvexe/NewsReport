//
//  NRFriendViewController+Delegate.h
//  NewsReport
//
//  Created by Facebook on 2018/2/5.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRFriendViewController.h"

@interface NRFriendViewController (Delegate)<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

- (void)registerCellClass;

@end
