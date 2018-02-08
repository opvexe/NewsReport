//
//  NRDBManager.m
//  NewsReport
//
//  Created by Facebook on 2018/2/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRDBManager.h"

@implementation NRDBManager

static NRDBManager *manager;

+ (NRDBManager *)sharedInstance
{
    static dispatch_once_t once;
    NSString *userID = [[NRUserHelper defaultCenter] getUserID];
    dispatch_once(&once, ^{
        manager = [[NRDBManager alloc] initWithUserID:userID];
    });
    return manager;
}

- (id)initWithUserID:(NSString *)userID{
    if (self = [super init]) {
        NSString *commonQueuePath = [NSFileManager pathDBCommon];
        self.commonQueue = [FMDatabaseQueue databaseQueueWithPath:commonQueuePath];
        NSString *messageQueuePath = [NSFileManager pathDBMessage];
        self.messageQueue = [FMDatabaseQueue databaseQueueWithPath:messageQueuePath];
    }
    return self;
}

- (id)init{
    NSLog(@"请使用 initWithUserID: 方法初始化");
    return nil;
}

@end
