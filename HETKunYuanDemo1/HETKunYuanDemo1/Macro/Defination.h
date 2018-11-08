//
//  Defination.h
//  HETKunYuanDemo
//
//  Created by JustinYang on 2018/10/11.
//  Copyright © 2018年 JustinYang. All rights reserved.
//

#ifndef Defination_h
#define Defination_h

//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define SizeScaleWidth  ((ScreenHeight>480)?ScreenWidth/320:1.0)
#define SizeScaleHeight ((ScreenHeight>480)?ScreenHeight/568:1.0)

#define TrailOfView(view) (view.frame.origin.x+view.frame.size.width)
#define BottomOfView(view) (view.frame.origin.y+view.frame.size.height)
#define kScaleWidth (ScreenWidth/375)

#define ScaleHeightFactor  ((ScreenHeight>736)?667:ScreenHeight)
//iphone X高度不缩放
#define kScaleHeight         (ScaleHeightFactor/667)

#define kWidthAfterScale(x)  ((x)*kScaleWidth)
#define kHeightAfterScale(y) ((y)*kScaleHeight)
#define kHeightWithNavAfterScale(y) ((y)*(ScreenHeight-64)/(667-64))

#define  iPhone6PWidth 414.0
#define  iPhone6PHeight 736.0
#define  iPhone6 375.0

#define  BasicHeight  (1/iPhone6PHeight*(IS_IPHONE_4?iPhone6PHeight:ScreenHeight))
#define  BasicWidth  (1/iPhone6PWidth*ScreenWidth)
#define  BasicWidth2  (1/iPhone6*ScreenWidth)

#define SINGLE_LINE_WIDTH (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

#define kSafeAreaTop            ((ScreenHeight>736)?88:64)
#define kUnderStatusBarBottom   ((ScreenHeight>736)?44:20)
#define kSafeAreaBottom         ((ScreenHeight>736)?34:0)


#endif /* Defination_h */
