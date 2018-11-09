//
//  AuthVC.h
//  HETKunYuanDemo
//
//  Created by JustinYang on 2018/10/10.
//  Copyright © 2018年 JustinYang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuthVC : UIViewController
@property (nonnull,copy) void (^dismiss)(NSString * _Nullable openId);
@end

NS_ASSUME_NONNULL_END
