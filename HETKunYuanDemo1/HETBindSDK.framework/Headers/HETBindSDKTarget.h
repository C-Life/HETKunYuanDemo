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
@end

NS_ASSUME_NONNULL_END
