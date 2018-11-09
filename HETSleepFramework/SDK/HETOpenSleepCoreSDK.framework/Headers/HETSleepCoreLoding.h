//
//  HETSleepCoreLoding.h
//  Pods
//
//  Created by JustinYang on 2017/9/25.
//
//

#import <Foundation/Foundation.h>
#import "HETSleepUIConfig.h"
@interface HETSleepCoreLoding : NSObject
#pragma mark - 下拉框
/*!
 *  开始下拉刷新
 *
 *  @param scrollView 需要刷新的view
 *  @param block      在block中进行刷新操作
 */
+(void)headerRefreshForView:(UIScrollView *)scrollView refreshBlock:(RefreshBlock)block;
/*!
 *  结束下拉刷新
 *
 *  @param scrollView 需要结束下拉刷新的view
 */
+(void)endHeaderRefreshForView:(UIScrollView *)scrollView;

+(void)footerRefreshForView:(UIScrollView *)scrollView refreshBlock:(RefreshBlock)block;

+(void)endFooterRefreshForView:(UIScrollView *)scrollView;
#pragma mark - 弹出款，如果业务线没有设置block，就用默认的
+(void)showLoading;
+(void)showLoadingAtView:(UIView *)view;

+(void)showDarkLoading;
+(void )showDarkLoadingAtView:(UIView *)view;

+(void)showMessage:(NSString *)msg;
+(void)showMessage:(NSString *)msg atView:(UIView *)view;

+(void)showMessageWithLoading:(NSString *)msg;
+(void)showMessageWithLoading:(NSString *)msg atView:(UIView *)view;

+(void )showAutoHideWithMessage:(NSString *)msg;

+(void )showHudMessage:(NSString *)msg;

+(void)hideHud;

+(void)hideHudForView:(UIView *)view;
@end
