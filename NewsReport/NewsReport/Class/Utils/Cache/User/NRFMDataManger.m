//
//  NRFMDataManger.m
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#define FileName @"DB"
#define DBNAME    @"NewsReport.db"

#import "NRFMDataManger.h"

@implementation NRFMDataManger
{
    NSString *database_path;
    FMDatabase *_db;
    FMDatabaseQueue *_dbQueue;
}

+(instancetype)shareFMDataMange{
    static NRFMDataManger *_mange=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mange = [[NRFMDataManger alloc] init];
    });
    return _mange;
}

-(instancetype)init{
    self= [super init];
    
    if (self) {
        
        NSString *path = getDocumentsFilePath(FileName);

        checkPathAndCreate(path);
        
        database_path = [NSString stringWithFormat:@"%@/%@",path,DBNAME];
        
        _db = [FMDatabase databaseWithPath:database_path];
        
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:database_path];
        
        NSLog(@"database_path:数据库地址:%@",database_path);
        
    }
    return self;
}

-(void)creatDBMange:(BOOL)isAsynch dbBlock:(DBMangeBlock )block{
    
    if (isAsynch) {
        
        dispatch_queue_t q= dispatch_queue_create("NR.db", DISPATCH_QUEUE_CONCURRENT);
        
        //异步请求数据库
        
        dispatch_async(q, ^{
            
            [_dbQueue inDatabase:^(FMDatabase *db) {
                
                block(db);
            }];
        });
        
    }else {
        
        if ([_db open]) {
            
            block (_db);
            
            [_db close];
        }
        
    }
    
}

-(BOOL)savaModel:(NSString *)sql isSynch:(BOOL)isSynchronous{
    
    if (isSynchronous) {
        
        dispatch_queue_t q = dispatch_queue_create("NR.db", DISPATCH_QUEUE_CONCURRENT  );
        //异步请求数据库
        
        dispatch_async(q, ^{
            [_dbQueue inDatabase:^(FMDatabase *db) {
                
                [db executeUpdate:sql];
            }];
        });
    }
    return YES;
}

-(unsigned long long)getFileSize{
    
    return   [NRNewsReportTools fileSizeForPath:database_path];
}

-(void)clearDB{
    NSFileManager * fileManager = [[NSFileManager alloc]init];
    [fileManager removeItemAtPath:database_path error:nil];
}


@end
