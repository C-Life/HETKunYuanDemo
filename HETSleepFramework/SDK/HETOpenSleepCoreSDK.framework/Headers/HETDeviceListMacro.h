//
//  HETDeviceListMacro.h
//  HETKunYuanDemo
//
//  Created by JustinYang on 2018/10/11.
//  Copyright © 2018年 JustinYang. All rights reserved.
//

#ifndef HETDeviceListMacro_h
#define HETDeviceListMacro_h
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,HETDeviceType)
{
    HETDeviceTypeMattress = 6,//睡眠
    HETDeviceTypeAirBox   = 28,//空调盒子
  
};


extern NSInteger const kHETResponseCodeError;
extern NSInteger const kHETResponseDataError;
#endif /* HETDeviceListMacro_h */
