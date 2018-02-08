//
//  NRConversation+NRUser.m
//  NewsReport
//
//  Created by Facebook on 2018/2/8.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRConversation+NRUser.h"

@implementation NRConversation (NRUser)

- (void)updateUserInfo:(NRUser *)user{
    
    self.partnerName = user.showName;
    self.avatarPath = user.userIcon;
    self.avatarURL = user.userIcon;
}

- (void)updateGroupInfo:(NRGroup *)group{
    
    self.partnerName = group.groupName;
    self.avatarPath = group.groupAvatarPath;
}


@end
