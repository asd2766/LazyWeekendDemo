//
//  RegistViewController.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 17/7/19.
//  Copyright © 2017年 吴筠秋. All rights reserved.
//

#import "RegistViewController.h"
#import "UserData+CoreDataClass.h"
#import "AppDelegate.h"

@interface RegistViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwd2TextField;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UIView *pwd2View;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_nav_left"] style:UIBarButtonItemStyleDone target:self action:@selector(backClick:)];
    
    // 标题
    self.navigationItem.title = @"注册";
    
    // 添加圆角
    [CommonUtil addViewAttr:self.phoneView borderWidth:0 borderColor:nil cornerRadius:5];
    [CommonUtil addViewAttr:self.pwdView borderWidth:0 borderColor:nil cornerRadius:5];
    [CommonUtil addViewAttr:self.pwd2View borderWidth:0 borderColor:nil cornerRadius:5];
    [CommonUtil addViewAttr:self.registBtn borderWidth:0 borderColor:nil cornerRadius:5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- action


/**
 开始注册

 @param sender
 */
- (IBAction)clickForRegist:(id)sender {
    NSString *phone = [CommonUtil trimStr:self.phoneTextField.text];
    
    if ([CommonUtil isEmpty:phone]) {
        [self makeToast:@"请输入手机号码"];
        [self.phoneTextField becomeFirstResponder];
        return;
    }
    
    if ([CommonUtil isEmpty:self.pwdTextField.text]) {
        [self makeToast:@"请输入密码"];
        [self.pwdTextField becomeFirstResponder];
        return;
    }
    
    if ([CommonUtil isEmpty:self.pwd2TextField.text]) {
        [self makeToast:@"请再次输入密码"];
        [self.pwd2TextField becomeFirstResponder];
        return;
    }
    
    NSString *pwd = [CommonUtil md5:self.pwdTextField.text];
    NSString *pwd2 = [CommonUtil md5:self.pwd2TextField.text];
    if (![pwd isEqualToString:pwd2]) {
        [self makeToast:@"两次输入的密码不一致"];
        [self.pwd2TextField becomeFirstResponder];
        return;
    }
    
    [self.phoneTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
    [self.pwd2TextField resignFirstResponder];
    
    // 判断该用户是否已经存在
    UserData *user = [UserData MR_findFirstByAttribute:@"phone" withValue:phone];
    if (user) {
        [self makeToast:@"该用户已经存在, 请直接登录"];
        return;
    }
    
    // 输入正确, 开始注册, 将用户保存到本地数据库中
    user = [UserData MR_createEntity];
    user.phone = [phone intValue];
    user.password = pwd;
    user.id = [CommonUtil md5:phone];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    // 注册成功, 跳转到登录页面
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.userId = user.id;
    [CommonUtil saveObjectToUD:@"loginName" key:phone];
    [CommonUtil saveObjectToUD:@"loginPwd" key:[CommonUtil md5:pwd]];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
