//
//  NREmojiGroup.m
//  NewsReport
//
//  Created by Facebook on 2018/2/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NREmojiGroup.h"

@implementation NREmojiGroup

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"groupID" : @"eId",
             @"groupIconURL" : @"coverUrl",
             @"groupName" : @"eName",
             @"groupInfo" : @"memo",
             @"groupDetailInfo" : @"memo1",
             @"count" : @"picCount",
             @"bannerID" : @"aId",
             @"bannerURL" : @"URL",
             };
}

- (void)setData:(NSMutableArray *)data
{
    _data = data;
    self.count = data.count;
    self.pageItemCount = self.rowNumber * self.colNumber;
    self.pageNumber = self.count / self.pageItemCount + (self.count % self.pageItemCount == 0 ? 0 : 1);
}

- (id)objectAtIndex:(NSUInteger)index
{
    return [self.data objectAtIndex:index];
}

- (NSUInteger)rowNumber
{
    if (self.type == EmojiTypeFace || self.type == EmojiTypeEmoji) {
        return 3;
    }
    return 2;
}

- (NSUInteger)colNumber
{
    if (self.type == EmojiTypeFace || self.type == EmojiTypeEmoji) {
        return 7;
    }
    return 4;
}

- (NSUInteger)pageItemCount
{
    if (self.type == EmojiTypeFace || self.type == EmojiTypeEmoji) {
        return self.rowNumber * self.colNumber - 1;
    }
    return self.rowNumber * self.colNumber;
}

- (NSUInteger)pageNumber
{
    return self.count / self.pageItemCount + (self.count % self.pageItemCount == 0 ? 0 : 1);
}

- (NSString *)path
{
    if (_path == nil && self.groupID != nil) {
        _path = [NSFileManager pathExpressionForGroupID:self.groupID];
    }
    return _path;
}

- (NSString *)groupIconPath
{
    if (_groupIconPath == nil && self.path != nil) {
        _groupIconPath = [NSString stringWithFormat:@"%@icon_%@", self.path, self.groupID];
    }
    return _groupIconPath;
}

@end
