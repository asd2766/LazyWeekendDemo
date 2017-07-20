//
//  ChangeMsgViewController.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/29.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "ChangeMsgViewController.h"

// model
#import "UserData+CoreDataClass.h"

@interface ChangeMsgViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *maleBtn;
@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;

// 参数
@property (nonatomic) NSInteger sex; // 性别
@property (nonatomic) NSInteger status; // 当前状态
@property (strong, nonatomic) UserData *user;

@end

@implementation ChangeMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.sex = -1;
    self.status = -1;
    
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
    
    // 获取个人信息
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 其他方法
- (void)getData {
    NSString *userId = [[CommonUtil currentUtil] getLoginUserid];
    self.user = [UserData MR_findFirstByAttribute:@"id" withValue:userId];
    if (self.user) {
        self.nameTextField.text = [CommonUtil isEmpty:self.user.nickName] ? @"" : self.user.nickName;
        
        // 性别选中
        if (self.user.sex) {
            self.sex = self.user.sex;
            UIView *view = [self.view viewWithTag:self.user.sex + 10];
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *btn = (UIButton *)view;
                btn.selected = YES;
                [self startButtonImageAnimate:btn];
            }
        }
        
        // 状态选中
        if (self.user.status) {
            self.status = self.user.status;
            UIView *view = [self.view viewWithTag:self.user.status + 20];
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *btn = (UIButton *)view;
                btn.selected = YES;
            }
        }
    }
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
    if (self.sex <= 0) {
        [self makeToast:@"请选择性别"];
        return;
    }
    
    // 判断当前状态是否选择
    if (self.status <= 0) {
        [self makeToast:@"请选择当前状态"];
        return;
    }
    
    // 将数据保存到数据库中
    if (!self.user) {
        self.user = [UserData MR_createEntity];
    }
    self.user.nickName = name;
    self.user.sex = self.sex;
    self.user.status = self.status;
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    
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
    
    self.sex = button.tag - 10;
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
    
    self.status = button.tag - 20;
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
