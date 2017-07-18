//
//  ChangeMsgViewController.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/29.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "ChangeMsgViewController.h"

@interface ChangeMsgViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *maleBtn;
@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;

// 参数
@property (strong, nonatomic) NSString *sex; // 性别
@property (strong, nonatomic) NSString *status; // 当前状态

@end

@implementation ChangeMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 设置左边按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cat_me"] style:UIBarButtonItemStyleDone target:self.navigationController action:@selector(showMenu)];
    
    // 设置右边按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(clickForSave)];
    
    self.navigationItem.title = @"个人资料";
    
    // 设置按钮状态
    self.maleBtn.showsTouchWhenHighlighted = NO;
    self.femaleBtn.showsTouchWhenHighlighted = NO;
    for (int i = 0; i < 3; i++) {
        UIView *view = [self.view viewWithTag:i + 20];
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            btn.showsTouchWhenHighlighted = NO;
        }
    }
    
    // 设置头像
    [CommonUtil addViewAttr:self.iconImageView borderWidth:1 borderColor:RGB(136, 136, 136) cornerRadius:CGRectGetWidth(self.iconImageView.frame)/2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - action

/**
 *  保存
 */
- (void)clickForSave {
//    NSLog(@"啊啊啊啊，要保存啦");
    // 判断是否填写名称
    NSString *name = [CommonUtil trimStr:self.nameTextField.text];
    if ([CommonUtil isEmpty:name]) {
        [self makeToast:@"请输入名称"];
        return;
    }
    [self.nameTextField resignFirstResponder];
    
    // 判断是否选择性别
    if ([CommonUtil isEmpty:self.sex]) {
        [self makeToast:@"请选择性别"];
        return;
    }
    
    // 判断当前状态是否选择
    if ([CommonUtil isEmpty:self.status]) {
        [self makeToast:@"请选择当前状态"];
        return;
    }
    
    // 假装在掉接口
    [self showProgressView:self.view];
    
    [self performSelector:@selector(saveSuccess) withObject:nil afterDelay:0.3f];
}

- (void)saveSuccess {
    [self hideProgressView];
    [self makeToast:@"保存成功"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/**
 修改性别

 @param sender
 */
- (IBAction)changeSex:(UIButton*)button {
    if (button.selected) {
        return;
    }
    
    UIView *superView = button.superview;
    
    for (int i = 0; i < 2; i++) {
        UIView *view = [superView viewWithTag:i + 10];
        if ([view isKindOfClass:[UIButton class]] && view.tag != button.tag) {
            UIButton *btn = (UIButton *)view;
            if (btn.selected) {
                [self startButtonImageAnimate:btn];
            }
            btn.selected = NO;
        }
    }
    
    button.selected = YES;
    [self startButtonImageAnimate:button];
    
    if (button.tag == 10) {
        self.sex = @"男生";
    } else {
        self.sex = @"女生";
    }
}


/**
 修改当前状态

 @param sender
 */
- (IBAction)chooseStatus:(UIButton*)button {
    UIView *superView = button.superview;
    
    for (int i = 0; i < 3; i++) {
        UIView *view = [superView viewWithTag:i + 20];
        if ([view isKindOfClass:[UIButton class]] && view.tag != button.tag) {
            UIButton *btn = (UIButton *)view;
            btn.selected = NO;
        }
    }
    
    button.selected = YES;
    
    if (button.tag == 20) {
        self.status = @"为人父母";
    } else if (button.tag == 21){
        self.status = @"恋爱中/已婚";
    } else {
        self.status = @"单身生活";
    }
}


#pragma mark -- private

/**
 开始动画效果

 @param button 按钮
 */
- (void)startButtonImageAnimate:(UIButton *)button {
    // 设置图片先为90度垂直
    button.imageView.layer.transform = CATransform3DRotate([self getTransform3D:90 * M_PI / 180], 0, 0, 0, 0);
    // 开始动画, 接着开始将设置的90度旋转回原来的度数
    [UIView beginAnimations:@"rotate"context:nil];
    [UIView setAnimationDuration:.35f];
    button.imageView.layer.transform = CATransform3DRotate([self getTransform3D:0], 0, 0, 0, 0);
    [UIView commitAnimations];
}

- (CATransform3D)getTransform3D:(CGFloat) angle {
    CATransform3D transform3D = {
        cos(angle),  0,   sin(angle),  0,
            0,       1,       0,       0,
        -sin(angle), 0,   cos(angle),  0,
            0,       0,       0,       1,
    };
    return transform3D;
}
@end
