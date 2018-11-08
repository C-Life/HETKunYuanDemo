//
//  UITextField+Utils.h
//  HETPublicSDK_Core
//
//  Created by tl on 16/1/27.
//  Copyright © 2016年 HET. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Utils)
/**
 *  关闭emoji
 */
-(void)disableEmoji;

//最大长度
-(void)maxLength:(NSInteger)length;
@end
