//
//  NRBaseTableViewCell.h
//  NewsReport
//
//  Created by Facebook on 2018/1/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRBaseTableViewCellProtocol.h"

typedef NS_ENUM(NSInteger, NRCellLineStyle) {
    NRCellLineStyleNone,
    NRCellLineStyleDefault,
    NRCellLineStyleFill,
};

@interface NRBaseTableViewCell : UITableViewCell<NRBaseTableViewCellProtocol>

/**
 *  左边距
 */
@property (nonatomic, assign) CGFloat leftSeparatorSpace;

/**
 *  右边距，默认0，要修改只能直接指定
 */
@property (nonatomic, assign) CGFloat rightSeparatorSpace;

@property (nonatomic, assign) NRCellLineStyle topLineStyle;
@property (nonatomic, assign) NRCellLineStyle bottomLineStyle;


@end
