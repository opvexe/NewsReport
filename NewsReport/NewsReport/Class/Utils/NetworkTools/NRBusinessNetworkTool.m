//
//  NRBusinessNetworkTool.m
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRBusinessNetworkTool.h"
#import "NRNetworkHelper.h"
#import "NREmojiGroup.h"
#import "NSString+URLEncode.h"

@implementation NRBusinessNetworkTool

+(void)PostLoginWithUserPassword:(NSString *)password username:(NSString *)username CompleteSuccessfull:(void (^)(id responseObject))successfull  failure:(void (^)(id error))failure{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:0];
    [parameters setValue:convertToString(username) forKey:@"name"];
    [parameters setValue:convertToString(password) forKey:@"password"];
    
    [NRNetworkHelper POST:PostLoginAuthenticationURL parameters:parameters success:^(id responseObject) {
        if (responseObject) {
            if ([responseObject[@"code"] intValue]==0&&!is_null(responseObject[@"result"])) {
                successfull?successfull(responseObject[@"result"]):nil;
            }else{
                failure?failure(responseObject[@"result"]):nil;
            }
        }
    } failure:^(NSError *error) {
        failure?failure(error):nil;
    }];
}

+(void)PostUpMessageWithImage:(UIImage *)image withImageName:(NSString *)imageName withImageType:(NSString *)imageType CompleteSuccessfull:(void (^)(id responseObject))successfull  failure:(void (^)(id error))failure{
    
    [NRNetworkHelper uploadWithURL:PostUpImageMessageURL parameters:nil images:@[image] name:imageName fileName:imageName mimeType:imageType progress:^(NSProgress *progress) {
        int64_t bytesWritten = progress.fractionCompleted;
        int64_t totalBytesWritten = progress.totalUnitCount;
        NSLog(@"上传: %.2f",bytesWritten*1.0/totalBytesWritten);
        
    } success:^(id responseObject) {
        if (responseObject) {
            
            successfull?successfull(responseObject[@"result"]):nil;
        }else{
            failure?failure(responseObject[@"result"]):nil;
        }
        
    } failure:^(NSError *error) {
        failure?failure(error):nil;
    }];
}


+(void)PostContactWithUserID:(NSString *)userID CompleteSuccessfull:(void (^)(id responseObject))successfull  failure:(void (^)(id error))failure{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:0];
    [parameters setValue:convertToString(userID) forKey:@"userId"];
    
    [NRNetworkHelper POST:PostContactURL parameters:parameters success:^(id responseObject) {
        if (responseObject) {
            
            successfull?successfull(responseObject[@"data"]):nil;
        }else{
            failure?failure(responseObject[@"data"]):nil;
        }
    } failure:^(NSError *error) {
        
        failure?failure(error):nil;
    }];
}








































#pragma mark  #表情组
/**
 *  精选表情
 */
+(void)requestExpressionChosenListByPageIndex:(NSInteger)page  CompleteSuccessfull:(void (^)(id responseObject))successfull  failure:(void (^)(id error))failure{
    
    NSString *urlString = [NSString stringWithFormat:IEXPRESSION_NEW_URL, (long)page];
    [NRNetworkHelper POST:urlString parameters:nil success:^(id responseObject) {
        NSArray *respArray = [responseObject mj_JSONObject];
        NSString *status = respArray[0];
        if ([status isEqualToString:@"OK"]) {
            NSArray *infoArray = respArray[2];
            NSMutableArray *data = [NREmojiGroup mj_objectArrayWithKeyValuesArray:infoArray];
            successfull?successfull(data):nil;
        }else {
            failure?failure(status):nil;
        }
    } failure:^(NSError *error) {
        failure?failure(error):nil;
    }];
}


/**
 *  精选表情Banner
 */
+(void)requestExpressionChosenBannerCompleteSuccessfull:(void (^)(id responseObject))successfull  failure:(void (^)(id error))failure{
    
    NSString *urlString = IEXPRESSION_BANNER_URL;
    [NRNetworkHelper POST:urlString parameters:nil success:^(id responseObject) {
        
        NSArray *respArray = [responseObject mj_JSONObject];
        NSString *status = respArray[0];
        if ([status isEqualToString:@"OK"]) {
            NSArray *infoArray = respArray[2];
            NSMutableArray *data = [NREmojiGroup mj_objectArrayWithKeyValuesArray:infoArray];
            successfull?successfull(data):nil;
        }else{
            failure?failure(status):nil;
        }
        
    } failure:^(NSError *error) {
        failure?failure(error):nil;
    }];
}

/**
 *  网络表情
 */
+(void)requestExpressionPublicListByPageIndex:(NSInteger)page  CompleteSuccessfull:(void (^)(id responseObject))successfull  failure:(void (^)(id error))failure{
    
    NSString *urlString = [NSString stringWithFormat:IEXPRESSION_PUBLIC_URL, (long)page];
    [NRNetworkHelper POST:urlString parameters:nil success:^(id responseObject) {
        
        NSArray *respArray = [responseObject mj_JSONObject];
        NSString *status = respArray[0];
        if ([status isEqualToString:@"OK"]) {
            NSArray *infoArray = respArray[2];
            NSMutableArray *data = [NREmojiGroup mj_objectArrayWithKeyValuesArray:infoArray];
            successfull?successfull(data):nil;
        }else{
            failure?failure(status):nil;
        }
        
    } failure:^(NSError *error) {
        failure?failure(error):nil;
    }];
}

/**
 *  表情搜索
 */
+(void)requestExpressionSearchByKeyword:(NSString *)keyword  CompleteSuccessfull:(void (^)(id responseObject))successfull  failure:(void (^)(id error))failure{
    
    NSString *urlString = [NSString stringWithFormat:IEXPRESSION_SEARCH_URL, [[keyword urlEncode] urlEncode]];
    [NRNetworkHelper POST:urlString parameters:nil success:^(id responseObject) {
        
        NSArray *respArray = [responseObject mj_JSONObject];
        NSString *status = respArray[0];
        if ([status isEqualToString:@"OK"]) {
            NSArray *infoArray = respArray[2];
            NSMutableArray *data = [NREmojiGroup mj_objectArrayWithKeyValuesArray:infoArray];
            successfull?successfull(data):nil;
        }else{
            failure?failure(status):nil;
        }
        
    } failure:^(NSError *error) {
        failure?failure(error):nil;
    }];
}

/**
 *  表情详情
 */
+(void)requestExpressionGroupDetailByGroupID:(NSString *)groupID
                                   pageIndex:(NSInteger)pageIndex  CompleteSuccessfull:(void (^)(id responseObject))successfull  failure:(void (^)(id error))failure{
    
    NSString *urlString = [NSString stringWithFormat:IEXPRESSION_DETAIL_URL, (long)pageIndex, groupID];
    [NRNetworkHelper POST:urlString parameters:nil success:^(id responseObject) {
        
        NSArray *respArray = [responseObject mj_JSONObject];
        NSString *status = respArray[0];
        if ([status isEqualToString:@"OK"]) {
            NSArray *infoArray = respArray[2];
            NSMutableArray *data = [NREmojiGroup mj_objectArrayWithKeyValuesArray:infoArray];
            successfull?successfull(data):nil;
        }else{
            failure?failure(status):nil;
        }
        
    } failure:^(NSError *error) {
        failure?failure(error):nil;
    }];
}

@end

