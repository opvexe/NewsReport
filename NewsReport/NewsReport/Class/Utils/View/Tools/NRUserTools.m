//
//  NRUserTools.m
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRUserTools.h"

static NRUserTools *defaultUserCenter = nil;
@implementation NRUserTools

+ (NRUserTools *)defaultCenter{
    @synchronized(self){
        if (defaultUserCenter == nil) {
            defaultUserCenter = [[NRUserTools alloc] init];
        }
    }
    return defaultUserCenter;
}
/*!
 保存登录用户名
 */
- (void)updateUserName:(NSString *)userName{
    [NRUserDefaults setValue:convertToString(userName) forKey:NR_UserName];
    [NRUserDefaults synchronize];
}

/*!
 保存登录密码
 */
- (void)updatePassword:(NSString *)password{
    [NRUserDefaults setValue:convertToString(password) forKey:NR_Password];
    [NRUserDefaults synchronize];
}

/*!
 用户ID
 */
-(void)updateUserID:(NSString *)userID{
    [NRUserDefaults setValue:convertToString(userID) forKey:NR_UserID];
    [NRUserDefaults synchronize];
}






- (NSString *)getUserName{
    return [NRUserDefaults valueForKey:NR_UserName];
}

- (NSString *)getUserPassword{
    return [NRUserDefaults valueForKey:NR_Password];
}

- (NSString *)getUserID{
    return [NRUserDefaults valueForKey:NR_UserID];
}

@end

