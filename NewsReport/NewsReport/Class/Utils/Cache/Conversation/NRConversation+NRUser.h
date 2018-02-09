//
//  NRConversation+NRUser.h
//  NewsReport
//
//  Created by Facebook on 2018/2/8.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRConversation.h"
#import "NRGroup.h"
#import "NRUser.h"

@interface NRConversation (NRUser)

- (void)updateUserInfo:(NRUser *)user;

- (void)updateGroupInfo:(NRGroup *)group;

@end
