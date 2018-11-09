//
//  HETOpenSleepSDKHelper.h
//  HETKunYuanDemo
//
//  Created by JustinYang on 2018/10/17.
//  Copyright © 2018年 JustinYang. All rights reserved.
//

#ifndef HETOpenSleepSDKHelper_h
#define HETOpenSleepSDKHelper_h

/**这个库是静态库的时候，将生成HETDeviceListSDK.bundle暴露出去*/
//#define kModuleBundle   [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"HETOpenSleepCoreSDK" ofType:@"bundle"]]
#define kModuleBundle [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Frameworks/HETOpenSleepCoreSDK" ofType:@"framework"]]
#endif /* HETOpenSleepSDKHelper_h */
