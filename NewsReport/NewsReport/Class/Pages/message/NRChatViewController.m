//
//  NRMessageViewController.m
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRChatViewController.h"
#import <ZLPhotoActionSheet.h>
#import <ZLPhotoConfiguration.h>
#import <ZLPhotoManager.h>
#import <Photos/Photos.h>
#import "ZLCustomCamera.h"
#import "ChatKeyBoard.h"
#import "FaceSourceManager.h"
#import "NRImagePickModel.h"
#import "WXRecordView.h"
#import "WXDeviceManager.h"
#import "WXError.h"
#import "NRChatMessageCell.h"

@interface NRChatViewController ()<UITableViewDelegate,UITableViewDataSource,ChatKeyBoardDelegate,ChatKeyBoardDataSource,WXDeviceManagerProximitySensorDelegate>
@property(nonatomic,strong) UITableView *chatTableView;
@property(nonatomic,strong) NSMutableArray *morePanelItems;
@property(nonatomic,strong) NSMutableArray *chats;
@property(nonatomic,strong) ChatKeyBoard *chatKeyBoard;
@property(nonatomic,strong) WXRecordView *recordView;
@property(nonatomic,strong) NSMutableArray<UIImage *> *lastSelectPhotos;
@property(nonatomic,strong) NSMutableArray<PHAsset *> *lastSelectAssets;
@property(nonatomic,strong) NSMutableArray *lastSelectProcessedDatas;
@property(nonatomic,assign) BOOL isOriginal;
@property(nonatomic,assign) BOOL isEditor;
@end

@implementation NRChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title =  [NSString stringWithFormat:@"与%@聊天",_userName];
    [self addPopBackBarButtonItem];
    [self updateViewConstraintsView];
    [self receiveMessageNotification];
    [self reloadDataSoucre];
    [WXDeviceManager sharedInstance].delegate = self;
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
    NRIMElem *messageModel = self.chats[indexPath.row];
    return  [NRChatMessageCell cellHeightWithModel:messageModel];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NRChatMessageCell *cell = [NRChatMessageCell CellWithChatTableView:tableView];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.chatKeyBoard keyboardDown];
}

#pragma MARK < ChatKeyBoardDelegate >

/*！
 *  文本消息
 */
- (void)chatKeyBoardSendText:(NSString *)text{
    NRIMTextElem *message = [[NRIMTextElem alloc]init];
    message.messageType = MessageTypeText;
    message.from = [[NRUserTools defaultCenter]getUserID];
    message.to  = convertToString(_targetId);
    message.text = convertToString(text);
    message.messageId = convertToString( [NSString stringWithFormat:@"%@+%@",[[NRUserTools defaultCenter]getUserID],[NRNewsReportTools getTimeTampWithDigit:13]]);
    [self sendMessageWithText:message CompletecBlock:^(int code) {
        if (code == COMMON_CODE_OK) {
            NSLog(@"文本消息发送成功");
        }else{
            NSLog(@"文本消息发送失败");
        }
    }];
}

/*！
 *  图片消息
 */
