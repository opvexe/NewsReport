//
//  NRConversationListViewController.m
//  NewsReport
//
//  Created by Facebook on 2018/1/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRConversationListViewController.h"
#import "NRChatViewController.h"
#import "NRConversationListCell.h"
#import "NRMessageManager.h"
#import "NRMessageManager+MessageCache.h"
#import "NRMessageManager+ConversationCache.h"
#import "NRConversation.h"
#import "NRMessage.h"
#import "NRFriendHelper.h"
#import "NRConversation+NRUser.h"
#import "NRConversation.h"

@interface NRConversationListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView    *conversationTableView;
@property (nonatomic,strong ) NSMutableArray *conversationDataSocure;
@end

@implementation NRConversationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"消息";
    [NRNotificationCenter addObserver:self selector:@selector(receiveMessage:) name:NRIMMessageReceiveConfigurationNotificationCenterKey object:nil];
    [NRNotificationCenter addObserver:self selector:@selector(networkStatusChange:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadDataSoucre];
}

/*!
 * 网络状态监听
 */
- (void)networkStatusChange:(NSNotification *)noti{
    AFNetworkReachabilityStatus status = [noti.userInfo[@"AFNetworkingReachabilityNotificationStatusItem"] longValue];
    switch (status) {
        case AFNetworkReachabilityStatusReachableViaWiFi:
        case AFNetworkReachabilityStatusReachableViaWWAN:
        case AFNetworkReachabilityStatusUnknown:
            [self.navigationItem setTitle:@"消息"];
            break;
        case AFNetworkReachabilityStatusNotReachable:
            [self.navigationItem setTitle:@"消息(未连接)"];
            break;
        default:
            break;
    }
}

/*!
 * 获取本地数据
 */
-(void)reloadDataSoucre{
    [[NRMessageManager sharedInstance]conversationRecord:^(NSArray *data) {
        
        for (NRConversation *conversation in data) {
            if (conversation.convType == ConversationTypeSingle) {
                NRUser *user = [[NRFriendHelper sharedFriendHelper] getFriendInfoByUserID:conversation.partnerID];
                [conversation updateUserInfo:user];
            }else if (conversation.convType == ConversationTypeGroup){
                NRGroup *group = [[NRFriendHelper sharedFriendHelper] getGroupInfoByGroupID:conversation.partnerID];
                [conversation updateGroupInfo:group];
            }
        }
        self.conversationDataSocure = [[NSMutableArray alloc]initWithArray:data];
        [self.conversationTableView reloadData];
    }];
}


/*!
 * 获取新消息
 */

-(void)receiveMessage:(NSNotification *)notification{
    
    [self reloadDataSoucre];
}

#pragma mark < ios 11 适配>
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
}

#pragma mark < UITableViewDelegate >
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.conversationDataSocure.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  Number(60.0);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NRConversationListCell *cell = [NRConversationListCell CellWithTableView:tableView];
    NRConversation *model = self.conversationDataSocure[indexPath.row];
    [cell InitDataWithModel:model];
    [cell setBottomLineStyle:indexPath.row == self.conversationDataSocure.count - 1 ? NRCellLineStyleFill : NRCellLineStyleDefault];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NRChatViewController *chat = [[ NRChatViewController alloc]init];
    
    NRConversation *conversation = self.conversationDataSocure[indexPath.row];
    if (conversation.convType == ConversationTypeSingle) {
        
     NRUser *user = [[NRFriendHelper sharedFriendHelper] getFriendInfoByUserID:conversation.partnerID];
      
        if (user == nil) {
            NSLog(@"好友不存在");
            return;
        }
        
//          [chat setPartner:user];
    }else if (conversation.convType == ConversationTypeGroup){
        
        NRGroup *group = [[NRFriendHelper sharedFriendHelper] getGroupInfoByGroupID:conversation.partnerID];

        if (group == nil) {
            NSLog(@"群组不存在");
            return;
        }
//           [chat setPartner:group];
    }
     [self.navigationController pushViewController:chat animated:YES];
    
    [(NRConversationListCell *)[self.conversationTableView cellForRowAtIndexPath:indexPath] markAsRead];
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WS(weakSelf)
    NRConversation *conversation = self.conversationDataSocure[indexPath.row];
    UITableViewRowAction *delAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                         title:@"删除"
                                                                       handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                       {
                                           [weakSelf.conversationDataSocure removeObjectAtIndex:indexPath.row];
                                           BOOL ok = [[NRMessageManager sharedInstance] deleteConversationByPartnerID:conversation.partnerID];
                                           if (!ok) {
                                               NSLog(@"从数据库中删除会话信息失败");
                                           }
                                           [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                                           if (self.conversationDataSocure.count > 0 && indexPath.row == self.conversationDataSocure.count) {
                                               NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
                                               NRConversationListCell *cell = [tableView cellForRowAtIndexPath:lastIndexPath];
                                               [cell setBottomLineStyle:NRCellLineStyleFill];
                                           }
                                       }];
    UITableViewRowAction *moreAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                          title:conversation.isRead ? @"标为未读" : @"标为已读"
                                                                        handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                        {
                                            NRConversationListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                                            conversation.isRead ? [cell markAsUnread] : [cell markAsRead];
                                            [tableView setEditing:NO animated:YES];
                                        }];
    moreAction.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    return @[delAction, moreAction];
}


/*!
 * 懒加载
 */
-(UITableView *)conversationTableView{
    if (!_conversationTableView) {
        _conversationTableView                                = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _conversationTableView.showsVerticalScrollIndicator   = NO;
        _conversationTableView.showsHorizontalScrollIndicator = NO;
        _conversationTableView.delegate                       = self;
        _conversationTableView.dataSource                     = self;
        _conversationTableView.tableFooterView                = [UIView new];
        _conversationTableView.separatorStyle                 = UITableViewCellSeparatorStyleSingleLine;
        _conversationTableView.backgroundColor               = UIColorFromRGB(0xffffff);
        UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 0, 0);
        if ([_conversationTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_conversationTableView setSeparatorInset:inset];
        }

        if ([_conversationTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_conversationTableView setLayoutMargins:inset];
        }
        [self.view addSubview:_conversationTableView];
    }
    return _conversationTableView;
}

-(NSMutableArray *)conversationDataSocure{
    if (!_conversationDataSocure) {
        _conversationDataSocure = [NSMutableArray arrayWithCapacity:0];
    }
    return _conversationDataSocure;
}


/*!
 * 布局
 */
-(void)updateViewConstraintsView{
    [self.conversationTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

/*!
 * dealloc
 */
-(void)dealloc{
    [NRNotificationCenter removeObserver:self];
}
@end

