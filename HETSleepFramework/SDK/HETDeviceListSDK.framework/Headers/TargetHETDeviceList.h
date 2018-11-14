//
//  TargetHETDeviceList.h
//  HETDeviceListSDK
//
//  Created by JustinYang on 2018/10/11.
//  Copyright © 2018年 JustinYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <HETOpenSleepCoreSDK/HETOpenSleepCoreSDK.h>
NS_ASSUME_NONNULL_BEGIN

@interface TargetHETDeviceList : NSObject
/**
 *  根据设备类型得到设备列表vc
 */
+(nonnull UIViewController *)getDeviceListWithType:(HETDeviceType)type;

/**
 * 传入deviceInfo, push到相应的设备界面
 */
+(void)pushNav:(UINavigationController *)nav
    deviceInfo:(NSDictionary *)deviceInfo;
@end

NS_ASSUME_NONNULL_END
