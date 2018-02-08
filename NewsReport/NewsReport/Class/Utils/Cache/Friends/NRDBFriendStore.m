//
//  NRDBFriendStore.m
//  NewsReport
//
//  Created by Facebook on 2018/2/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRDBFriendStore.h"
#import "NRDBFriendSQL.h"

@implementation NRDBFriendStore

- (id)init{
    if (self = [super init]) {
        self.dbQueue = [NRDBManager sharedInstance].commonQueue;
        BOOL ok = [self createTable];
        if (!ok) {
            NSLog(@"DB: 好友表创建失败");
        }
    }
    return self;
}

- (BOOL)createTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_FRIENDS_TABLE, FRIENDS_TABLE_NAME];
    return [self createTable:FRIENDS_TABLE_NAME withSQL:sqlString];
}

- (BOOL)addFriend:(NRUser *)user forUid:(NSString *)uid
{
    NSString *sqlString = [NSString stringWithFormat:SQL_UPDATE_FRIEND, FRIENDS_TABLE_NAME];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        convertToString(uid),
                        convertToString(user.userId),
                        convertToString(user.userName),
                        convertToString(user.nickName),
                        convertToString(user.userIcon),
                        convertToString(user.remarkName),
                        @"", @"", @"", @"", @"", nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    return ok;
}

- (BOOL)updateFriendsData:(NSArray *)friendData forUid:(NSString *)uid
{
    NSArray *oldData = [self friendsDataByUid:uid];
    if (oldData.count > 0) {
        // 建立新数据的hash表，用于删除数据库中的过时数据
        NSMutableDictionary *newDataHash = [[NSMutableDictionary alloc] init];
        for (NRUser *user in friendData) {
            [newDataHash setValue:@"YES" forKey:user.userId];
        }
        for (NRUser *user in oldData) {
            if ([newDataHash objectForKey:user.userId] == nil) {
                BOOL ok = [self deleteFriendByFid:user.userId forUid:uid];
                if (!ok) {
                    NSLog(@"DBError: 删除过期好友失败");
                }
            }
        }
    }
    
    for (NRUser *user in friendData) {
        BOOL ok = [self addFriend:user forUid:uid];
        if (!ok) {
            return ok;
        }
    }
    
    return YES;
}

- (NSMutableArray *)friendsDataByUid:(NSString *)uid
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_FRIENDS, FRIENDS_TABLE_NAME, uid];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            NRUser *user = [[NRUser alloc] init];
            user.userId = [retSet stringForColumn:@"uid"];
            user.userName = [retSet stringForColumn:@"username"];
            user.nickName = [retSet stringForColumn:@"nikename"];
            user.userIcon = [retSet stringForColumn:@"avatar"];
            user.remarkName = [retSet stringForColumn:@"remark"];
            [data addObject:user];
        }
        [retSet close];
    }];
    
    return data;
}

- (BOOL)deleteFriendByFid:(NSString *)fid forUid:(NSString *)uid
{
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_FRIEND, FRIENDS_TABLE_NAME, uid, fid];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}

@end

