//
//  NSObject+NRSendMessage.m
//  NewsReport
//
//  Created by Facebook on 2018/2/2.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NSObject+NRSendMessage.h"
#import "NRUser.h"

#define NRCOMMON_CODE_EROOR  99999999        ///消息发送失败
@implementation NSObject (NRSendMessage)

/*!
 * 发送文本消息
 
 @param text 文本内容
 */
-(void)sendMessageWithText:(NRIMElem *)text CompletecBlock:(CompletecBlock)block{
    NRIMTextElem *message = (NRIMTextElem *)text;
    NSDictionary *dataDic = @{@"message":message.text};
    NSData *theData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *messageStr = [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
    int code = [[LocalUDPDataSender sharedInstance] sendCommonDataWithStr:messageStr toUserId:message.to qos:NO fp:message.messageId withTypeu:message.messageType];
    if (code == COMMON_CODE_OK) {
        block(COMMON_CODE_OK);
    }else{
        block(NRCOMMON_CODE_EROOR);
    }
}

/*!
 * 发送图片消息
 
 @param image 图片
 @param origal 缩略图
 */
-(void)sendMessageWithImage:(NRIMElem *)image isOrignal:(BOOL)origal CompletecBlock:(CompletecBlock)block{
    NRIMImageElem *message = (NRIMImageElem *)image;
    [message.image jkr_compressToDataLength:20*1024 withBlock:^(NSData *data) {
        UIImage *image = [UIImage imageWithData:data];
        NSString *imageType = [NRNewsReportTools imageTypeWithData:data];
        NSString *type = [imageType substringFromIndex:6];
        NSString *imageName = [NSString stringWithFormat:@"%@.%@",[NRNewsReportTools getTimeTampWithDigit:10],type];
        [NRBusinessNetworkTool PostUpMessageWithImage:image withImageName:imageName withImageType:imageType CompleteSuccessfull:^(id responseObject) {
            NSString *imageUrl = responseObject[@"result"];
            if (imageUrl) {
                NSDictionary *dataDic = @{@"message":imageUrl};
                NSData *theData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
                NSString *messageStr = [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
                int code = [[LocalUDPDataSender sharedInstance] sendCommonDataWithStr:messageStr toUserId:message.to qos:NO fp:message.messageId withTypeu:message.messageType];
                if (code == COMMON_CODE_OK) {
                    block(COMMON_CODE_OK);
                }else{
                    block(NRCOMMON_CODE_EROOR);
                }
            }else{
                block(NRCOMMON_CODE_EROOR);
            }
            block(COMMON_CODE_OK);
        } failure:^(id error) {
            block(NRCOMMON_CODE_EROOR);
        }];
    }];
}


/*!
 * 发送语音消息
 
 @param data 语音二进制文件
 @param dur 语音时长
 */
-(void)sendMessageWithSound:(NSData *)data duration:(NSInteger)dur{
    
}


/*！
 * 发送视频消息
 
 @param videoPath 视频路径
 */
-(void)sendMessageWithVideo:(NSString *)videoPath{
    
}


/*！
 * 发送文件消息
 
 @param filePath 文件路径
 */
- (void)sendMessageWithFilePath:(NSURL *)filePath{
    
}


@end

