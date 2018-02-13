//
//  NRGroup+ChatModel.m
//  NewsReport
//
//  Created by Facebook on 2018/2/13.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRGroup+ChatModel.h"

@implementation NRGroup (ChatModel)

- (NSString *)chat_userID
{
    return self.groupID;
}

- (NSString *)chat_username
{
    return self.groupName;
}

- (NSString *)chat_avatarURL
{
    return nil;
}

- (NSString *)chat_avatarPath
{
    return self.groupAvatarPath;
}

- (NSInteger)chat_userType
{
    return ChatUserTypeGroup;
}

- (id)groupMemberByID:(NSString *)userID
{
    return [self memberByUserID:userID];
}

- (NSArray *)groupMembers
{
    return self.users;
}


@end
