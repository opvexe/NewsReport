//
//  NRFriendHelper.h
//  NewsReport
//
//  Created by Facebook on 2018/2/8.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NRUserGroup.h"
#import "NRGroup.h"

@interface NRFriendHelper : NSObject

/// 好友列表默认项
@property (nonatomic, strong) NRUserGroup *defaultGroup;

#pragma mark - # 好友

/// 好友数据(原始)
@property (nonatomic, strong) NSMutableArray *friendsData;

/// 格式化的好友数据（二维数组，列表用）
@property (nonatomic, strong) NSMutableArray *data;

/// 格式化好友数据的分组标题
@property (nonatomic, strong) NSMutableArray *sectionHeaders;

///  好友数量
@property (nonatomic, assign, readonly) NSInteger friendCount;

@property (nonatomic, strong) void(^dataChangedBlock)(NSMutableArray *friends, NSMutableArray *headers, NSInteger friendCount);


#pragma mark - # 群
/// 群数据
@property (nonatomic, strong) NSMutableArray *groupsData;


#pragma mark - # 标签
/// 标签数据
@property (nonatomic, strong) NSMutableArray *tagsData;


+ (NRFriendHelper *)sharedFriendHelper;

- (NRUser *)getFriendInfoByUserID:(NSString *)userID;

- (NRGroup *)getGroupInfoByGroupID:(NSString *)groupID;
@end
