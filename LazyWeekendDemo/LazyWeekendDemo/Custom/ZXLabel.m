//
//  ZXLabel.m
//  zhaoxiewang
//
//  Created by iMac-jianjian on 16/5/19.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "ZXLabel.h"
#import "Consts.h"

@interface ZXLabel ()

@property(nonatomic,assign) CGFloat fontSize;

@end

@implementation ZXLabel

/**
 *  从xib创建 走的方法
 *
 *  @param aDecoder sDecoder
 *
 *  @return self
 */

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder: aDecoder]) {
        //根据屏幕宽度进行字体适配
        if (self.fontSize != 0) {
            self.font = [UIFont systemFontOfSize:self.fontSize];
        }else{
            self.font = [UIFont systemFontOfSize:_screenWidth/320* self.font.pointSize];
            self.fontSize = self.font.pointSize;
        }
    }
    
    return self;
}

/**
 *  代码创建的label进行字体大小调节
 */
-(void)adjustFont{
    
    self.font = [UIFont systemFontOfSize:_screenWidth/320* self.font.pointSize];
    if (self.fontSize == 0) {
        self.fontSize = self.font.pointSize;
    }
}

/**
 *  重设label的字体大小 (对于xib创建 设置富文本的label)
 */
-(void)resetoriginalFontSize{
    
    if (self.fontSize !=0) {
        
        self.font = [UIFont systemFontOfSize:self.fontSize];
    }
}


/**
 *  获取初始字体size (对于xib创建 设置富文本的label)
 *
 *  @return 初始size
 */
-(CGFloat)getOriginalFontSize{
    
    if (self.fontSize != 0) {
        return self.fontSize;
    }
    return self.font.pointSize;
}


@end
