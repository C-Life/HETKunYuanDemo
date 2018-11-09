//
//  TargetHETDeviceDetailSDK.h
//  HETDeviceDetailSDK
//
//  Created by JustinYang on 2018/10/31.
//  Copyright © 2018年 JustinYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@protocol HETDeviceDetailDelegate <NSObject>

/**
 * 当设备详情界面改变设备名字，房间的时候回调设备信息到设备主界面
 */
@property (nonatomic,copy) void (^didDeviceInfoChanged)(NSDictionary *devInfo);

@end

@interface TargetHETDeviceDetailSDK : NSObject

+(UIViewController <HETDeviceDetailDelegate> *)getDetailVCWithDeviceInfo:(NSDictionary *)devInfo;
@end

NS_ASSUME_NONNULL_END
