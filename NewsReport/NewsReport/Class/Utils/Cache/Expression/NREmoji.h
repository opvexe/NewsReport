//
//  NREmoji.h
//  NewsReport
//
//  Created by Facebook on 2018/2/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRBaseModel.h"

@interface NREmoji : NRBaseModel

@property (nonatomic, assign) EmojiType type;

@property (nonatomic, strong) NSString *groupID;

@property (nonatomic, strong) NSString *emojiID;

@property (nonatomic, strong) NSString *emojiName;

@property (nonatomic, strong) NSString *emojiPath;

@property (nonatomic, strong) NSString *emojiURL;

@property (nonatomic, assign) CGFloat size;

@end
