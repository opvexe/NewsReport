//
//  NRDBFriendStore.h
//  NewsReport
//
//  Created by Facebook on 2018/2/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRDBBaseStore.h"

@interface NRDBFriendStore : NRDBBaseStore

/**
 *  更新朋友信息
 */
- (BOOL)updateFriendsData:(NSArray *)friendData
                   forUid:(NSString *)uid;

/**
 *  添加朋友
 */
- (BOOL)addFriend:(NRUser *)user forUid:(NSString *)uid;


/**
 *  查找朋友
 */
- (NSMutableArray *)friendsDataByUid:(NSString *)uid;

/**
 *  删除朋友
 */
- (BOOL)deleteFriendByFid:(NSString *)fid forUid:(NSString *)uid;

@end
