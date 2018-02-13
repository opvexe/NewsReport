//
//  NRChatUserProtocol.h
//  NewsReport
//
//  Created by Facebook on 2018/2/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ChatUserType) {
    ChatUserTypeUser = 0,
    ChatUserTypeGroup,
};

/*!
 * 用户信息转换
 */
@protocol NRChatUserProtocol <NSObject>

@property (nonatomic, strong, readonly) NSString *chat_userID;

@property (nonatomic, strong, readonly) NSString *chat_username;

@property (nonatomic, strong, readonly) NSString *chat_avatarURL;

@property (nonatomic, strong, readonly) NSString *chat_avatarPath;

@property (nonatomic, assign, readonly) NSInteger chat_userType;

@optional;
- (id)groupMemberByID:(NSString *)userID;

- (NSArray *)groupMembers;

@end
