//
//  ZXMaskView.m
//  zhaoxiewang
//
//  Created by iMac-jianjian on 16/7/18.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "ZXMaskView.h"
#import "Consts.h"
#import "UIImageView+imageViewWithGIF.h"

@interface ZXMaskView ()

@property(nonatomic,strong) UIImageView *permitImage;//指引图片

@property(nonatomic,strong) NSString *peimitString;//指引文字

@property(nonatomic,assign) CGRect permitViewFrame;

@property (nonatomic, assign) CGRect permitRect;

@property (nonatomic, weak) UIView *permitView;

@property(nonatomic,strong) UIImageView *findgif;//找字动画

@property(nonatomic,assign) NSInteger directions;//方向

@end

@implementation ZXMaskView

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        self.permitImage = imageView;
        [self addSubview:self.permitImage];
        
        UIImageView *findImageView = [[UIImageView alloc] init];
        self.findgif = findImageView;
        
        [self addSubview:self.findgif];
    }
    
    return self;
}

-(void)showInViewController:(UIViewController *)viewController withImage:(UIImage*)image withView:(UIView*)view direction:(NSInteger)directions{

    [self hide];
    [self.permitImage setImage:image];
    if (directions == 0) {
        //添加找字动画
        NSData * data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"findAnimation" ofType:@"gif"]];
        [self.findgif imageViewWithGIFData:data WithCenter:CGPointMake(self.permitView.center.x,self.permitView.center.y)];
    }
    self.directions = directions;
    self.permitView = view;
    [viewController.view addSubview:self];
    self.frame = self.superview.frame;
    [self setNeedsDisplay];
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL ret = !CGRectContainsPoint(self.permitRect, point);
    return ret;
}

-(void)drawRect:(CGRect)rect{
    
    UIColor *maskColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
    UIColor *holeColor = [UIColor clearColor];
    
    [maskColor setFill];
    UIRectFill(rect);
    self.permitViewFrame = [self.permitView convertRect:self.permitView.bounds toView:self];
    self.permitRect = CGRectIntersection(self.permitViewFrame, rect);
    
    if (self.directions == 0) {
        
//        self.permitRect = CGRectMake(self.permitRect.origin.x + self.permitRect.size.width / 2 - 50/2, self.permitRect.origin.y + self.permitRect.size.width / 2 - 50 /2, 50, 50);
//        [holeColor setFill];
//        UIRectFill(self.permitRect);
        [self setNeedsLayout];
        
        
    }else{
        [holeColor setFill];
        UIRectFill(self.permitRect);
        [self setNeedsLayout];
    }
}

-(void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat holeX = self.permitRect.origin.x;
    CGFloat holeY = self.permitRect.origin.y;
    CGFloat holeW = self.permitRect.size.width;
    CGFloat holeH = self.permitRect.size.height;
    
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageH = 0;
    CGFloat imageW = 0;
    switch (self.directions) {
        case 0 :{
        //首页指引页面
            imageX = _screenWidth/2 - _screenWidthRatio * 144 /2;
            imageY = holeY - _screenWidthRatio * 69 - 10;
            imageH = _screenWidthRatio * 69;
            imageW = _screenWidthRatio * 144;
            
            self.findgif.frame = CGRectMake(holeX, holeY, holeW, holeH);
            
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(holeX-1, holeY-1, holeW+2, holeH+2)];
                view.backgroundColor = [UIColor whiteColor];
                view.layer.cornerRadius = (holeW+2)/2;
                view.tag = 101;
                [self addSubview:view];
                [self insertSubview:self.findgif aboveSubview:view];
        }
            break;
        case 1 :{
        //标签页面指引页
            imageX = _screenWidth -  _screenWidthRatio * 220 - 23;
            imageY = holeY + holeH + 10;
            imageH = _screenWidthRatio * 144;
            imageW = _screenWidthRatio * 220;
        }
            break;
            
        default:
            break;
    }
    self.permitImage.frame = CGRectMake(imageX, imageY , imageW,imageH);
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self removeFromSuperview];
    
    
}

-(void)hide{

    [self removeFromSuperview];
}


@end
