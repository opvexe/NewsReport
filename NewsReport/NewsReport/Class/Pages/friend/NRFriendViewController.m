//
//  NRFriendViewController.m
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRFriendViewController.h"
#import "NRFriendViewController+Delegate.h"
#import "NRFriendHelper.h"
#import "NRSearchBar.h"

@interface NRFriendViewController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)NRSearchBar *searchBar;
@property(nonatomic,strong) UILabel *footerLabel;
@property (nonatomic, strong) NRFriendHelper *friendHelper;
@end

@implementation NRFriendViewController

- (NRSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[NRSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.friendTableView.frame.size.width, 44)];
        _searchBar.backgroundColor = [UIColor yellowColor];
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
    [self.friendTableView setTableFooterView:self.footerLabel];
    [self loadFriends];
}

/*!
 * 获取好友列表
 */
-(void)loadFriends{
    self.friendHelper = [NRFriendHelper sharedFriendHelper];      // 初始化好友数据业务类
    self.data = self.friendHelper.data;
    self.sectionHeaders = self.friendHelper.sectionHeaders;
    [self.footerLabel setText:[NSString stringWithFormat:@"%ld位联系人", (long)self.friendHelper.friendCount]];
    
    WS(weakSelf)
    [self.friendHelper setDataChangedBlock:^(NSMutableArray *data, NSMutableArray *headers, NSInteger friendCount) {
        weakSelf.data = data;
        weakSelf.sectionHeaders = headers;
        [weakSelf.footerLabel setText:[NSString stringWithFormat:@"%ld位联系人", (long)friendCount]];
        [weakSelf.friendTableView reloadData];
    }];
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
        _friendTableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;
        _friendTableView.backgroundColor               = UIColorFromRGB(0xffffff);
        [self.view addSubview:_friendTableView];
    }
    return _friendTableView;
}

/*!
 * 布局
 */
-(void)updateViewConstraintsView{
    [self.friendTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}


- (UILabel *)footerLabel{
    if (_footerLabel == nil) {
        _footerLabel= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50.0f)];
        [_footerLabel setTextAlignment:NSTextAlignmentCenter];
        [_footerLabel setFont:[UIFont systemFontOfSize:17.0f]];
        [_footerLabel setTextColor:[UIColor grayColor]];
    }
    return _footerLabel;
}

@end
