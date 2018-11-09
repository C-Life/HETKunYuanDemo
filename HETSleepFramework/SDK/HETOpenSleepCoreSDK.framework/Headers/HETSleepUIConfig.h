//
//  HETSleepUIConfig.h
//  HETSleepCore
//
//  Created by JustinYang on 2017/8/29.
//  Copyright © 2017年 JustinYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^RefreshBlock)(void);
@interface HETSleepUIConfig : NSObject
/**
 *  睡眠库中的VC都从BNRBaseController派生而来，
 *  您可以全局配置睡眠库中的VC在viewDidLoad viewWillAppear
 *  viewDidAppear调用时，所需要做执行的特定的代码，通过block来
 *  配置您想执行的代码
 *
 *  @param viewDidLoad
 */
+(void)setSleepViewDidLoad:(void (^)(UIViewController *vc))viewDidLoad;
+(void (^)(UIViewController *vc))sleepViewDidLoad;

+(void)setSleepViewWillAppear:(void (^)(UIViewController *vc))viewWillAppear;
+(void (^)(UIViewController *vc))sleepViewWillAppear;

+(void)setSleepViewDidAppear:(void (^)(UIViewController *vc))viewDidAppear;
+(void (^)(UIViewController *vc))sleepViewDidAppear;


/**
 *  定制睡眠库的弹出提示框
 *
 *  @param showLoading
 */
+(void)setSleepShowLoading:(void (^)(void))showLoading;
+(void (^)(void))showLoading;

+(void)setSleepShowLoadingAtView:(void (^)(UIView *view))showLoading;
+(void (^)(UIView *view))showLoadingAtView;

+(void)setSleepShowDarkLoading:(void (^)(void))showLoading;
+(void (^)(void))showDarkLoading;

+(void)setSleepShowDarkLoadingAtView:(void (^)(UIView *view))showLoading;
+(void (^)(UIView *view))showDarkLoadingAtView;


+(void)setSleepShowMessage:(void (^)(NSString *msg))showLoading;
+(void (^)(NSString *msg))showMessage;

+(void)setSleepShowMessageWithLoading:(void (^)(NSString *msg))showLoading;
+(void (^)(NSString *msg))showMessageWithLoading;

+(void)setSleepShowMessageAtView:(void (^)(NSString *msg, UIView *view))showLoading;
+(void (^)(NSString *msg,UIView *view))showMessageAtView;

+(void)setSleepShowMessageAtViewWithLoading:(void (^)(NSString *msg, UIView *view))showLoading;
+(void (^)(NSString *msg,UIView *view))showMessageAtViewWithLoading;

+(void)setSleepHideHud:(void (^)(void))hideHud;
+(void (^)(void))hideHud;

+(void)setSleepHideHudForView:(void (^)(UIView *view))hideHud;
+(void (^)(UIView *view))hideHudForView;

+(void)setSleepShowAutoHideWithMessage:(void (^)(NSString *msg))loading;
+(void (^)(NSString *msg))showAutoHideMessage;

+(void)setSleepShowHudWithMessage:(void (^)(NSString *msg))loading;
+(void (^)(NSString *msg))showHudMessage;

/**
 *  下拉框定制
 *
 *  @param headerBlcok
 */
+(void)setSleepRefreshHeader:(void (^)(UIScrollView *scroll,
                                       RefreshBlock refreshBlock))headerBlcok;
+(void (^)(UIScrollView *scroll,RefreshBlock refreshBlock))refreshHeader;

+(void)setSleepEndRedfreshHeader:(void (^)(UIScrollView *scroll))headerBlcok;
+(void (^)(UIScrollView *scroll))endRefreshHeader;

+(void)setSleepRefreshFooter:(void (^)(UIScrollView *scroll,
                                       RefreshBlock refreshBlock))footerBlock;
+(void (^)(UIScrollView *scroll,RefreshBlock refreshBlock))refreshFooter;

+(void)setSleepEndRefreshFooter:(void (^)(UIScrollView *scroll))footerBlock;
+(void (^)(UIScrollView *scroll))endRefreshFooter;

/**
 * 错误提示view定制
 */
@end
