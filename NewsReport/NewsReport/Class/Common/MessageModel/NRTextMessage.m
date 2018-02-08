//
//  NRIMTextElem.m
//  NewsReport
//
//  Created by Facebook on 2018/2/1.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRTextMessage.h"

@implementation NRTextMessage
@synthesize text = _text;

- (instancetype)init{
    if (self = [super init]) {
        [self setMessageType:MessageTypeText];
    }
    return self;
}

- (NSString *)text{
    if (_text == nil) {
        _text = [self.content objectForKey:@"text"];
    }
    return _text;
}
- (void)setText:(NSString *)text
{
    _text = text;
    [self.content setObject:text forKey:@"text"];
}

- (NSAttributedString *)attrText
{
    if (_attrText == nil) {
//        _attrText = [self.text toMessageString];      富文本（文本+表情）
        
    }
    return _attrText;
}



- (NSString *)conversationContent
{
    return self.text;
}

- (NSString *)messageCopy
{
    return self.text;
}

@end
