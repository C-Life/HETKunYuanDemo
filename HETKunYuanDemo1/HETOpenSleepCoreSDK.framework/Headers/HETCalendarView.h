//
//  HETCalendarView.h
//  CSleepNew
//
//  Created by JustinYang on 2/16/16.
//  Copyright © 2016 JustinYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HETCalendarDelegate;


@interface HETCalendarView : UIView
/**
 *  可选择的日期天数，如果为nil,则所有天数都可选择
 */
@property (nonatomic,copy) NSArray *enableDates;
/**
 *  可选择的天数的颜色,为nil时，无背景颜色
 */
@property (nonatomic,copy) NSString *enableDatesColor;
/**
 *  选中天数的颜色
 */
@property (nonatomic,copy) NSString *selectDayColor;

@property (nonatomic,copy) NSString *headColor;

@property (nonatomic,copy) NSString *selectDay;

@property (nonatomic,copy) NSString *currentDisplayMonth;

@property (nonatomic,weak) id<HETCalendarDelegate> delegate;

-(void)updateLayout;
-(void)updateSelectable;
-(void)showAtAnchorView:(UIView *)view;
-(void)dismiss;
@end

@protocol HETCalendarDelegate <NSObject>

-(void)calendar:(HETCalendarView *)calendarView monthChange:(NSString *)month;
-(void)calendar:(HETCalendarView *)calendarView selectDay:(NSString *)day;

@end