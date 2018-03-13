//
//  NRUser+ChatModel.m
//  NewsReport
//
//  Created by Facebook on 2018/2/13.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRUser+ChatModel.h"

@implementation NRUser (ChatModel)

- (NSString *)chat_userID
{
    return self.userId;
}

- (NSString *)chat_username
{
    return self.nickName;
}

- (NSString *)chat_avatarURL
{
    return self.userIcon;
}

- (NSString *)chat_avatarPath
{
    return nil;
}

- (NSInteger)chat_userType
{
    return ChatUserTypeUser;
}

@end
