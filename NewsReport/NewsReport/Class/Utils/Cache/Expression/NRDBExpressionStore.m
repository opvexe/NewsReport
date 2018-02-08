//
//  NRDBExpressionStore.m
//  NewsReport
//
//  Created by Facebook on 2018/2/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRDBExpressionStore.h"
#import "NRDBExpressionSQL.h"
#import "NREmoji.h"

@implementation NRDBExpressionStore

- (id)init
{
    if (self = [super init]) {
        self.dbQueue = [NRDBManager sharedInstance].commonQueue;
        BOOL ok = [self createTable];
        if (!ok) {
            NSLog(@"DB: 聊天记录表创建失败");
        }
    }
    return self;
}

- (BOOL)createTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_EXP_GROUP_TABLE, EXP_GROUP_TABLE_NAME];
    BOOL ok = [self createTable:EXP_GROUP_TABLE_NAME withSQL:sqlString];
    if (!ok) {
        return NO;
    }
    sqlString = [NSString stringWithFormat:SQL_CREATE_EXPS_TABLE, EXPS_TABLE_NAME];
    ok = [self createTable:EXPS_TABLE_NAME withSQL:sqlString];
    return ok;
}

#pragma mark - # 表情组
- (BOOL)addExpressionGroup:(NREmojiGroup *)group forUid:(NSString *)uid
{
    // 添加表情包
    NSString *sqlString = [NSString stringWithFormat:SQL_ADD_EXP_GROUP, EXP_GROUP_TABLE_NAME];
    NSArray *arr = [NSArray arrayWithObjects:
                    uid,
                    group.groupID,
                    [NSNumber numberWithInteger:group.type],
                    convertToString(group.groupName),
                    convertToString(group.groupInfo),
                    convertToString(group.groupDetailInfo),
                    [NSNumber numberWithInteger:group.count],
                    convertToString(group.authID),
                    convertToString(group.authName),
                    NRTimeStamp(group.date),
                    @"", @"", @"", @"", @"", nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arr];
    if (!ok) {
        return NO;
    }
    // 添加表情包里的所有表情
    ok = [self addExpressions:group.data toGroupID:group.groupID];
    return ok;
}

- (NSArray *)expressionGroupsByUid:(NSString *)uid
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat: SQL_SELECT_EXP_GROUP, EXP_GROUP_TABLE_NAME, uid];
    
    // 读取表情包信息
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            NREmojiGroup *group = [[NREmojiGroup alloc] init];
            group.groupID = [retSet stringForColumn:@"gid"];
            group.type = [retSet intForColumn:@"type"];
            group.groupName = [retSet stringForColumn:@"name"];
            group.groupInfo = [retSet stringForColumn:@"desc"];
            group.groupDetailInfo = [retSet stringForColumn:@"detail"];
            group.count = [retSet intForColumn:@"count"];
            group.authID = [retSet stringForColumn:@"auth_id"];
            group.authName = [retSet stringForColumn:@"auth_name"];
            group.status = EmojiGroupStatusDownloaded;
            [data addObject:group];
        }
        [retSet close];
    }];
    
    // 读取表情包的所有表情信息
    for (NREmojiGroup *group in data) {
        group.data = [self expressionsForGroupID:group.groupID];
    }
    
    return data;
}

- (BOOL)deleteExpressionGroupByID:(NSString *)gid forUid:(NSString *)uid
{
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_EXP_GROUP, EXP_GROUP_TABLE_NAME, uid, gid];
    return [self excuteSQL:sqlString, nil];
}

- (NSInteger)countOfUserWhoHasExpressionGroup:(NSString *)gid
{
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_COUNT_EXP_GROUP_USERS, EXP_GROUP_TABLE_NAME, gid];
    __block NSInteger count = 0;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        count = [db intForQuery:sqlString];
    }];
    
    return count;
}

#pragma mark - # 表情
- (BOOL)addExpressions:(NSArray *)expressions toGroupID:(NSString *)groupID
{
    for (NREmoji *emoji in expressions) {
        NSString *sqlString = [NSString stringWithFormat:SQL_ADD_EXP, EXPS_TABLE_NAME];
        NSArray *arr = [NSArray arrayWithObjects:
                        groupID,
                        emoji.emojiID,
                        convertToString(emoji.emojiName),
                        @"", @"", @"", @"", @"", nil];
        BOOL ok = [self excuteSQL:sqlString withArrParameter:arr];
        if (!ok) {
            return NO;
        }
    }
    return YES;
}

- (NSMutableArray *)expressionsForGroupID:(NSString *)groupID
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat: SQL_SELECT_EXPS, EXPS_TABLE_NAME, groupID];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            NREmoji *emoji = [[NREmoji alloc] init];
            emoji.groupID = [retSet stringForColumn:@"gid"];
            emoji.emojiID = [retSet stringForColumn:@"eid"];
            emoji.emojiName = [retSet stringForColumn:@"name"];
            [data addObject:emoji];
        }
        [retSet close];
    }];
    
    return data;
}

@end

