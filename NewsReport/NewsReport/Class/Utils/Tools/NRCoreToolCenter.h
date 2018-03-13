//
//  NRCoreToolCenter.h
//  NewsReport
//
//  Created by Facebook on 2018/3/13.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

/*！
 * 富文本类
 */
@interface NRCoreToolCenter : NSObject


#pragma mark - 提示框

extern void ShowSuccessStatus(NSString *statues);
extern void ShowErrorStatus(NSString *statues);
extern void ShowMaskStatus(NSString *statues);
extern void ShowMessage(NSString *statues);
extern void ShowProgress(CGFloat progress);
extern void DismissHud(void);


#pragma mark - 富文本操作

/**
 *  单纯改变一句话中的某些字的颜色（一种颜色）
 *
 *  @param color    需要改变成的颜色
 *  @param totalStr 总的字符串
 *  @param subArray 需要改变颜色的文字数组(要是有相同的 只取第一个)
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)ls_changeCorlorWithColor:(UIColor *)color TotalString:(NSString *)totalStr SubStringArray:(NSArray *)subArray;
/**
 *  单纯改变句子的字间距（需要 <CoreText/CoreText.h>）
 *
 *  @param totalString 需要更改的字符串
 *  @param space       字间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)ls_changeSpaceWithTotalString:(NSString *)totalString Space:(CGFloat)space;

/**
 *  单纯改变段落的行间距
 *
 *  @param totalString 需要更改的字符串
 *  @param lineSpace   行间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)ls_changeLineSpaceWithTotalString:(NSString *)totalString LineSpace:(CGFloat)lineSpace;

/**
 *  同时更改行间距和字间距
 *
 *  @param totalString 需要改变的字符串
 *  @param lineSpace   行间距
 *  @param textSpace   字间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)ls_changeLineAndTextSpaceWithTotalString:(NSString *)totalString LineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace;
/**
 *  改变某些文字的颜色 并单独设置其字体
 *
 *  @param font        设置的字体
 *  @param color       颜色
 *  @param totalString 总的字符串
 *  @param subArray    想要变色的字符数组
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)ls_changeFontAndColor:(UIFont *)font Color:(UIColor *)color TotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray;

/**
 *  为某些文字改为链接形式
 *
 *  @param totalString 总的字符串
 *  @param subArray    需要改变颜色的文字数组(要是有相同的 只取第一个)
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)ls_addLinkWithTotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray;

#pragma mark - 选择相册相关API
/**
 *  获取相册的图片
 *
 *  @param result 获取到的图片
 *  @param error  失败信息
 */
+ (void)getSavedPhotoList:(void (^)(NSArray *))result error:(void (^)(NSError *))error;

/**
 *  获取asset中的image
 *
 *  @param asset       PSAsset
 *  @param size        尺寸
 *  @param completion  完成block
 *  @param synchronous 是否异步
 */
+ (void)generaImaeWithAsset:(PHAsset *)asset size:(CGSize)size completion:(void (^)(UIImage *))completion synchronous:(BOOL)synchronous;

/**
 *  获取Asset中的size
 *
 *  @param asset Asset
 *
 *  @return 得到的size
 */
+ (CGSize)getSizeFromAsset:(id)asset;

/**
 *  从asset中截取一定尺寸的图片
 *
 *  @param asset asset
 *  @param size  需要的尺寸
 *
 *  @return 得到的image
 */
+ (UIImage *)getThumImageFromAsset:(id)asset withSize:(CGSize)size;

#pragma mark - 动画
extern void JumpAnimation (UIView *view ,NSTimeInterval duration,float height);


#pragma mark 使用方法
/*
 
 NSString *total1 = @"单纯改变颜色,不做其他设置,单纯改变颜色";
 NSArray *subArray1 = @[@"单纯",@"其他"];
 
 self.changeColorString = [NRCoreToolCenter ls_changeCorlorWithColor:[UIColor redColor] TotalString:total1 SubStringArray:subArray1];
 
 // *******单纯改变字间距*********
 
 NSString *total2 = @"单纯改变字间距,此时为10";
 self.changeSpaceString = [NRCoreToolCenter ls_changeSpaceWithTotalString:total2 Space:10.0];
 
 // *******单纯改行间距********
 
 NSString *total3 = @"单纯改变行间距，此时行间距为10。单纯改变行间距，此时行间距为10。单纯改变行间距，此时行间距为10。单纯改变行间距，此时行间距为10。单纯改变行间距，此时行间距为10。";
 self.changeLineSpaceString = [NRCoreToolCenter ls_changeLineSpaceWithTotalString:total3 LineSpace:10.0];
 
 // ******改变某些文字的颜色,并单独设置其字体*****
 
 NSString *total4 = @"改变某些文字的颜色,并单独设置其字体";
 self.changeFontColorString = [NRCoreToolCenter ls_changeFontAndColor:[UIFont boldSystemFontOfSize:20] Color:[UIColor redColor] TotalString:total4 SubStringArray:@[@"某些",@"设置"]];
 
 // *******同时改行间距和字间距********
 
 NSString *total5 = @"同时改行间距和字间距，此时行间距为10，字间距为5。同时改行间距和字间距，此时行间距为10，字间距为5。同时改行间距和字间距，此时行间距为10，字间距为5。";
 self.changeLineAndSpaceColorString = [NRCoreToolCenter ls_changeLineAndTextSpaceWithTotalString:total5 LineSpace:10.0 textSpace:5.0];

 
 */
@end
