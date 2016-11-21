//
//  ZXTextField.m
//  zhaoxiewang
//
//  Created by 吴筠秋 on 15/11/14.
//  Copyright © 2015年 吴筠秋. All rights reserved.
//

#import "ZXTextField.h"

@implementation ZXTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    if ([UIMenuController sharedMenuController]) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

@end
