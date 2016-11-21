//
//  UIButton+ContentEdgeInset.h
//  zhaoxiewang
//
//  Created by iMac-jianjian on 16/9/20.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, ZXButtonEdgeInset) {
    ZXButtonEdgeInsetLeft,//image在左 label再右
    ZXButtonEdgeInsetRight,//image在右 label在左
    ZXButtonEdgeInsetTop,  //image在上 label在下
    ZXButtonEdgeInsetBottom//image在下 label在上
};


@interface UIButton (ContentEdgeInset)

/**
 *  设置 button显示方式
 *
 *  @param style 显示方式
 */
-(void)layoutButtonEdgeStyleWithStyle:(ZXButtonEdgeInset)style withSpacing:(CGFloat)space;

@end
