//
//  HETAlertView.h
//  HETPublicSDK_Core
//
//  Created by tl on 16/1/14.
//  Copyright © 2016年 HET. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HETAlertView : UIView
/**
 *  公共模块弹出框
 *
 *  @param title             标题，可nil
 *  @param message           消息，可nil
 *  @param cancelButtonTitle  取消按钮标题 ，可nil
 *  @param otherButtonTitle  确定按钮标题，可nil
 *
 */
+(nonnull instancetype)alertTitle:(nullable NSString *)title
                          message:(nullable NSString *)message
                cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                 otherButtonTitle:(nullable NSString *)otherButtonTitle;
/**
 *  这个就针对《确定取消》样式的，不用再区分是哪个button按得
 */
- (void)showInView:(nonnull UIView *)view buttonClick:(nullable void (^)())btnClick;


/**
 *  公共模块弹出框,带2个功能的，就是不含取消
 *
 *  @param title             标题，可nil
 *  @param message           消息，可nil
 *  @param leftButtonTitle  右边按钮标题，可nil
 *  @param rightButtonTitle  左边按钮标题，可nil
 *
 */
+(nonnull instancetype)alertTitle:(nullable NSString *)title
                          message:(nullable NSString *)message
                  leftButtonTitle:(nullable NSString *)leftButtonTitle
                 rightButtonTitle:(nullable NSString *)rightButtonTitle;
/**
 *  这个就针对《两个按钮》样式的，区分按钮点击
 */
- (void)showInView:(nonnull UIView *)view buttonClickAtIndex:(nullable void (^)(NSInteger index))btnClick;




/**
 *  公共模块弹出框，大输入
 *
 *  @param textFieldText     输入框默认文字，可nil
 *  @param placeholdText     填充文字，可nil
 *  @param cancelButtonTitle 取消按钮标题 ，可nil
 *  @param otherButtonTitle  确定按钮标题，可nil
 *
 */
+(nonnull instancetype)alertTextFieldText:(nullable NSString *)textFieldText
                            placeholdText:(nullable NSString *)placeholdText
                        cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                         otherButtonTitle:(nullable NSString *)otherButtonTitle;
-(void)setMaxLength:(NSInteger)length;
-(void)showTextFieldIn:(nonnull UIView *)view btnClick:(nullable void (^)( NSString * _Nullable text))btnClick;
@end