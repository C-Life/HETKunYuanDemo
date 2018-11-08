//
//  HETFullScreenErrorView.h
//  NursingHome
//
//  Created by JustinYang on 2018/4/26.
//  Copyright © 2018年 Het. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ShowType){
    ShowTypeNoData,
    ShowTypeError,
    ShowTypeNoWifi,
};
@interface HETFullScreenErrorView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *errorLebel;
@property (weak, nonatomic) IBOutlet UILabel *operateLabel;
@property (nonatomic,assign) ShowType type;

@property (nonatomic,copy) void (^didTapView)(void);

//只有发生未知错误时，才需要msg,其他情况传nil
-(void)setShowType:(ShowType)type msg:(NSString *)msg;
@end
