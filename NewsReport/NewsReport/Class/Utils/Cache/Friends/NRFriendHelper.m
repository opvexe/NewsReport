//
//  NRFriendHelper.m
//  NewsReport
//
//  Created by Facebook on 2018/2/8.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRFriendHelper.h"
#import "NRDBFriendStore.h"
#import "NRDBGroupStore.h"

@interface NRFriendHelper ()

@property (nonatomic, strong) NRDBFriendStore *friendStore;
@property (nonatomic, strong) NRDBGroupStore *groupStore;
@end

@implementation NRFriendHelper

static NRFriendHelper *friendHelper = nil;

+ (NRFriendHelper *)sharedFriendHelper{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        friendHelper = [[NRFriendHelper alloc] init];
    });
    return friendHelper;
}

- (id)init{
    if (self = [super init]) {
        // 初始化好友数据
        self.friendsData = [self.friendStore friendsDataByUid:[[NRUserHelper defaultCenter]getUserID]];
        self.data = [[NSMutableArray alloc] initWithObjects:self.defaultGroup, nil];
        self.sectionHeaders = [[NSMutableArray alloc] initWithObjects:UITableViewIndexSearch, nil];
        // 初始化群数据
        self.groupsData = [self.groupStore groupsDataByUid:[[NRUserHelper defaultCenter]getUserID]];
        // 初始化标签数据
        self.tagsData = [[NSMutableArray alloc] init];
        [self intWithContacts];
    }
    return self;
}


- (NRUser *)getFriendInfoByUserID:(NSString *)userID
{
    if (userID == nil) {
        return nil;
    }
    for (NRUser *user in self.friendsData) {
        if ([user.userId isEqualToString:userID]) {
            return user;
        }
    }
    return nil;
}

- (NRGroup *)getGroupInfoByGroupID:(NSString *)groupID
{
    if (groupID == nil) {
        return nil;
    }
    for (NRGroup *group in self.groupsData) {
        if ([group.groupID isEqualToString:groupID]) {
            return group;
        }
    }
    return nil;
}


- (void)p_resetFriendData{
    // 1、排序
    NSArray *serializeArray = [self.friendsData sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        int i;
        NSString *strA = ((NRUser *)obj1).pinyin;
        NSString *strB = ((NRUser *)obj2).pinyin;
        for (i = 0; i < strA.length && i < strB.length; i ++) {
            char a = toupper([strA characterAtIndex:i]);
            char b = toupper([strB characterAtIndex:i]);
            if (a > b) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            else if (a < b) {
                return (NSComparisonResult)NSOrderedAscending;
            }
        }
        if (strA.length > strB.length) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        else if (strA.length < strB.length){
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    // 2、分组
    NSMutableArray *ansData = [[NSMutableArray alloc] initWithObjects:self.defaultGroup, nil];
    NSMutableArray *ansSectionHeaders = [[NSMutableArray alloc] initWithObjects:UITableViewIndexSearch, nil];
    NSMutableDictionary *tagsDic = [[NSMutableDictionary alloc] init];
    char lastC = '1';
    NRUserGroup *curGroup;
    NRUserGroup *othGroup = [[NRUserGroup alloc] init];
    [othGroup setGroupName:@"#"];
    for (NRUser *user in serializeArray) {
        // 获取拼音失败
        if (user.pinyin == nil || user.pinyin.length == 0) {
            [othGroup addObject:user];
            continue;
        }
        
        char c = toupper([user.pinyin characterAtIndex:0]);
        if (!isalpha(c)) {      // #组
            [othGroup addObject:user];
        }
        else if (c != lastC){
            if (curGroup && curGroup.count > 0) {
                [ansData addObject:curGroup];
                [ansSectionHeaders addObject:curGroup.groupName];
            }
            lastC = c;
            curGroup = [[NRUserGroup alloc] init];
            [curGroup setGroupName:[NSString stringWithFormat:@"%c", c]];
            [curGroup addObject:user];
        }
        else {
            [curGroup addObject:user];
        }
        
        // TAGs
        //        if (user.detailInfo.tags.count > 0) {
        //            for (NSString *tag in user.detailInfo.tags) {
        //                NRUserGroup *group = [tagsDic objectForKey:tag];
        //                if (group == nil) {
        //                    group = [[NRUserGroup alloc] init];
        //                    group.groupName = tag;
        //                    [tagsDic setObject:group forKey:tag];
        //                    [self.tagsData addObject:group];
        //                }
        //                [group.users addObject:user];
        //            }
        //        }
    }
    if (curGroup && curGroup.count > 0) {
        [ansData addObject:curGroup];
        [ansSectionHeaders addObject:curGroup.groupName];
    }
    if (othGroup.count > 0) {
        [ansData addObject:othGroup];
        [ansSectionHeaders addObject:othGroup.groupName];
    }
    
    [self.data removeAllObjects];
    [self.data addObjectsFromArray:ansData];
    [self.sectionHeaders removeAllObjects];
    [self.sectionHeaders addObjectsFromArray:ansSectionHeaders];
    if (self.dataChangedBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dataChangedBlock(self.data, self.sectionHeaders, self.friendCount);
        });
    }
}


