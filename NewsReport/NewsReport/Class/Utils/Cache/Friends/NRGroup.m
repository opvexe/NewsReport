//
//  NRGroup.m
//  NewsReport
//
//  Created by Facebook on 2018/2/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRGroup.h"
#import "NSString+PinYin.h"

@implementation NRGroup

- (id)init
{
    if (self = [super init]) {
        [NRGroup mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"users" : @"NRUser" };
        }];
    }
    return self;
}


- (NSInteger)count
{
    return self.users.count;
}

- (void)addObject:(id)anObject
{
    [self.users addObject:anObject];
}

- (id)objectAtIndex:(NSUInteger)index
{
    return [self.users objectAtIndex:index];
}

- (NRUser *)memberByUserID:(NSString *)uid
{
    for (NRUser *user in self.users) {
        if ([user.userId isEqualToString:uid]) {
            return user;
        }
    }
    return nil;
}

- (NSString *)groupName
{
    if (_groupName == nil || _groupName.length == 0) {
        for (NRUser *user in self.users) {
            if (user.showName.length > 0) {
                if (_groupName == nil || _groupName.length <= 0) {
                    _groupName = user.showName;
                }
                else {
                    _groupName = [NSString stringWithFormat:@"%@,%@", _groupName, user.showName];
                }
            }
        }
    }
    return _groupName;
}

- (NSString *)myNikeName
{
    if (_myNikeName.length == 0) {
//        _myNikeName = [TLUserHelper sharedHelper].user.showName;
    }
    return _myNikeName;
}

- (NSString *)pinyin
{
    if (_pinyin == nil) {
        _pinyin = self.groupName.pinyin;
    }
    return _pinyin;
}

- (NSString *)pinyinInitial
{
    if (_pinyinInitial == nil) {
        _pinyinInitial = self.groupName.pinyinInitial;
    }
    return _pinyinInitial;
}

- (NSString *)groupAvatarPath
{
    if (_groupAvatarPath == nil) {
        _groupAvatarPath = [self.groupID stringByAppendingString:@".png"];
    }
    return _groupAvatarPath;
}

@end
