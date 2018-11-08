//
//  UIConfig.h
//  IDOIAP2
//
//  Created by wady on 6/3/13.
//  Copyright (c) 2013 damai_mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HETUIConfig : NSObject

#pragma mark ----------公共模块色系
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wstrict-prototypes"
UIColor *kColor1(void);
UIColor *kColor2(void);
UIColor *kColor3(void);
UIColor *kColor4(void);
UIColor *kColor5(void);
UIColor *kColor6(void);
UIColor *kColor7(void);
UIColor *kColor8(void);
UIColor *kColor9(void);
UIColor *kColor10(void);
UIColor *kColor11(void);
UIColor *kColor12(void);
UIColor *kColor13(void);
UIColor *kColor14(void);
UIColor *kColor15(void);
UIColor *kColor16(void);
UIColor *kColor17(void);
UIColor *kColor18(void);
UIColor *kColor19(void);

UIColor *kColor20(void);
UIColor *kColor21(void);
UIColor *kColor22(void);
UIColor *kColor23(void);
UIColor *kColor24(void);
UIColor *kColor25(void);
UIColor *kColor26(void);
UIColor *kColor27(void);
UIColor *kColor28(void);
UIColor *kColor29(void);
#pragma mark ----------公共模块字体
UIFont *kFont1(void);
UIFont *kFont1_Bold(void);
UIFont *kFont2(void);
UIFont *kFont2_Bold(void);
UIFont *kFont3(void);
UIFont *kFont4(void);
UIFont *kFont5(void);

#pragma clang diagnostic pop







+ (CGSize) getScreenSize;

+ (UIColor *) getContentTextColor;

+ (UIColor *) getContentShadowTextColor;

+ (UIColor *) underLineColor;

+ (UIColor *)getCellShadowColor;

+ (UIColor *)getFooterCellShadowColor;

+ (UIColor *) getTitleTextColor;

+ (UIColor *) getBtnTextColor;

+ (UIColor *) getBtnClockTextColor;

+ (UIFont *) getContentSize;

+ (UIFont *) getSubTitleSize;

+ (UIFont *) getTitleSize;

+ (UIFont *) getSubTitleNumSize;

+ (UIFont *) getBtnNumSize;

+ (UIFont *) getDialogWarnSize;

+ (UIFont *) getSettingSize;

+ (int) getDialogWarnHeight:(int)size;

+ (int) getTitleHeight;

+ (int) getSubTitleHeight:(int)size;

+ (int) getContentHeight:(int)size;

+ (UIColor *) getContentNumberTextColor;

+ (UIColor *) getColor:(NSString *)hexColor;

+ (UIColor *) colorFromHexRGB:(NSString *) inColorString;

+ (UIColor *) colorFromHexRGB:(NSString *) inColorString alpha:(CGFloat)colorAlpha;

+ (int) getButtomHeight;

+ (int) getMutiBtnButtomHeight;

+ (int) getTitleY;

+ (int) getBgPanelY;

// 获取行间距，段落尖间距 
+ (int) getParagraphLineSeparator;
// title 和下面正文的距离
+ (int) getTitleSeparator;
// 段落间的距离
+ (int) getParagraphSeparator;
// 段落和图片间距
+ (int) getParagraphAndImageSeparator;
// 圆点动画间距
+ (int) getAnimalCircleSeparator;
// 按钮间的距离
+ (int) getBtnAndBtnSeparator;
// 段落和图片大的间距
+ (int) getParagraphAndImageLargeSeparator;

//字体阴影偏移量
+(CGSize)labelShadow;
//图表颜色选中颜色
+ (UIColor *)tableCellSelectedColor;

//滑动中间页到左边菜单，中间页面，显示的长度
+(CGFloat)frontViewLeftShowDistance;

//滑动中间页到右边边菜单，中间页面，显示的长度
+(CGFloat)frontViewRightShowDistance;

//中间页，滑动之后，缩小的最小比例
+(CGFloat)frontViewMinFactory;

//两边菜单的主标题的颜色
+(UIColor*)menuCellTitleColor;

//两边菜单的副标题的颜色
+(UIColor*)menuCellDetailTitleColor;

//两边菜单的主标题的字体
+(UIFont*)menuCellTitleFont;

//两边菜单的副标题的字体
+(UIFont*)menuCellDetailTitleFont;

//右边菜单Cell左边的边距
+(CGFloat)rightMenuCellLeftEdge;


//右边菜单Cell右边的边距
+(CGFloat)rightMenuCellRightEdge;

+ (UIColor *)appNormalTextColor;

+(UIColor*)LoginBgColor;
/**
 *  textPlaceHolderColor 返回输入框默认的placeHolder颜色
 *
 *  @return placeHolder颜色
 */
+(UIColor*)textPlaceHolderColor;


+ (UIImage *)imageWithColor:(UIColor *)color;

@end