/*!
 * 获取通讯录好友列表
 */
- (void)intWithContacts{
    
    @synchronized(self) {
        [NRBusinessNetworkTool PostContactWithUserID:[[NRUserHelper defaultCenter]getUserID] CompleteSuccessfull:^(id responseObject) {
            
            NSLog(@"获取通讯录好友列表:%@",responseObject);
            NSArray *arr = [NRUser mj_objectArrayWithKeyValuesArray:responseObject];
            [self.friendsData removeAllObjects];
            [self.friendsData addObjectsFromArray:arr];
            BOOL ok = [self.friendStore updateFriendsData:self.friendsData forUid:[[NRUserHelper defaultCenter]getUserID]];         // 更新好友数据到数据库
            if (!ok) {
                NSLog(@"保存好友数据到数据库失败!");
            }
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [self p_resetFriendData];
            });
            
        } failure:^(id error) {
            
            NSLog(@"获取好友列表数据失败");
        }];
        
    }
    
    
    
    //    // 好友数据
    ////    NSString *path = [[NSBundle mainBundle] pathForResource:@"FriendList" ofType:@"json"];
    ////    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    ////    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    //
    //
    //    // 群数据
    //    path = [[NSBundle mainBundle] pathForResource:@"FriendGroupList" ofType:@"json"];
    //    jsonData = [NSData dataWithContentsOfFile:path];
    //    jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    //    arr = [NRGroup mj_objectArrayWithKeyValuesArray:jsonArray];
    //    [self.groupsData removeAllObjects];
    //    [self.groupsData addObjectsFromArray:arr];
    //    ok = [self.groupStore updateGroupsData:self.groupsData forUid:[[NRUserHelper defaultCenter]getUserID]];
    //    if (!ok) {
    //        NSLog(@"保存群数据到数据库失败!");
    //    }
    ////    // 生成Group Icon
    ////    for (NRGroup *group in self.groupsData) {
    ////        [TLUIUtility createGroupAvatar:group finished:nil];
    ////    }
}


- (NRUserGroup *)defaultGroup{
    
    if (_defaultGroup == nil) {
        NRUser *item_new = [[NRUser alloc] init];
        item_new.userId = @"-1";
        item_new.userIcon = @"friends_new";
        item_new.remarkName = @"新的朋友";
        NRUser *item_group = [[NRUser alloc] init];
        item_group.userId = @"-2";
        item_group.userIcon = @"friends_group";
        item_group.remarkName = @"群聊";
        _defaultGroup = [[NRUserGroup alloc] initWithGroupName:nil users:[NSMutableArray arrayWithObjects:item_new, item_group, nil]];
    }
    return _defaultGroup;
}

- (NSInteger)friendCount
{
    return self.friendsData.count;
}

- (NRDBFriendStore *)friendStore
{
    if (_friendStore == nil) {
        _friendStore = [[NRDBFriendStore alloc] init];
    }
    return _friendStore;
}

- (NRDBGroupStore *)groupStore
{
    if (_groupStore == nil) {
        _groupStore = [[NRDBGroupStore alloc] init];
    }
    return _groupStore;
}

@end

