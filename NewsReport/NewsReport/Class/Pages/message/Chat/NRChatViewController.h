//
//  NRMessageViewController.h
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZLPhotoActionSheet.h>
#import <ZLPhotoConfiguration.h>
#import <ZLPhotoManager.h>
#import <Photos/Photos.h>
#import "ZLCustomCamera.h"
#import "NRChatUserProtocol.h"
#import "NRPhotoLibraryManager.h"
#import "NRSoundRecorder.h"
#import "WXRecordView.h"
#import "FaceSourceManager.h"
#import "NRImagePickModel.h"
#import "WXDeviceManager.h"
#import "WXError.h"
/*!
 * 会话类
 */
@interface NRChatViewController : NRBaseViewController
/*!
 用户信息
 */
@property (nonatomic, strong) id<NRChatUserProtocol> user;

/*!
 聊天对象
 */
@property (nonatomic, strong) id<NRChatUserProtocol> partner;
/*!
 聊天键盘类
 */
@property(nonatomic,strong) ChatKeyBoard *chatKeyBoard;

@property(nonatomic,strong) NSMutableArray *morePanelItems;
@property(nonatomic,strong) NSMutableArray<UIImage *> *lastSelectPhotos;
@property(nonatomic,strong) NSMutableArray<PHAsset *> *lastSelectAssets;
@property(nonatomic,strong) NSMutableArray *lastSelectProcessedDatas;
@property(nonatomic,assign) BOOL isOriginal;
@property(nonatomic,assign) BOOL isEditor;

/*!
 录音展示类
 */
@property(nonatomic,strong) WXRecordView *recordView;

@end
