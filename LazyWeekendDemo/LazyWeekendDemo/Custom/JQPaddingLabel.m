//
//  JQPaddingLabel.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/23.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "JQPaddingLabel.h"

@implementation JQPaddingLabel

- (void)drawTextInRect:(CGRect)rect {
    self.adjustsFontSizeToFitWidth = YES; // 更新width
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

@end
