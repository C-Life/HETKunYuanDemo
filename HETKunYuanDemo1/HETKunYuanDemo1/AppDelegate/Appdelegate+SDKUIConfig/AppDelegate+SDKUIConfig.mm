//
//  AppDelegate+SDKUIConfig.m
//  HETKunYuanDemo2
//
//  Created by JustinYang on 2018/11/30.
//  Copyright © 2018 JustinYang. All rights reserved.
//

#import "AppDelegate+SDKUIConfig.h"
#import "AnimatedGIFImageSerialization.h"
#import "HETMBProgressHUD.h"

@implementation AppDelegate (SDKUIConfig)
-(void)SDKUIConfig{
    colorConfig();
    viewControllerConfig();
    hudConfig();
    colorConfig();
    
}

void colorConfig(){
    unsigned int count;
    
    Class metaClass = objc_getMetaClass("HETSleepUIConfig");
    Method *methodList = class_copyMethodList(metaClass, &count);
    for(int i = 0;i < count; i++)
    {
        Method m = methodList[i];
        
        NSString *mName =  NSStringFromSelector(method_getName(m));;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^setColor[0-9]\\d{0,}:$"];
        if ([predicate evaluateWithObject:mName]) {
            [HETSleepUIConfig performSelector:method_getName(m) withObject:[UIColor sam_colorWithHex:@"F6872E"]];
        }
    }
    free(methodList);
}

void viewControllerConfig(){    
    [HETSleepUIConfig setSleepViewDidLoad:^(UIViewController *vc) {
        vc.navigationController.navigationBar.barTintColor = [UIColor sam_colorWithHex:@"#F6872E"];
        vc.view.backgroundColor = [UIColor whiteColor];
    }];
}
/*!
 *  下拉上拉刷新的UI定制
 */
void refreshConfig(){
    [HETSleepUIConfig setSleepRefreshHeader:^(UIScrollView *scroll, RefreshBlock refreshBlock) {
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            refreshBlock();
        }];
        UIImage *xiaoC_refresh = [UIImage imageWithImageName:@"XiaoC_loading.gif"];
        [header setImages:xiaoC_refresh.images forState:MJRefreshStateIdle];
        [header setImages:xiaoC_refresh.images forState:MJRefreshStatePulling];
        [header setImages:xiaoC_refresh.images forState:MJRefreshStateRefreshing];
        header.lastUpdatedTimeLabel.hidden = YES;
        scroll.mj_header = header;
    }];
   
    

    [HETSleepUIConfig setSleepEndRedfreshHeader:^(UIScrollView *scrollView) {
        [scrollView.mj_header endRefreshing];
    }];
}


/*!
 *  loading框的定制
 */
void hudConfig(){
   
    [HETSleepUIConfig setSleepShowDarkLoading:^{
        [HETMBProgressHUD showHudWithXiaoC:YES message:@""];
    }];
    [HETSleepUIConfig setSleepShowLoading:^{
        [HETMBProgressHUD showHudWithXiaoC:YES message:@""];
    }];
    [HETSleepUIConfig setSleepShowMessageWithLoading:^(NSString *msg) {
        [HETMBProgressHUD showHudWithXiaoC:YES message:msg];
    }];
    [HETSleepUIConfig setSleepShowMessage:^(NSString *msg) {
        [HETMBProgressHUD showHudWithXiaoC:YES message:msg];
    }];
    
    [HETSleepUIConfig setSleepShowAutoHideWithMessage:^(NSString *msg) {
        [HETMBProgressHUD showHudAutoHidenWithMessage:msg];
    }];
    
    [HETSleepUIConfig setSleepHideHud:^{
        [HETMBProgressHUD hideHud];
    }];
    
}

@end
