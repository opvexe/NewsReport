//
//  NRIMTextElem.h
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRTextMessage : NRMessage

@property (nonatomic, strong) NSString *text;                       // 文字信息

@property (nonatomic, strong) NSAttributedString *attrText;         // 格式化的文字信息（仅展示用）

@end
