//
//  NRUserInfoDB.m
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRUserInfoDB.h"
#import "NRFMDataManger.h"
#import "NRUser.h"
#define TableName  @"NRUserInfoDB"


@interface NRUserInfoDB(){
    
    NRFMDataManger *_dataManger;
}
@end
static NRUserInfoDB *_db =nil;

@implementation NRUserInfoDB

+(instancetype)shareDB{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_db ==nil) {
            _db = [[NRUserInfoDB alloc] init];
        }
    });
    return _db;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _dataManger = [NRFMDataManger shareFMDataMange];
        [self creatTable];
    }
    return self;
}

/*!
 *  创建表
 */
-(void)creatTable{
    [_dataManger creatDBMange:NO dbBlock:^(FMDatabase *_db) {
        if ([_db open] ) {
            NSString * sqlCreateTable = [NSMutableString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ \
                                         (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, \
                                         userId VARCHAR, \
                                         nickName VARCHAR, \
                                         tel VARCHAR, \
                                         userIcon VARCHAR, \
                                         token VARCHAR,\
                                         userName VARCHAR, \
                                         mediaId VARCHAR, \
                                         depId VARCHAR, \
                                         latitude VARCHAR, \
                                         longitude VARCHAR, \
                                         created_at VARCHAR)",TableName];
            
            BOOL res = [_db executeUpdate:sqlCreateTable];
            if (!res) {
                NSLog(@"error when creating db table");
            } else {
                NSLog(@"success to creating db table");
            }
            
            [_db close];
        }
        
    }];
}

/*!
 *  保存数据(数组)
 */
-(BOOL)saveDataSocre:(NSArray*)dataSoucre{
    __block BOOL isSave ;
    [dataSoucre enumerateObjectsUsingBlock:^(NRUser * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        isSave = [self saveModel:obj];
    }];
    
    return isSave;
}

/*!
 *  存储数据
 */
-(BOOL)saveModel:(NRUser *)model {
    
    if ([self findWithGid:convertToString(FormatString(@"%zd",model.userId))]) {
        
        return  [self updateWithModel:model];
    }
    __block BOOL isOk = NO;
    
    [_dataManger creatDBMange:NO dbBlock:^(FMDatabase *_db) {
        
        NSMutableString * query = [NSMutableString stringWithFormat:@"INSERT INTO %@ ",TableName];
        NSMutableString * keys = [NSMutableString stringWithFormat:@" ("];
        NSMutableString * values = [NSMutableString stringWithFormat:@" ( "];
        NSMutableArray * arguments = [NSMutableArray arrayWithCapacity:30];
        [keys appendString:@"userId,"];
        [values appendString:@"?,"];
        [arguments addObject:convertToString(FormatString(@"%zd",model.userId))];
        [keys appendString:@"nickName,"];
        [values appendString:@"?,"];
        [arguments addObject:convertToString(model.nickName)];
        [keys appendString:@"tel,"];
        [values appendString:@"?,"];
        [arguments addObject:convertToString(model.tel)];
        [keys appendString:@"userIcon,"];
        [values appendString:@"?,"];
        [arguments addObject:convertToString(model.userIcon)];
        [keys appendString:@"token,"];
        [values appendString:@"?,"];
        [arguments addObject:convertToString(model.token)];
        [keys appendString:@"userName,"];
        [values appendString:@"?,"];
        [arguments addObject:convertToString(model.userName)];
        [keys appendString:@"mediaId,"];
        [values appendString:@"?,"];
        [arguments addObject:convertToString(FormatString(@"%zd",model.mediaId))];
        [keys appendString:@"depId,"];
        [values appendString:@"?,"];
        [arguments addObject:convertToString(FormatString(@"%zd",model.depId))];
        [keys appendString:@"latitude,"];
        [values appendString:@"?,"];
        [arguments addObject:convertToString(FormatString(@"%lf",model.latitude))];
        [keys appendString:@"longitude,"];
        [values appendString:@"?,"];
        [arguments addObject:convertToString(FormatString(@"%lf",model.longitude))];
        [keys appendString:@")"];
        [values appendString:@")"];
        [query appendFormat:@" %@ VALUES%@",
         [keys stringByReplacingOccurrencesOfString:@",)" withString:@")"],
         [values stringByReplacingOccurrencesOfString:@",)" withString:@")"]];
        
        isOk = [_db executeUpdate:query withArgumentsInArray:arguments];
        
    }];
    return isOk;
    
}

/*!
 *  删除数据
 */
-(BOOL)delModelWithGid:(NSString * )gid{
    if ( gid ==nil) {
        return NO;
    }
    __block BOOL isOk = NO;
    [_dataManger creatDBMange:NO dbBlock:^(FMDatabase *_db) {
        NSMutableString * query = [NSMutableString stringWithFormat:@"DELETE FROM %@ ",TableName];
        [query appendFormat:@" where userId = '%@'",gid];
        isOk=[_db executeUpdate:query];
        
    }];
    return isOk;
}

/*！
 *   更新数据
 */
-(BOOL)updateWithModel:(NRUser *)model{
    
    if (model==nil ||convertToString(FormatString(@"%zd",model.userId)) ==nil ) {
        return NO;
    }
    
    __block BOOL isOk = NO;
    
    [_dataManger creatDBMange:NO dbBlock:^(FMDatabase *_db) {
        
        NSMutableString * query = [NSMutableString stringWithFormat:@"UPDATE %@ SET ",TableName];
        NSMutableArray * arguments = [NSMutableArray arrayWithCapacity:5];
    
        [query appendString:@"userId=?,"];
        [arguments addObject:FormatString(@"%zd",model.userId)];
        
        if(model.nickName!=nil){
            [query appendString:@"nickName=?,"];
            [arguments addObject:model.nickName];
        }
        
        if(model.tel!=nil){
            [query appendString:@"tel=?,"];
            [arguments addObject:model.tel];
        }
        
        if(model.userIcon!=nil){
            [query appendString:@"userIcon=?,"];
            [arguments addObject:model.userIcon];
        }
        
        
        if(model.token!=nil){
            [query appendString:@"token=?,"];
            [arguments addObject:model.token];
        }
        
        if(model.userName!=nil){
            [query appendString:@"userName=?,"];
            [arguments addObject:model.userName];
        }
        
        [query appendString:@"mediaId=?,"];
        [arguments addObject:FormatString(@"%zd",model.mediaId)];
        
        [query appendString:@"depId=?,"];
        [arguments addObject:FormatString(@"%zd",model.depId)];
        
        [query appendString:@"latitude=?,"];
        [arguments addObject:FormatString(@"%lf",model.latitude)];
        
        [query appendString:@"longitude=?,"];
        [arguments addObject:FormatString(@"%lf",model.longitude)];
        
        [query appendString:@")"];

        if([query hasSuffix:@",)"]){
            [query replaceCharactersInRange:NSMakeRange(query.length-2, 2) withString:@" "];
            [query stringByReplacingOccurrencesOfString:@",)" withString:@""];
        }
        [query appendFormat:@" where userId = '%@'",convertToString(FormatString(@"%zd",model.userId))];
        isOk = [_db executeUpdate:query withArgumentsInArray:arguments];
        
    }];
    return isOk;
    
}

/*!
 *  查找数据
 */
-(NRUser *)findWithGid:(NSString * )gid{
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM  %@",TableName];
    
    query = [query stringByAppendingFormat:@" where userId = '%@'",gid];
    __block NRUser *model = nil;
    
    [_dataManger creatDBMange:NO dbBlock:^(FMDatabase *_db) {
        
        FMResultSet *rs = [_db executeQuery:query];
        
        if ([rs next]) {
            
            model = [self parseResultSet:rs];
            
            [rs close];
        }
        
    }];
    return model;
}

/*!
 *  查找所有数据
 */
-(NSMutableArray*)findAllModel{
    __block NSMutableArray *array = [NSMutableArray array];
    [_dataManger creatDBMange:NO dbBlock:^(FMDatabase *_db) {
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM  %@ ",TableName];
        
        FMResultSet *rs = [_db executeQuery:query];
        
        while ([rs next]) {
            
            NRUser * model  = [self parseResultSet:rs];
            
            [array addObject:model];
            
        }
        [rs close];
        
    }];
    
    return [[[array reverseObjectEnumerator] allObjects] mutableCopy];
}
/*！
 *  删除表
 */
-(BOOL )clearTable{
    __block BOOL isOk = NO;
    [_dataManger creatDBMange:NO dbBlock:^(FMDatabase *_db) {
        NSString * sql = [NSString stringWithFormat:@"delete from %@ ;\
                          update sqlite_sequence SET seq = 0 where name = '%@'",TableName,TableName];
        
        isOk = [_db executeUpdate:sql];
    }];
    
    return isOk;
}

-(NRUser *) parseResultSet:(FMResultSet *)rs{
    NRUser *model=[NRUser new];
    @try {
        model.userId = [convertToString([rs stringForColumn:@"userId"]) longLongValue];
        model.nickName = convertToString([rs stringForColumn:@"nickName"]);
        model.tel = convertToString([rs stringForColumn:@"tel"]);
        model.userIcon = convertToString([rs stringForColumn:@"userIcon"]);
        model.token=convertToString([rs stringForColumn:@"token"]);
        model.userName=convertToString([rs stringForColumn:@"userName"]);
        model.mediaId=[convertToString([rs stringForColumn:@"mediaId"]) longLongValue];
        model.depId= [convertToString([rs stringForColumn:@"depId"]) longLongValue];
        model.latitude = [convertToString([rs stringForColumn:@"latitude"]) floatValue];
        model.longitude = [convertToString([rs stringForColumn:@"longitude"]) floatValue];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    return model;
}

@end

