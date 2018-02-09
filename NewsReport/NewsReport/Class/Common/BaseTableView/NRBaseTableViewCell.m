//
//  NRBaseTableViewCell.m
//  NewsReport
//
//  Created by Facebook on 2018/1/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRBaseTableViewCell.h"

@implementation NRBaseTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        
        _leftSeparatorSpace = 15.0f;
        _topLineStyle = NRCellLineStyleNone;
        _bottomLineStyle = NRCellLineStyleDefault;
        
        [self RNinitConfingViews];
        
        [self RNSetupViewModel];
        
        [self RNConfigSignalDataSoucre];
    }
    return  self ;
}



-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self RNinitConfingViews];
    
    [self RNSetupViewModel];
    
    [self RNConfigSignalDataSoucre];
}

/**
 *  初始视图
 */
- (void)RNinitConfingViews{
    
}
/**
 *  配置数据
 */
- (void)RNSetupViewModel{
    
}
/**
 *  配置信号数据
 */
-(void)RNConfigSignalDataSoucre{
    
}
/*!
 * 配置数据
 */
-(void)InitDataWithModel:(NRBaseModel *)model{
    
}

/*!
 * 获取高度
 */
+(CGFloat)getCellHeight:(NRBaseModel *)model{
    
    return 0.0f;
}

/*!
 * 自定义Cell
 */
+(id)CellWithTableView:(UITableView *)tableview{
    
    return nil;
}



- (void)setTopLineStyle:(NRCellLineStyle)topLineStyle
{
    _topLineStyle = topLineStyle;
    [self setNeedsDisplay];
}

- (void)setBottomLineStyle:(NRCellLineStyle)bottomLineStyle
{
    _bottomLineStyle = bottomLineStyle;
    [self setNeedsDisplay];
}

- (void)setLeftSeparatorSpace:(CGFloat)leftSeparatorSpace
{
    _leftSeparatorSpace = leftSeparatorSpace;
    [self setNeedsDisplay];
}

- (void)setRightSeparatorSpace:(CGFloat)rightSeparatorSpace
{
    _rightSeparatorSpace = rightSeparatorSpace;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, BORDER_WIDTH_1PX * 1);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    if (self.topLineStyle != NRCellLineStyleNone) {
        CGContextBeginPath(context);
        CGFloat startX = (self.topLineStyle == NRCellLineStyleFill ? 0 : _leftSeparatorSpace);
        CGFloat endX = self.width - self.rightSeparatorSpace;
        CGFloat y = 0;
        CGContextMoveToPoint(context, startX, y);
        CGContextAddLineToPoint(context, endX, y);
        CGContextStrokePath(context);
    }
    if (self.bottomLineStyle != NRCellLineStyleNone) {
        CGContextBeginPath(context);
        CGFloat startX = (self.bottomLineStyle == NRCellLineStyleFill ? 0 : _leftSeparatorSpace);
        CGFloat endX = self.width - self.rightSeparatorSpace;
        CGFloat y = self.height;
        CGContextMoveToPoint(context, startX, y);
        CGContextAddLineToPoint(context, endX, y);
        CGContextStrokePath(context);
    }
}

@end

