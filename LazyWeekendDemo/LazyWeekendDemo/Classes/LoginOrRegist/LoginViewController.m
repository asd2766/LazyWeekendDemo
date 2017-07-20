//
//  LoginViewController.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 17/7/19.
//  Copyright © 2017年 吴筠秋. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "UserData+CoreDataClass.h"
#import "AppDelegate.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cat_me"] style:UIBarButtonItemStyleDone target:self.navigationController action:@selector(showMenu)];
    
    // 标题
    self.navigationItem.title = @"登录";
    
    // 设置圆角
    [CommonUtil addViewAttr:self.phoneView borderWidth:0 borderColor:nil cornerRadius:5];
    [CommonUtil addViewAttr:self.pwdView borderWidth:0 borderColor:nil cornerRadius:5];
    [CommonUtil addViewAttr:self.loginBtn borderWidth:0 borderColor:nil cornerRadius:5];
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
    UserData *user = [UserData MR_findFirstByAttribute:@"phone" withValue:phone];
    
    if (!user) {
        [self makeToast:@"该用户不存在"];
        return;
    }
    
    if (![user.password isEqualToString:[CommonUtil md5:pwd]]) {
        [self makeToast:@"用户名或密码错误"];
        return;
    }
    
    // 用户名,密码正确, 成功登录, 保存登录的用户信息
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.userId = user.id;
    [CommonUtil saveObjectToUD:phone key:@"loginName"];
    [CommonUtil saveObjectToUD:[CommonUtil md5:pwd] key:@"loginPwd"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


/**
 跳转到注册页面

 @param sender 
 */
- (IBAction)clickForRegist:(id)sender {
    RegistViewController *nextController = [[RegistViewController alloc] initWithNibName:@"RegistViewController" bundle:nil];
    [self.navigationController pushViewController:nextController animated:YES];
}

@end
