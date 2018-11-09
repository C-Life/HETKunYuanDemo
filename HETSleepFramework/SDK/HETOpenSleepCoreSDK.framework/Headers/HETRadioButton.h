//
//  HETRadioButton.h
//  HETPublicSDK_Core
//
//  Created by tl on 16/1/13.
//  Copyright © 2016年 HET. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGSize radioSize = {16,16};

/**
 *  单选样式
 */
typedef NS_ENUM(NSInteger,RadioType) {
    /**
     @ @ @ @ @ @ @ @ X % o < > * X @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ X * > < o * X @ @ @ @ @ @ @ @ @ @ @
     @ @ @ @ @ @ % = > < < < < < < o % X @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ X % = < < < < < < > = X @ @ @ @ @ @ @ @ @
     @ @ @ @ X = < + < < < < < < < < < o % @ @ @ @ @ @ @ @ @ @ @ @ @ X = < + < < < < < < < + < * X @ @ @ @ @ @ @
     @ @ @ X o + < < < < < < < < < < < < < % @ @ @ @ @ @ @ @ @ @ @ % o < < < < < < < < < < < < + = X @ @ @ @ @ @
     @ @ X o + < < < < < < < < < < < < < < < % @ @ @ @ @ @ @ @ @ % o < < < < < < < < < < < < < < + o X @ @ @ @ @
     @ @ = + < < < < < < < < < < < < < + + < o X @ @ @ @ @ @ @ X = < < < < < < < < < < < < < + + < + = X @ @ @ @
     @ % < < < < < < < < < < < < < < ~ . , + < * @ @ @ @ @ @ @ * < < < < < < < < < < < < < < , ` ~ < < % @ @ @ @
     @ = + < < < < < < < < < < < < ~ ` ` ~ < < o X @ @ @ @ @ X = < < < < < < < < < < < < < -   , + < + = X @ @ @
     X < < < < < < < < < < < < < + . ` - < < < > * @ @ @ @ @ % > < < < < < < < < < < < < - ` , + < < < > X @ @ @
     * < < < < < < < < < < < < + ,   - < < < < < = @ @ @ @ @ * < < < < < < < < < < < < ~ ` ` + < < < < < % @ @ @
     > < < < ~ , + < < < < < + ,   , < < < < < < = X @ @ @ @ * < < + - - + < < < < < ~ . ` - < < < < < < % @ @ @
     < < < < ,   , + < < < < -   , + < < < < < < = X @ @ @ @ * < < + ,   , + < < < + ,   - + < < < < < + % @ @ @
     o < < < + .   . + < < -   . + < < < < < < < = X @ @ @ @ * < < < ~ .   , + < + ,   - + < < < < < < < % @ @ @
     % < < < < + ,   . ~ ~ ` ` ~ < < < < < < < < * @ @ @ @ @ * < < < < ~ ,   - ~ , ` , + < < < < < < < < % @ @ @
     X > < < < < + ,   ` ` ` ~ < < < < < < < < > % @ @ @ @ @ % o < < < < ~ ,   `   , + < < < < < < < < o X @ @ @
     @ = + < < < < + ,     - < < < < < < < < < o X @ @ @ @ @ X = < < < < < ~ `   . ~ < < < < < < < < < * @ @ @ @
     @ X < < < < < < + , , < < < < < < < < < > * @ @ @ @ @ @ @ % > < < < < < ~ , ~ < < < < < < < < < > X @ @ @ @
     @ @ * < < < < < < < < < < < < < < < < < = X @ @ @ @ @ @ @ X = < < < < < < < < < < < < < < < < < * @ @ @ @ @
     @ @ X = < < < < < < < < < < < < < < < > % @ @ @ @ @ @ @ @ @ X = < < < < < < < < < < < < < < < = X @ @ @ @ @
     @ @ @ X = < < < < < < < < < < < < < o % @ @ @ @ @ @ @ @ @ @ @ X = < < < < < < < < < < < < < = X @ @ @ @ @ @
     @ @ @ @ X * > < < < < < < < < < > = X @ @ @ @ @ @ @ @ @ @ @ @ @ X * > < < < < < < < < < > * X @ @ @ @ @ @ @
     @ @ @ @ @ @ X % = o > > > o = * % @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ X * = o > > > o = * X @ @ @ @ @ @ @ @ @
     @ @ @ @ @ @ @ @ @ X X % X X X @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ X X X % X X X @ @ @ @ @ @ @ @ @ @ @
     */
    RadioOne =1,
    /**
     @ @ @ @ @ @ @ @ @ X % * * X X @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ X * = o = % X @ @ @ @ @ @ @ @ @ @ @
     @ @ @ @ @ @ X * o < < < < < > = % @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ X % * o > > > > > o * X @ @ @ @ @ @ @ @ @
     @ @ @ @ @ * > + + + < > < < + + < = X @ @ @ @ @ @ @ @ @ @ @ @ @ X * o > > > > > > > > > o * X @ @ @ @ @ @ @
     @ @ @ @ = + + < * % X X X X * o + + > % @ @ @ @ @ @ @ @ @ @ @ X = > > > > > > > > > > > > > = X @ @ @ @ @ @
     @ @ @ = + < = X @ @ @ @ @ @ @ X % > + > X @ @ @ @ @ @ @ @ @ X = > > > > > > > > > > > > o o > = X @ @ @ @ @
     @ @ * + < * @ @ @ @ @ @ @ @ @ @ @ % > + = X @ @ @ @ @ @ @ X * > > > > > > > > > > > > o > > > > * @ @ @ @ @
     @ X < + = @ @ @ @ @ @ @ @ @ @ @ @ @ % < < * @ @ @ @ @ @ @ % o > > > > > > > > > > > o > - . + > o X @ @ @ @
     @ * + > X @ @ @ @ @ @ @ @ @ @ @ @ @ @ * + = X @ @ @ @ @ X = > > > > > > > > > > > o > ~   - > > > * @ @ @ @
     @ > + * @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ X < > % @ @ @ @ @ % = > > > > > > > > > > o > ~ ` , > o > > = X @ @ @
     X < + % @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ X o < * @ @ @ @ @ % o > > > > o > > > > o o + . . < > > > > o % @ @ @
     % < < X @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ = < * @ @ @ @ @ * > o > + ~ < o > > o o < , ` + > o > > > > % @ @ @
     * < < X @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ = < = @ @ @ @ @ * o o < ,   - < o o o < , ` ~ > o > > > > > % @ @ @
     % < < X @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ X = < * @ @ @ @ @ * o > > + ,   - > o > , ` - > o > > > > > > % @ @ @
     X < + % @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ X > < * @ @ @ @ @ % o > > > + ,   - < - ` - < > > > > > > > o X @ @ @
     @ o + = @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ % < > % @ @ @ @ @ % = > > o > + , ` . ` , < > > > > > > > > = X @ @ @
     @ * + < X @ @ @ @ @ @ @ @ @ @ @ @ @ X = < = X @ @ @ @ @ X * > > > o > < .   , + > > > > > > > > > * @ @ @ @
     @ X > + = X @ @ @ @ @ @ @ @ @ @ @ X % < > % @ @ @ @ @ @ @ % o > > > o o + , + > o > > > > > > > o X @ @ @ @
     @ @ % < < = X @ @ @ @ @ @ @ @ @ X % < < = X @ @ @ @ @ @ @ X * o > > > o > > > > > > > > > > > o % @ @ @ @ @
     @ @ @ * < + o % X @ @ @ @ @ X X * < < o X @ @ @ @ @ @ @ @ @ X = o > > > > o > > > > > > > > o * X @ @ @ @ @
     @ @ @ @ * < + < = * % X % % = > + < = X @ @ @ @ @ @ @ @ @ @ @ X * o > > > > > > > > > > > o * X @ @ @ @ @ @
     @ @ @ @ @ % o < + + < < < < + < > * X @ @ @ @ @ @ @ @ @ @ @ @ @ X * = o > > > > > > > o = % X @ @ @ @ @ @ @
     @ @ @ @ @ @ X % * = o o o = = % X @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ X % = = = = = = * % X @ @ @ @ @ @ @ @ @
     @ @ @ @ @ @ @ @ @ X X X X X @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ X X X X X X @ @ @ @ @ @ @ @ @ @ @ @
     */
    RadioTwo =2,
    /**
     @ @ @ @ @ @ @ X % * * % X @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ X % * % X @ @ @ @ @ @ @ @ @ @
     @ @ @ @ @ X = > < < < < > = X @ @ @ @ @ @ @ @ @ @ @ @ @ X % = < < < < < o % X @ @ @ @ @ @ @
     @ @ @ X * < + + ~ ~ ~ ~ + + < * X @ @ @ @ @ @ @ @ @ @ X = < + + ~ ~ ~ ~ + + = X @ @ @ @ @ @
     @ @ X = + + - .         . - + < = X @ @ @ @ @ @ @ @ X = + ~ , `       ` , ~ + > % @ @ @ @ @
     @ @ * + + ,                 , + < * @ @ @ @ @ @ @ X = + - `               ` - + o X @ @ @ @
     @ X < + ,     . - ~ ~ - .     , + < % @ @ @ @ @ @ % < ~ `   ` , - ~ ~ , `   ` ~ + * X @ @ @
     @ = + -     , + < < < < + ,     - < = @ @ @ @ @ X = + -   ` - + < < < < - `   , ~ > X @ @ @
     X > + .   . + < < < < < < + .   . + > X @ @ @ @ % < ~ ` ` - + < < < < < < - `   - < % @ @ @
     % < ~     - < < < < < < < < -   ` ~ < % @ @ @ @ % < -   . ~ < < < < < < < ~ `   - + * X @ @
     * < ~     ~ < < < < < < < < ~     - < % @ @ @ X * + -   , + < < < < < < < + .   , + = X @ @
     * < ~     ~ < < < < < < < < ~     - < % @ @ @ X * + -   , + < < < < < < < + .   , + = X @ @
     X < + `   , < < < < < < < + -   ` ~ > % @ @ @ @ % < ~ ` ` - < < < < < < < - `   - + * X @ @
     X o + ,   ` ~ < < < < < < ~ `   , + o X @ @ @ @ X > ~ ,   , + < < < < < + ,   ` ~ < % @ @ @
     @ * < ~ `   . ~ + + + + ~ .   ` - < * @ @ @ @ @ X = + -   ` , ~ + + + + ,     - + o X @ @ @
     @ X > < - `   ` , - - , `   ` - + o X @ @ @ @ @ @ % > + ,     . , - - .     , ~ < % X @ @ @
     @ @ X o + - , `         ` , - + o % @ @ @ @ @ @ @ @ % > + - . `         . - + > * X @ @ @ @
     @ @ @ % = < ~ - - , , - - ~ < = % @ @ @ @ @ @ @ @ @ X % > + ~ - , , , - ~ + > * X @ @ @ @ @
     @ @ @ @ X * o < + + + + < o * X @ @ @ @ @ @ @ @ @ @ @ @ % = > < + + + < > = % X @ @ @ @ @ @
     @ @ @ @ @ X % % * = = * * % X @ @ @ @ @ @ @ @ @ @ @ @ @ @ X % * * = = * % X @ @ @ @ @ @ @ @
     @ @ @ @ @ @ @ @ X X X X @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ X X X @ @ @ @ @ @ @ @ @ @ @ 
     */
    RadioThree =3,
    
    /**
     *  一个有一个没有
     */
    RadioFour =4
};
@interface HETRadioButton : UIView
+(instancetype)type:(RadioType)type;
/**
 *  默认:NO
 */
@property (assign,nonatomic)BOOL isChoose;
@property (assign,nonatomic)RadioType radioType;


/**
 *  是否不可操作（保持当前状态不变）default : NO
 */
@property (assign,nonatomic)BOOL disable;

/**
 * shouldChoose：是不是将要选中（isChoose取反）
 */
-(void)click:(void (^)(BOOL shouldChoose))click;
@end
