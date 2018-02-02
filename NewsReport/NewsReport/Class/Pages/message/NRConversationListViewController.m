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
#import "NRConversationListModel.h"
#import "NRIMElem.h"

@interface NRConversationListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView    *messageTableView;
@property (nonatomic,strong ) NSMutableArray *messageDataSocure;
@end

@implementation NRConversationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"消息";
    [self updateViewConstraintsView];
    [self receiveMessageNotification];
    [self reloadDataSoucre];
    
}

/*!
 * 获取本地数据
 */
-(void)reloadDataSoucre{
    
    
    
    
}

/*!
 * 消息通知
 */
-(void)receiveMessageNotification{
    [NRNotificationCenter addObserver:self selector:@selector(receiveMessage:) name:NRIMMessageReceiveConfigurationNotificationCenterKey object:nil];
}

/*!
 * 获取新消息
 */

-(void)receiveMessage:(NSNotification *)notification{
    
    __block NSString *signature = @"" ;
    NRIMElem *message = (NRIMElem *)notification.object;
    Class MessageElem = [message class];
    
    if (MessageElem == [NRIMTextElem class]) {
        NRIMTextElem *text = (NRIMTextElem *)message;
        signature = text.text;
    }else if (MessageElem == [NRIMImageElem class]){
        signature =@"[图片]";
    }else if (MessageElem == [NRIMSoundElem class]){
        signature =@"[语音]";
    }else if (MessageElem == [NRIMFileElem class]){
        signature =@"[文件]";
    }else{
        signature =@"[未知消息]";
    }
    
    NRConversationListModel *model = [[NRConversationListModel alloc]init];
    model.signature = convertToString(signature);
    model.time = message.timestamp;
    model.name = message.from;
    [self.messageDataSocure addObject:model];
    [self.messageTableView reloadData];
    
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageDataSocure.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  Number(60.0);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NRConversationListCell *cell = [NRConversationListCell CellWithTableView:tableView];
    NRConversationListModel *model = self.messageDataSocure[indexPath.row];
    [cell InitDataWithModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NRConversationListModel *model = self.messageDataSocure[indexPath.row];
    NRChatViewController *chat = [[ NRChatViewController alloc]init];
    chat.targetId = model.name;
    chat.userName = model.name;
    [self.navigationController pushViewController:chat animated:YES];
}

/*!
 * 编辑
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                                               title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                                   
                                                                               }];
    deleteRowAction.backgroundColor  = [UIColor redColor] ;
    
    return @[deleteRowAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

/*!
 * 懒加载
 */
-(UITableView *)messageTableView{
    if (!_messageTableView) {
        _messageTableView                                = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _messageTableView.showsVerticalScrollIndicator   = NO;
        _messageTableView.showsHorizontalScrollIndicator = NO;
        _messageTableView.delegate                       = self;
        _messageTableView.dataSource                     = self;
        _messageTableView.tableFooterView                = [UIView new];
        _messageTableView.separatorStyle                 = UITableViewCellSeparatorStyleSingleLine;
        _messageTableView.backgroundColor               = UIColorFromRGB(0xffffff);
        [self.view addSubview:_messageTableView];
    }
    return _messageTableView;
}

-(NSMutableArray *)messageDataSocure{
    if (!_messageDataSocure) {
        _messageDataSocure = [NSMutableArray arrayWithCapacity:0];
    }
    return _messageDataSocure;
}


/*!
 * 布局
 */
-(void)updateViewConstraintsView{
    [self.messageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
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

