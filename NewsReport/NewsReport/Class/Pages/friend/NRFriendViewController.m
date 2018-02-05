//
//  NRFriendViewController.m
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRFriendViewController.h"
#import "NRFriendViewController+Delegate.h"
#import "NRSearchBar.h"

@interface NRFriendViewController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)NRSearchBar *searchBar;
@property(nonatomic,strong) UILabel *footerLabel;
@end

@implementation NRFriendViewController

- (NRSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[NRSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.friendTableView.frame.size.width, 44)];
    }
    return _searchBar;
}
- (UIView *)headerView {
    if (!_headerView) {
        _headerView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.friendTableView.frame.size.width, 44)];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"朋友";
    [self updateViewConstraintsView];
    [self registerCellClass];
    self.searchBar.delegate = self;
    [self.headerView addSubview:self.searchBar];
    self.friendTableView.tableHeaderView = self.headerView;
    self.friendTableView.separatorColor =UIColorFromRGB(0xdfdfdf);
    [self.friendTableView setTableFooterView:self.footerLabel];
}


/*!
 * 懒加载
 */
-(UITableView *)friendTableView{
    if (!_friendTableView) {
        _friendTableView                                = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _friendTableView.showsVerticalScrollIndicator   = NO;
        _friendTableView.showsHorizontalScrollIndicator = NO;
        _friendTableView.delegate                       = self;
        _friendTableView.dataSource                     = self;
        _friendTableView.tableFooterView                = [UIView new];
        _friendTableView.separatorStyle                 = UITableViewCellSeparatorStyleSingleLine;
        _friendTableView.backgroundColor               = UIColorFromRGB(0xffffff);
        [self.view addSubview:_friendTableView];
    }
    return _friendTableView;
}

-(void)updateViewConstraintsView{
    [self.friendTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (UILabel *)footerLabel
{
    if (_footerLabel == nil) {
        _footerLabel= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50.0f)];
        [_footerLabel setTextAlignment:NSTextAlignmentCenter];
        [_footerLabel setFont:[UIFont systemFontOfSize:17.0f]];
        [_footerLabel setTextColor:[UIColor grayColor]];
    }
    return _footerLabel;
}

@end
