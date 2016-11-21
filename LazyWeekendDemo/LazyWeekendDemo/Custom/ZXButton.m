//
//  ZXButton.m
//  zhaoxiewang
//
//  Created by iMac-jianjian on 16/5/23.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "ZXButton.h"
#import "Consts.h"

@implementation ZXButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//从xib创建的button进行字体大小适配
-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super initWithCoder: aDecoder]) {
    
        //设置button字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:self.titleLabel.font.pointSize * _screenWidthRatio];
    }
    
    return self;
}

-(void)adjustBtnTitleLabelFontSize{
    
    //设置button字体大小
    self.titleLabel.font = [UIFont systemFontOfSize:self.titleLabel.font.pointSize * _screenWidthRatio];
}

@end
