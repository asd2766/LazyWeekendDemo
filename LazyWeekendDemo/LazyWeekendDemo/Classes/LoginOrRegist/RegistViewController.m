//
//  RegistViewController.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 17/7/19.
//  Copyright © 2017年 吴筠秋. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_nav_left"] style:UIBarButtonItemStyleDone target:self action:@selector(clickForBack)];
    
    // 标题
    self.navigationItem.title = @"注册";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- action

/**
 点击返回按钮
 */
- (void)clickForBack {
//    [self showAlertViewByTitle:@"提示" message:@"数据未保存是否返回?"  cancelTitle:@"取消" confirmTitle:@"确定"];
}


@end
