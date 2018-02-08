//
//  NRIMUserModel.m
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRUser.h"
#import "NSString+PinYin.h"

@implementation NRUser


-(void)setNickName:(NSString *)nickName{
    if ([nickName isEqualToString:_nickName]) {
        return;
    }
    _nickName = nickName;
    if (self.remarkName.length == 0&&self.nickName.length>0) {
        self.pinyin = nickName.pinyin;
        self.pinyinInitial = nickName.pinyinInitial;
    }
}

- (void)setRemarkName:(NSString *)remarkName{
    if ([remarkName isEqualToString:_remarkName]) {
        return;
    }
    _remarkName = remarkName;
    if (_remarkName.length > 0) {
        self.pinyin = remarkName.pinyin;
        self.pinyinInitial = remarkName.pinyinInitial;
    }
}

- (NSString *)showName
{
    return self.remarkName.length > 0 ? self.remarkName : (self.nickName.length > 0 ? self.nickName : self.userName);
}

@end

