//
//  NRBaseTableViewCellProtocol.h
//  NewsReport
//
//  Created by Facebook on 2018/1/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NRBaseModel;
@protocol NRBaseTableViewCellProtocol <NSObject>
@optional
/**
 *  初始视图
 */
- (void)RNinitConfingViews;
/**
 *  配置数据
 */
- (void)RNSetupViewModel;
/**
 *  配置信号数据
 */
-(void)RNConfigSignalDataSoucre;
/*!
 * 配置数据
 */
-(void)InitDataWithModel:(NRBaseModel *)model;

/*!
 * 获取高度
 */
+(CGFloat)getCellHeight:(NRBaseModel *)model;

/*!
 * 自定义Cell
 */
+(id)CellWithTableView:(UITableView *)tableview;

@end

