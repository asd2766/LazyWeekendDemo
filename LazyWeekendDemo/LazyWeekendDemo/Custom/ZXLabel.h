//
//  ZXLabel.h
//  zhaoxiewang
//
//  Created by iMac-jianjian on 16/5/19.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXLabel : UILabel

/**
 *  代码创建的label进行字体大小调节
 */
-(void)adjustFont;

/**
 *  重设label的字体大小 (对于xib创建 设置富文本的label)
 */
-(void)resetoriginalFontSize;

/**
 *  获取初始字体size (对于xib创建 设置富文本的label)
 *
 *  @return 初始size
 */
-(CGFloat)getOriginalFontSize;

@end
