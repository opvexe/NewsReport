//
//  NRMessageViewController.m
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRChatViewController.h"
#import "NRChatViewController+ChatBar.h"
#import "NRChatMessageCell.h"

@interface NRChatViewController ()<UITableViewDelegate,UITableViewDataSource,NRChatMessageCellDelegate>
@property(nonatomic,strong) UITableView *chatTableView;
@property(nonatomic,strong) NSMutableArray *chats;
@property(nonatomic,strong)UIBarButtonItem *rightBarButton;
@end

@implementation NRChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //     Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addPopBackBarButtonItem];
    [self updateViewConstraintsView];
    [self configView];
    [WXDeviceManager sharedInstance].delegate = self;
}

/*！
 *  设置会话对象
 */
- (void)setPartner:(id<NRChatUserProtocol>)partner{

    if (_partner && [[_partner chat_userID] isEqualToString:[partner chat_userID]]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self reloadAfterReceiveMessage];
        });
        return;
    }
    
    
    _partner = partner;
    [self.navigationItem setTitle:[NSString stringWithFormat:@"与%@聊天",[_partner chat_username]]];
}


-(void)configView{
    WS(weakSelf)
    self.chatTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf tableViewDidTriggerFooterRefresh];
        [weakSelf.chatTableView.mj_footer beginRefreshing];
    }];
    self.chatTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf tableViewDidTriggerHeaderRefresh];
        [weakSelf.chatTableView.mj_header beginRefreshing];
    }];
}

/*！
 *  下拉刷新
 */
- (void)tableViewDidTriggerHeaderRefresh{
    
    [self.chats removeAllObjects];
    [self loadDataSoucre];
}

/*！
 *  上拉刷新
 */
- (void)tableViewDidTriggerFooterRefresh{
    
    [self loadDataSoucre];
}

-(void)reloadDataSoucre{
    self.chatTableView.mj_header.hidden  =NO;
    self.chatTableView.mj_footer.hidden  =NO;
    [self loadDataSoucre];
}

/*！
 * 获取聊天消息
 */
- (void)loadDataSoucre{
    
    
    
}

/**
 *  刷新会话列表
 */
- (void)reloadAfterReceiveMessage{
    [self.chatTableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chats.count - 1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
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

#pragma mark  < UITableViewDataSource >

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.chats.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NRMessage *messageModel = self.chats[indexPath.row];
    return  [NRChatMessageCell cellHeightWithModel:messageModel];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NRChatMessageCell *cell = [NRChatMessageCell CellWithChatTableView:tableView];
    NRMessage *messageModel = self.chats[indexPath.row];
    cell.delegate = self;
    [cell refreshData:messageModel];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.chatKeyBoard keyboardDown];
}

#pragma mark < NRChatMessageCellDelegate >

/*!
 * 点击消息
 */
- (void)clickCellMessageContentViewWithMessageModel:(NRMessage *)messageModel{
    
}
/*!
 * 点击头像
 */
- (void)clickCellHeadImageWithMessageModel:(NRMessage *)messageModel{
    
}
/*!
 * 长按消息
 */
- (void)longPressCellMessageContentViewWithMessageModel:(NRMessage *)messageModel{
    
}
/*!
 * 撤回消息
 */
- (void)reSendCellWithMessageModel:(NRMessage *)messageModel{
    
}


/*!
 * 懒加载
 */

-(ChatKeyBoard *)chatKeyBoard{
    if (!_chatKeyBoard) {
        _chatKeyBoard =  [ChatKeyBoard keyBoardWithNavgationBarTranslucent:NO];
        _chatKeyBoard.delegate = self;
        _chatKeyBoard.dataSource = self;
        _chatKeyBoard.keyBoardStyle = KeyBoardStyleChat;
        _chatKeyBoard.associateTableView = self.chatTableView;
    }
    return _chatKeyBoard;
}

- (WXRecordView *)recordView{
    if (!_recordView){
        _recordView = [[WXRecordView alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
        _recordView.center = self.view.center;
        _recordView.hidden = YES;
    }
    return _recordView;
}

-(UITableView *)chatTableView{
    if (!_chatTableView) {
        _chatTableView                                = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49) style:UITableViewStylePlain];
        _chatTableView.showsVerticalScrollIndicator   = NO;
        _chatTableView.showsHorizontalScrollIndicator = NO;
        _chatTableView.delegate                       = self;
        _chatTableView.dataSource                     = self;
        _chatTableView.tableFooterView                = [UIView new];
        _chatTableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;
        _chatTableView.backgroundColor               = UIColorFromRGB(0xffffff);
    }
    return _chatTableView;
}

-(NSMutableArray *)chats{
    if (!_chats) {
        _chats = [NSMutableArray arrayWithCapacity:0];
    }
    return _chats;
}

- (NSMutableArray *)morePanelItems{
    if (!_morePanelItems) {
        _morePanelItems = [NSMutableArray array];
    }
    return _morePanelItems;
}

-(NSMutableArray<UIImage *> *)lastSelectPhotos{
    if (!_lastSelectPhotos) {
        
        _lastSelectPhotos = [NSMutableArray arrayWithCapacity:0];
    }
    return _lastSelectPhotos;
}

-(NSMutableArray<PHAsset *> *)lastSelectAssets{
    if (!_lastSelectAssets) {
        _lastSelectAssets = [NSMutableArray arrayWithCapacity:0];
    }
    return _lastSelectAssets;
}

/*!
 * 布局
 */
-(void)updateViewConstraintsView{
    
    [self.view addSubview:self.chatTableView];
    [self.view addSubview:self.chatKeyBoard];
    [self.view addSubview:self.recordView];
    
    //    [self.recordView mas_makeConstraints:^(MASConstraintMaker *make){
    //        make.width.mas_equalTo (@(140));
    //        make.height.mas_equalTo (@(140));
    //        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
    //        make.centerY.equalTo(self.view.mas_centerY).with.offset(0);
    //    }];
}
@end

