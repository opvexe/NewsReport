//
//  SPIMessageEventButton.h
//  SPIChuangKe
//
//  Created by Facebook on 16/3/24.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CPMessageEventButton;
@protocol CPMessageEventButtonDelegate <NSObject>

@optional

-(void)ClickedWithMessageButton:(CPMessageEventButton*)messageButton;

@end

@interface CPMessageEventButton : UIButton

@property (nonatomic, copy) NSString *normalStateImageName;

@property (nonatomic, copy) NSString *highlightedStateImageName;

@property (nonatomic, copy) NSString *selectedStateImageName;

@property (nonatomic, copy) NSString *normalStateBgImageName;

@property (nonatomic, copy) NSString *highlightedStateBgImageName;

@property (nonatomic, copy) NSString *selectedStateBgImageName;

@property(nonatomic)NSUInteger countdownBeginNumber;

@property(nonatomic,weak)id<CPMessageEventButtonDelegate>delegate;

-(void)startBeginNumber;
@end
