//
//  LoginViewController.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 17/7/19.
//  Copyright © 2017年 吴筠秋. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cat_me"] style:UIBarButtonItemStyleDone target:self.navigationController action:@selector(showMenu)];
    
    // 标题
    self.navigationItem.title = @"登录";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- action
- (IBAction)clickForLogin:(id)sender {
    NSString *phone = [CommonUtil trimStr:self.phoneTextField.text];
    
    if ([CommonUtil isEmpty:phone]) {
        [self makeToast:@"请输入手机号码"];
        [self.phoneTextField becomeFirstResponder];
        return;
    }
    
    NSString *pwd = self.passwordTextField.text;
    if ([CommonUtil isEmpty:pwd]) {
        [self makeToast:@"请输入密码"];
        [self.passwordTextField becomeFirstResponder];
        return;
    }
    
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
    // 从数据库中查找该用户是否存在
    
}

- (IBAction)clickForRegist:(id)sender {
}

@end