-(void)sendMessageWithImages{
    [self.lastSelectProcessedDatas enumerateObjectsUsingBlock:^(NRImagePickModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
}

/*！
 *  更多功能
 */
- (void)chatKeyBoard:(ChatKeyBoard *)chatKeyBoard didSelectMorePanelItemIndex:(NSInteger)index{
    [self.chatKeyBoard keyboardDown];
    MoreItem *item = self.morePanelItems[index];
    if ([item.itemName isEqualToString:@"图片"]) {
        [self.lastSelectProcessedDatas removeAllObjects];
        [self showPhotoLibray];
    }
    
    if ([item.itemName isEqualToString:@"拍照"]) {
        ZLCustomCamera *camera = [[ZLCustomCamera alloc] init];
        camera.allowRecordVideo = NO;
        camera.doneBlock = ^(UIImage *image, NSURL *videoUrl) {
            
            
        };
        [self presentViewController:camera animated:YES completion:nil];
    }
    
    if ([item.itemName isEqualToString:@"小视频"]) {
        ZLCustomCamera *camera = [[ZLCustomCamera alloc] init];
        camera.circleProgressColor =[UIColor greenColor];
        camera.maxRecordDuration = 60;
        camera.allowRecordVideo = YES;
        WS(weakSelf)
        camera.doneBlock = ^(UIImage *image, NSURL *videoUrl) {
            
            
        };
        [self presentViewController:camera animated:YES completion:nil];
        
    }
    
    if ([item.itemName isEqualToString:@"位置"]) {
        
        
    }
    
    if ([item.itemName isEqualToString:@"语音通话"]) {
        
        
    }
    
    if ([item.itemName isEqualToString:@"视频通话"]) {
        
        
    }
    
    if ([item.itemName isEqualToString:@"文件"]) {
        
        
    }
}

/*！
 *  表情
 */
- (void)chatKeyBoardFacePicked:(ChatKeyBoard *)chatKeyBoard faceStyle:(NSInteger)faceStyle faceName:(NSString *)faceName delete:(BOOL)isDeleteKey{
    
    
}

#pragma mark < Recording >

/*！
 *  开始录音
 */
- (void)chatKeyBoardDidStartRecording:(ChatKeyBoard *)chatKeyBoard{
    [self.recordView recordButtonTouchDown];
    
    int x = arc4random() % 100000;
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString *fileName = [NSString stringWithFormat:@"%d%d",(int)time,x];
    [[WXDeviceManager sharedInstance] asyncStartRecordingWithFileName:fileName completion:^(NSError *error){
        if (error) {
            NSLog(@"%@",@"开始录音失败");
        }
    }];
}

/*！
 *  取消录音
 */
- (void)chatKeyBoardDidCancelRecording:(ChatKeyBoard *)chatKeyBoard{
    [self.recordView recordButtonTouchUpOutside];
}

/*！
 *  完成录音
 */
- (void)chatKeyBoardDidFinishRecoding:(ChatKeyBoard *)chatKeyBoard{
    [self.recordView recordButtonTouchUpInside];
    
    [[WXDeviceManager sharedInstance] asyncStopRecordingWithCompletion:^(NSString *recordPath, NSInteger aDuration, NSError *error) {
        if (!error) {
            
        }else{
            NSLog(@"录音时间太短了");
        }
    }];
}

/*！
 *  将要取消录音
 */
- (void)chatKeyBoardWillCancelRecoding:(ChatKeyBoard *)chatKeyBoard{
    [self.recordView recordButtonDragOutside];
}

/*！
 *  继续录音
 */
- (void)chatKeyBoardContineRecording:(ChatKeyBoard *)chatKeyBoard{
    [self.recordView recordButtonDragInside];
}

#pragma mark  < WXDeviceManagerProximitySensorDelegate >

- (void)proximitySensorChanged:(BOOL)isCloseToUser{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if (isCloseToUser){
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    } else {
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[WXDeviceManager sharedInstance] disableProximitySensor];
    }
    [audioSession setActive:YES error:nil];
}

#pragma mark  < ChatKeyBoardDataSource >
- (NSArray<MoreItem *> *)chatKeyBoardMorePanelItems{
    [self.morePanelItems removeAllObjects];
    
    MoreItem *item1 = [MoreItem moreItemWithPicName:@"chatBar_colorMore_photo" highLightPicName:nil itemName:@"图片"];
    MoreItem *item2 = [MoreItem moreItemWithPicName:@"chatBar_colorMore_camera" highLightPicName:nil itemName:@"拍照"];
    MoreItem *item3 = [MoreItem moreItemWithPicName:@"chatBar_colorMore_video" highLightPicName:nil itemName:@"小视频"];
    MoreItem *item4 = [MoreItem moreItemWithPicName:@"chatBar_colorMore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item5 = [MoreItem moreItemWithPicName:@"chatBar_colorMore_audioCall" highLightPicName:nil itemName:@"语音通话"];
    MoreItem *item6 = [MoreItem moreItemWithPicName:@"chatBar_colorMore_videoCall" highLightPicName:nil itemName:@"视频通话"];
    MoreItem *item7 = [MoreItem moreItemWithPicName:@"chatBar_colorMore_photo" highLightPicName:nil itemName:@"文件"];
    [self.morePanelItems addObjectsFromArray:@[item1, item2, item3, item4, item5, item6, item7]];
    
    return self.morePanelItems;
}

- (NSArray<ChatToolBarItem *> *)chatKeyBoardToolbarItems{
    ChatToolBarItem *item1 = [ChatToolBarItem barItemWithKind:kBarItemFace normal:@"face" high:@"face_HL" select:@"keyboard"];
    ChatToolBarItem *item2 = [ChatToolBarItem barItemWithKind:kBarItemVoice normal:@"voice" high:@"voice_HL" select:@"keyboard"];
    ChatToolBarItem *item3 = [ChatToolBarItem barItemWithKind:kBarItemMore normal:@"more_ios" high:@"more_ios_HL" select:nil];
    ChatToolBarItem *item4 = [ChatToolBarItem barItemWithKind:kBarItemSwitchBar normal:@"switchDown" high:nil select:nil];
    
    return @[item1, item2, item3, item4];
}

- (NSArray<FaceThemeModel *> *)chatKeyBoardFacePanelSubjectItems{
    return [FaceSourceManager loadFaceSource];
}

#pragma MARK  < ZLCustomCamera >
-(void)showPhotoLibray{
    ZLPhotoActionSheet *photoActionSheetView = [[ZLPhotoActionSheet alloc] init];
    ZLPhotoConfiguration *configuration = [ZLPhotoConfiguration defaultPhotoConfiguration];
    configuration.sortAscending = NO;
    configuration.allowSelectImage = YES;
    configuration.allowSelectGif = NO;
    configuration.allowSelectVideo = NO;
    configuration.allowSelectLivePhoto = NO;
    configuration.allowForceTouch = NO;
    configuration.allowEditImage = NO;
    configuration.allowEditVideo = NO;
    configuration.allowSlideSelect = YES;
    configuration.allowDragSelect = YES;
    configuration.allowMixSelect = NO;
    //设置相册内部显示拍照按钮
    configuration.allowTakePhotoInLibrary = YES;
    //设置在内部拍照按钮上实时显示相机俘获画面
    configuration.showCaptureImageOnTakePhotoBtn = YES;
    //设置照片最大预览数
    configuration.maxPreviewCount = 100;
    //设置照片最大选择数
    configuration.maxSelectCount =  9 - self.lastSelectPhotos.count;
    configuration.maxVideoDuration  = 999999;
    //单选模式是否显示选择按钮
    configuration.showSelectBtn = YES;
    //是否在选择图片后直接进入编辑界面
    configuration.editAfterSelectThumbnailImage = NO;
    //是否在已选择照片上显示遮罩层
    configuration.showSelectedMask = NO;
    configuration.clipRatios = @[GetClipRatio(1, 1)];
    //颜色，状态栏样式
    configuration.selectedMaskColor = UIColorFromRGB(0xFF758C);
    configuration.navBarColor =  [UIColor blackColor];
    configuration.navTitleColor = UIColorFromRGB(0X323232);
    configuration.bottomBtnsNormalTitleColor =  UIColorFromRGB(0xFF758C);
    configuration.bottomBtnsDisableBgColor =  UIColorFromRGB(0xFF758C);
    configuration.bottomViewBgColor =  UIColorFromRGB(0xffffff);
    configuration.statusBarStyle = UIStatusBarStyleDefault;
    //是否允许框架解析图片
    configuration.shouldAnialysisAsset = YES;
    configuration.exportVideoType = ZLExportVideoTypeMp4;
    photoActionSheetView.configuration = configuration;
    photoActionSheetView.sender = self;
    WS(weakSelf)
    [photoActionSheetView setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        NSMutableArray *dataSocure = [NSMutableArray arrayWithCapacity:0];
        WSSTRONG(strongSelf)
        strongSelf.isEditor  = YES;
        strongSelf.isOriginal  =isOriginal;
        [strongSelf.lastSelectAssets addObjectsFromArray:assets.mutableCopy];
        [strongSelf.lastSelectPhotos addObjectsFromArray:images.mutableCopy];
        NSLog(@"image:%@", images);
        for (int  i = 0 ; i<strongSelf.lastSelectAssets.count; i++) {
            PHAsset *asset = strongSelf.lastSelectAssets[i];
            NRImagePickModel *model = [[NRImagePickModel alloc]init];
            if (asset.mediaType == PHAssetMediaTypeVideo) {     ///视频
                model.pushType = PhotosPushTypeVideo;
                model.durationStr = [ZLPhotoManager getDuration:asset];
                model.duration = [asset duration];
            }else{
                model.pushType = PhotosPushTypeImage;
            }
            model.image = strongSelf.lastSelectPhotos[i];
            [dataSocure addObject:model];
        }
        strongSelf.lastSelectProcessedDatas = [NSMutableArray arrayWithArray:dataSocure];
        [strongSelf sendMessageWithImages];
    }];
    [photoActionSheetView showPhotoLibrary];
}

/*!
 * 懒加载
 */

-(ChatKeyBoard *)chatKeyBoard{
    if (!_chatKeyBoard) {
        _chatKeyBoard =  [ChatKeyBoard keyBoard];
        _chatKeyBoard.delegate = self;
        _chatKeyBoard.dataSource = self;
        _chatKeyBoard.keyBoardStyle = KeyBoardStyleChat;
        _chatKeyBoard.associateTableView = self.chatTableView;
    }
    return _chatKeyBoard;
}

- (WXRecordView *)recordView{
    if (!_recordView){
        _recordView = [[WXRecordView alloc] init];
        _recordView.layer.cornerRadius = 10;
        _recordView.clipsToBounds      = YES;
        _recordView.hidden             = YES;
        _recordView.backgroundColor    = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        [self.view addSubview:_recordView];
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
    
    [self.recordView mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.mas_equalTo (@(140));
        make.height.mas_equalTo (@(140));
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.centerY.equalTo(self.view.mas_centerY).with.offset(0);
    }];
}
@end

