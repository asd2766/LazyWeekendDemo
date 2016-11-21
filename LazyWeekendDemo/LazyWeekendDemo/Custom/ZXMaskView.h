//
//  ZXMaskView.h
//  zhaoxiewang
//
//  Created by iMac-jianjian on 16/7/18.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import <UIKit/UIKit.h>

//指引页面
@interface ZXMaskView : UIView

-(void)showInViewController:(UIViewController *)viewController withImage:(UIImage*)image withView:(UIView*)view direction:(NSInteger)directions;

@end
