//
//  HETPublicCells.h
//  HETPublicSDK_Core
//
//  Created by tl on 16/1/25.
//  Copyright © 2016年 HET. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  最左边间距
 */
static CGFloat kCellLeftSpace = 16.f;

/**
 *  图片距离文字的距离
 */
static CGFloat kCellImgLabelSpace = 12.f;
/**
 *  基cell
 */
@interface HETPublicCellBaseCell : UITableViewCell
@property (strong,nonatomic)UIView *line;
@property (assign,nonatomic)BOOL isBottom;
-(void)initializeView;
@end

/**
 *  不含右边图片的cell,label还没有布局
 */
@interface HETPublicCellNoImageCell : HETPublicCellBaseCell
@property (strong,nonatomic)UILabel *bigLabel;
@property (strong,nonatomic)UILabel *smallLabel;
@end
#pragma mark ----------上面的就别用了，是基，用下面的


#pragma mark ----------2个文字在一行
/**
 *  没图片一行时的高度
 */
static CGFloat kCellIOneRowHeight = 48.f;
/**
 *  2个文字在一行
 */
@interface HETPublicCellOneRowCell : HETPublicCellNoImageCell
@end

#pragma mark ----------有图片，一行
/**
 *  有图片一行时的高度
 */
static CGFloat kCellImageOneRowHeight = 48.f;
/**
 *  有图片，在一行
 */
@interface HETPublicCellImageOneRowCell : HETPublicCellNoImageCell
@property (strong,nonatomic)UIImageView *imgView;
@end

#pragma mark ----------有图片，两行
/**
 *  有图片两行时的高度
 */
static CGFloat kCellImageTwoRowHeight = 72.f;
/**
 *  有图片，在两行
 */
@interface HETPublicCellImageTwoRowCell : HETPublicCellNoImageCell
@property (strong,nonatomic)UIImageView *imgView;
@end
