//
//  HETBindSDKTarget.h
//  HETBindSDK
//
//  Created by JustinYang on 2018/10/20.
//  Copyright © 2018年 JustinYang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HETBindSDKTarget : NSObject
+(UIViewController *)enterBindVCWithDeviceInfo:(NSDictionary *)devInfo;

/**
 *  根据productId获得绑定VC
 *  目前支持 空调盒子:productId = 2104
 *         睡眠检测器: productId = 4303
 */
+(UIViewController *)getBindVCWithProductId:(NSInteger)productId;


/**
   类属性，返回绑定结果,
 
   @param err : 绑定失败结果
   @param devInfo : 绑定成功，返回设备deviceInfo
 */
@property(nonatomic,copy,class) void (^bindResultBlock)(NSError * _Nullable err, NSDictionary * _Nullable devInfo);


@end

NS_ASSUME_NONNULL_END
