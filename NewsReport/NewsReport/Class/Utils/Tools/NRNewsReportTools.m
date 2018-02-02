//
//  NRNewsReportTools.m
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRNewsReportTools.h"
#define  VALIDDAYS    7
#define  tempFilePath @"log/error"

@implementation NRNewsReportTools

+(NSString *) getAppVersion{
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return version;
}
+(NSString *) getAppBuildVersion{
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    return version;
}
+(BOOL)CheckWriteCrashFileOnDocumentsException:(NSDictionary *)exceptionDic{
    
    //获取时间
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    
    NSString *DateTime = [formatter stringFromDate:date];
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    //    NSString *crashname = [NSString stringWithFormat:@"%@_%@_%@Crashlog.log",ExecutabUUID(),DateTime,infoDic[@"CFBundleName"]];
    
    NSString *crashPath = [[self getFilePath] stringByAppendingString:tempFilePath];
    
    
    NSFileManager *manger = [NSFileManager defaultManager];
    
    //设备信息
    
    NSMutableDictionary *deviceInfos = [NSMutableDictionary dictionary];
    
    [deviceInfos setValue:[infoDic objectForKey:@"DTPlatformVersion"] forKey:@"DTPlatformVersion"];
    
    [deviceInfos setValue:[infoDic objectForKey:@"CFBundleShortVersionString"] forKey:@"CFBundleShortVersionString"];
    
    [deviceInfos setValue:[infoDic objectForKey:@"UIRequiredDeviceCapabilities"] forKey:@"UIRequiredDeviceCapabilities"];
    
    BOOL isSuccess = [manger createDirectoryAtPath:crashPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    if (isSuccess) {
        
        NSLog(@"文件夹创建成功");
        
        NSString *filepath = [crashPath stringByAppendingPathComponent:@""];
        
        NSMutableDictionary *logs = [NSMutableDictionary dictionaryWithContentsOfFile:filepath];
        
        if (!logs) {
            
            logs = [NSMutableDictionary dictionaryWithCapacity:0];
        }
        
        NSDictionary *infos = @{@"Exception":exceptionDic,@"DeviceInfo":deviceInfos};
        
        [logs setValue:infos forKey:[NSString stringWithFormat:@"%@_crashLogs",infoDic[@"CFBundleName"]]];
        
        BOOL writeOK = [logs writeToFile:filepath atomically:YES];
        
        NSLog(@"write result = %d,filePath = %@",writeOK,filepath);
        return writeOK;
    }else{
        
        return  NO;
    }
    
}

//获取日志
+(NSArray *)getCrashLog {
    
    NSString *crashFilePath = [[self getFilePath] stringByAppendingString:tempFilePath];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSArray *fileArray = [manager contentsOfDirectoryAtPath:crashFilePath error:nil];
    
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:0];
    
    if (fileArray.count ==0)return nil;
    
    for (NSString *fileName in fileArray) {
        
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[crashFilePath stringByAppendingPathComponent:fileName]];
        
        [results addObject:dict];
    }
    
    return results;
}
// 清理日志 有效期 7天
+(BOOL)clearCrashLog{
    
    NSString *crashFilePath = [[self getFilePath]stringByAppendingString:tempFilePath];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:crashFilePath]) return YES;
    
    NSArray *crashLogContents = [manager contentsOfDirectoryAtPath:crashFilePath error:NULL];
    
    if (crashLogContents.count==0) return  YES;
    
    __block  NSString *fileName ;
    [crashLogContents enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([self interval:[crashFilePath stringByAppendingPathComponent:obj]]>VALIDDAYS) {
            
            fileName = obj;
            
        }
    }];
    NSEnumerator *enums = [crashLogContents objectEnumerator];
    BOOL  success       = YES;
    
    NSError  *error ;
    
    while (fileName == [enums nextObject]) {
        
        if (![manager removeItemAtPath:[crashFilePath stringByAppendingPathComponent:fileName] error:&error]) {
            
            success = NO;
            
            break;
        }
        NSLog(@"清除文件成功");
    }
    
    return success;
    
}
// 创建文件路径
+(NSString *)getFilePath{
    
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}
//通过路径获取文件创建的时间
+(NSInteger )interval:(NSString *)path{
    
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    NSString *dateString     = [NSString stringWithFormat:@"%@",[attributes fileModificationDate]];
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    
    NSDate *formatterDate = [inputFormatter dateFromString:dateString];
    
    unsigned int unitFlags = NSDayCalendarUnit;
    
    NSCalendar *cal     = [NSCalendar currentCalendar];
    NSDateComponents *d = [cal components:unitFlags fromDate:formatterDate toDate:[NSDate date] options:0];
    
    NSInteger result = (NSUInteger)[d day];
    
    return result;
    
}

+(NSString *)getTimeTampWithDigit:(int)digit{
    NSTimeInterval timeTamp = [[NSDate date] timeIntervalSince1970];
    NSInteger timeInt = timeTamp*1000000;
    NSString *time = [NSString stringWithFormat:@"%ld",timeInt];
    return [time substringToIndex:digit];
}

+ (NSString *)homePath{
    return NSHomeDirectory();
}

+ (NSString *)appPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}



+ (NSString *)libPrefPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preferences"];
}

+ (NSString *)libCachePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}

+ (NSString *)tmpPath
{return [NSHomeDirectory() stringByAppendingFormat:@"/tmp"];
}

+ (NSString *)iTunesVideoImagePath{
    
    NSString *path = [[self libCachePath] stringByAppendingFormat:@"/iTunesVideoPhoto"];
    [self hasLive:path];
    return path;
    
}
+ (NSString *)AlbumVideoImagePath{
    
    NSString *path = [[self libCachePath] stringByAppendingFormat:@"/albumVideoPhoto"];
    [self hasLive:path];
    return path;
}


+ (BOOL)hasLive:(NSString *)path
{
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:path] )
    {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:NULL];
    }
    
    return YES;
}

+ (BOOL)fileExists:(NSString *)path{
    return  [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+(BOOL)deleteFile:(NSString *)path{
    if ([self fileExists:path]) {
        NSFileManager* fileManager=[NSFileManager defaultManager];
        return  [fileManager removeItemAtPath:path error:nil];
    }
    return YES;
}
+ (NSString *)docPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
+(long long)fileSizeForPath:(NSString *)path
{
    long long fileSize = 0;
    if([self fileExists:path]){
        NSError *error = nil;
        NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}

+ (long long)freeSpace{
    NSString* path = [self docPath];
    NSFileManager* fileManager = [[NSFileManager alloc ] init];
    NSDictionary *fileSysAttributes = [fileManager attributesOfFileSystemForPath:path error:nil];
    NSNumber *freeSpace = [fileSysAttributes objectForKey:NSFileSystemFreeSize];
    return [freeSpace longLongValue];
}

+ (long long)totalSpace{
    NSString* path = [self docPath];
    NSFileManager* fileManager = [[NSFileManager alloc ] init];
    NSDictionary *fileSysAttributes = [fileManager attributesOfFileSystemForPath:path error:nil];
    NSNumber *totalSpace = [fileSysAttributes objectForKey:NSFileSystemSize];
    return [totalSpace longLongValue];
}


@end
