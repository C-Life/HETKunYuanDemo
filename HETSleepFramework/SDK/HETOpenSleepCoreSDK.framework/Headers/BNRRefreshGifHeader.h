//
//  BNRRefreshGifHeader.h
//  CSleepNew
//
//  Created by JustinYang on 16/9/14.
//  Copyright © 2016年 JustinYang. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface BNRRefreshGifHeader : MJRefreshStateHeader
-(void)customSetting;
/** 设置state状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state;
- (void)setImages:(NSArray *)images forState:(MJRefreshState)state;
@end
