//
//  DeviceTipView.h
//  CSleepNew
//
//  Created by JustinYang on 2017/10/26.
//  该view是提示设备状态的view,一般放在导航栏下面，显示设备不在线，网络有问题等,
//  如果此view需要把view放在scrollview的头部，并且需要修改scroll的frame,
//  请自行控制的frame(建议高度32),并把他加到view上；
//  如果是不需要调节scrollframe的，直接调用api 显示和消失
#import <UIKit/UIKit.h>

@interface DeviceTipView : UIView
@property (nonatomic,copy) NSString *tipStr;
-(void)showAtView:(UIView *)view withFrame:(CGRect)frame;
-(void)dismiss;
@end
