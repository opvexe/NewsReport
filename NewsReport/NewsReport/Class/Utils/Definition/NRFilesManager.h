//
//  NRFilesManager.h
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#ifndef NRFilesManager_h
#define NRFilesManager_h

/*!
 系统库
 */
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <UIKit/UIKit.h>

/*!
 * 声网
 */
#import <CallKit/CallKit.h>
#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCallCenter.h>
#import <AgoraRtcEngineKit/AgoraRtcEngineKit.h>         ///AgoraRtcEngineKit 包含音频视频完整包
#import <AgoraSignalKit/AgoraSignalKit.h>              ///AgoraAPI信令

/*!
 宏文件
 */
#import "NRConst.h"
#import "Chat.h"
/*!
 自定义类
 */
#import "UIImage+NRExtension.h"
#import "UIView+NRExtension.h"
#import "NSString+LSWMEXtension.h"
#import "NSDate+NRCategory.h"
#import "NRBusinessNetworkTool.h"
#import "NRBarButtonItem.h"
#import "NRNewsReportTools.h"
#import "NRUserInfoDB.h"
#import "UIView+Toast.h"
#import "NRUserTools.h"
/*!
 Base类
 */
#import "NRBaseViewController.h"
#import "NRBaseTableViewCell.h"
#import "NRBaseModel.h"

/*!
 三方库
 */

#import <UIImageView+WebCache.h>
#import <FLAnimatedImageView+WebCache.h>
#import <CYLTabBarController/CYLTabBarController.h>
#import <TTTAttributedLabel.h>
#import <AFNetworking.h>
#import <Masonry.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <YYCache.h>
#import <FMDB.h>
/*!
 Chat库
 */
#import "ClientCoreSDK.h"
#import "ConfigEntity.h"
#import "NRIMClientManager.h"
#import "LocalUDPDataSender.h"

/*!
 消息数据基类
 */
#import "NRIMElem.h"
#import "NRIMTextElem.h"
#import "NRIMImageElem.h"
#import "NRIMSoundElem.h"
#import "NRIMFileElem.h"
#import "NRIMVideoElem.h"
#import "NRIMLocationElem.h"

#endif /* NRFilesManager_h */
