//
//  NREmoji.m
//  NewsReport
//
//  Created by Facebook on 2018/2/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NREmoji.h"

@implementation NREmoji

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"emojiID" : @"pId",
             @"emojiURL" : @"Url",
             @"emojiName" : @"credentialName",
             @"emojiPath" : @"imageFile",
             @"size" : @"size",
             };
}

- (NSString *)emojiPath
{
    if (_emojiPath == nil) {
        NSString *groupPath = [NSFileManager pathExpressionForGroupID:self.groupID];
        _emojiPath = [NSString stringWithFormat:@"%@%@", groupPath, self.emojiID];
    }
    return _emojiPath;
}

@end
