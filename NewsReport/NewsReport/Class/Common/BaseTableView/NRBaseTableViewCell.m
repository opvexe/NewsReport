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

@end

