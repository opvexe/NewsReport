//
//  AudioConverter.m
//  AmrToWav
//
//  Created by AllenLee on 2017/6/10.
//  Copyright © 2017年 Allen Lee. All rights reserved.
//

#import "AudioConverter.h"
#import "amrFileCodec.h"

@implementation AudioConverter

+ (void)convertAmrToWavAtPath:(NSString *)amrFilePath wavSavePath:(NSString *)resultSavePath asynchronize:(BOOL)asynchronize completion:(void(^)(BOOL success, NSString *resultPath))completion {
    if (asynchronize) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            BOOL result = DecodeAMRFileToWAVEFile([amrFilePath cStringUsingEncoding:NSASCIIStringEncoding], [resultSavePath cStringUsingEncoding:NSASCIIStringEncoding]);
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(result, [resultSavePath copy]);
                });
            }
        });
    } else {
        BOOL result = DecodeAMRFileToWAVEFile([amrFilePath cStringUsingEncoding:NSASCIIStringEncoding], [resultSavePath cStringUsingEncoding:NSASCIIStringEncoding]);
        if (completion) {
            completion(result, [resultSavePath copy]);
        }
    }
}

+ (void)convertWavToAmrAtPath:(NSString *)wavFilePath amrSavePath:(NSString *)resultSavePath asynchronize:(BOOL)asynchronize completion:(void(^)(BOOL success, NSString *resultPath))completion {
    if (asynchronize) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            BOOL result = EncodeWAVEFileToAMRFile([wavFilePath cStringUsingEncoding:NSASCIIStringEncoding], [resultSavePath cStringUsingEncoding:NSASCIIStringEncoding], 1, 16);
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(result, [resultSavePath copy]);
                });
            }
        });
    } else {
        BOOL result = EncodeWAVEFileToAMRFile([wavFilePath cStringUsingEncoding:NSASCIIStringEncoding], [resultSavePath cStringUsingEncoding:NSASCIIStringEncoding], 1, 16);
        if (completion) {
            completion(result, [resultSavePath copy]);
        }
    }
}

+ (int)amrToWav:(NSString*)_amrPath wavSavePath:(NSString*)_savePath{
    
    if (DecodeAMRFileToWAVEFile([_amrPath cStringUsingEncoding:NSASCIIStringEncoding], [_savePath cStringUsingEncoding:NSASCIIStringEncoding]))
        return 0; // success
    
    return 1;   // failed
}

+ (int)wavToAmr:(NSString*)_wavPath amrSavePath:(NSString*)_savePath{
    
    if (EncodeWAVEFileToAMRFile([_wavPath cStringUsingEncoding:NSASCIIStringEncoding], [_savePath cStringUsingEncoding:NSASCIIStringEncoding], 1, 16))
        return 0;   // success
    
    return 1;   // failed
}

@end
