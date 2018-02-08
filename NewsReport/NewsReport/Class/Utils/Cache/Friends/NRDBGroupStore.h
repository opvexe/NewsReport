//
//  NRDBGroupStore.h
//  NewsReport
//
//  Created by Facebook on 2018/2/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRDBBaseStore.h"
#import "NRGroup.h"

@interface NRDBGroupStore : NRDBBaseStore

/**
 *  更新朋友信息
 */
- (BOOL)updateGroupsData:(NSArray *)groupData
                  forUid:(NSString *)uid;

/**
 *  添加朋友
 */
- (BOOL)addGroup:(NRGroup *)group forUid:(NSString *)uid;


/**
 *  查找朋友
 */
- (NSMutableArray *)groupsDataByUid:(NSString *)uid;


/**
 *  删除朋友
 */

- (BOOL)deleteGroupByGid:(NSString *)gid forUid:(NSString *)uid;

@end
