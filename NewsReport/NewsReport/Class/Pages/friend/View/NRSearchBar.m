//
//  NRSearchBar.m
//  NewsReport
//
//  Created by Facebook on 2018/2/5.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRSearchBar.h"

@implementation NRSearchBar
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = @"搜索";
        self.keyboardType = UIKeyboardTypeDefault;
        self.backgroundImage = [NRNewsReportTools getImageWithColor:[UIColor clearColor] andHeight:Number(44.0f)];
        [self setBackgroundColor:UIColorFromRGB(0xf0f0f6)];
        UITextField *searchField = [self valueForKey:@"_searchField"];
        searchField.layer.borderWidth = 0.5f;
        searchField.layer.borderColor = [UIColorFromRGB(0xdfdfdf) CGColor];
        searchField.layer.cornerRadius = 5.f;
    }
    return self;
}

@end
