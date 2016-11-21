//
//  UICopyLabel.m
//  test
//
//  Created by MAC on 16/6/3.
//  Copyright © 2016年 chenzuo. All rights reserved.
//

#import "UICopyLabel.h"

@implementation UICopyLabel

-(BOOL)canBecomeFirstResponder {
    
    return YES;
}

// 可以响应的方法
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    return (action == @selector(copy:));
}

//针对于响应方法的实现
-(void)copy:(id)sender {
    
    //去除前后空格
    NSString *trimmedString = [self.text stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = trimmedString;
    
}


//UILabel默认是不接收事件的，我们需要自己添加touch事件
-(void)attachTapHandler {
    
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *touch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:touch];
}

//绑定事件
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self attachTapHandler];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self attachTapHandler];
    }
    return self;
}


-(void)awakeFromNib {
    
    [super awakeFromNib];
    [self attachTapHandler];
}

-(void)handleTap:(UIGestureRecognizer*) recognizer {
    
    [self becomeFirstResponder];
    
    UIMenuController *menu=[UIMenuController sharedMenuController];
    
    [menu setTargetRect:self.bounds inView:self];
    
    [menu setMenuVisible:YES animated:YES];
}

@end
