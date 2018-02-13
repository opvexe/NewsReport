//
//  NRFriendViewController+Delegate.m
//  NewsReport
//
//  Created by Facebook on 2018/2/5.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRFriendViewController+Delegate.h"
#import "NRFriendDetailViewController.h"
#import "NRFriendHeaderView.h"
#import "NRFriendTableViewCell.h"
#import "NRUserGroup.h"
#import "NRUser.h"

@implementation NRFriendViewController (Delegate)

/*!
 * 注册Cell
 */
- (void)registerCellClass{
    [self.friendTableView registerClass:[NRFriendHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([NRFriendHeaderView class])];
    [self.friendTableView registerClass:[NRFriendTableViewCell class] forCellReuseIdentifier:NSStringFromClass([NRFriendTableViewCell class])];
}


#pragma mark  < UITableViewDataSource >
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NRUserGroup *group = [self.data objectAtIndex:section];
    return group.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    NRUserGroup *group = [self.data objectAtIndex:section];
    NRFriendHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([NRFriendHeaderView class])];
    [view setTitle:group.groupName];
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NRFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NRFriendTableViewCell class])];
    NRUserGroup *group = [self.data objectAtIndex:indexPath.section];
    NRUser *user = [group objectAtIndex:indexPath.row];
    [cell setUser:user];
    
    if (indexPath.section == self.data.count - 1 && indexPath.row == group.count - 1){  // 最后一个cell，底部全线
        [cell setBottomLineStyle:NRCellLineStyleFill];
    }
    else {
        [cell setBottomLineStyle:indexPath.row == group.count - 1 ? NRCellLineStyleNone : NRCellLineStyleDefault];
    }
    
    return cell;
}


// 拼音首字母检索
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.sectionHeaders;
}

// 检索时空出搜索框
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    if(index == 0) {
        [self.friendTableView scrollRectToVisible:CGRectMake(0, 0, tableView.width, tableView.height) animated:NO];
        return -1;
    }
    return index;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Number(54.0f);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return Number(22.0f);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NRUser *user = [self.data[indexPath.section] objectAtIndex:indexPath.row];
     if (indexPath.section == 0) {
    
         NSLog(@"群组,公众号");
     }else{
         
         NRFriendDetailViewController *detailController = [[NRFriendDetailViewController alloc]init];
        [self.navigationController pushViewController:detailController animated:YES];
     }
      [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark < UISearchBarDelegate >
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    
}



@end
