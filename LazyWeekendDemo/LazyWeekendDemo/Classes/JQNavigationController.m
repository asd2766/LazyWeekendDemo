//
//  JQNavigationController.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/25.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "JQNavigationController.h"
#import "MenuViewController.h"
#import "CommonUtil.h"
#import "Consts.h"
#import "AppDelegate.h"

@interface JQNavigationController ()

//@property (strong, nonatomic) MenuViewController *menuViewController;
@property (strong, nonatomic) AppDelegate *appDelegate;

@end

@implementation JQNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.translucent = NO; // 是否半透明
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    [self.navigationBar setBarTintColor:[CommonUtil colorWithHexString:@"#f8f8f8"]]; // 设置背景色
    [self.navigationBar setTintColor:RGB(68, 68, 68)];// 设置按钮颜色
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: RGB(68, 68, 68)}]; //标题颜色
    
    self.appDelegate = [UIApplication sharedApplication].delegate;
//    self.menuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil withViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 显示菜单栏
- (void)showMenu {
    NSLog(@"菜单栏被点击啦");
    
    [self.appDelegate.baseIndexViewController showMenu];
}

// 显示搜索页面
- (void)showSearch {
    NSLog(@"搜索被点击啦");
    [self.appDelegate.baseIndexViewController showSearch];
}
@end
