//
//  MenuViewController.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/23.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"
#import "ChangeMsgViewController.h"
#import "InsterestLabelViewController.h" // 选择我的兴趣页面
#import "LoginViewController.h"
#import "CollectionsViewController.h" // 我的收藏

@interface MenuViewController () {
    CGFloat menuHeight;
}

// 参数
@property (strong, nonatomic) NSArray *dataArray;


@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    menuHeight = _screenHeight - 64 - 40;
    
    self.dataArray = [NSArray arrayWithObjects:@"首页", @"修改个人资料", @"选择我的兴趣标签", @"收藏的活动", @"设置", nil];
    

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 其他方法

- (void)handleSelectIndex {
    // 判断菜单栏显示内容
    [self checkMenuContent];
    
    
    UIViewController *topVC = self.navigationController.topViewController;
    
    if ([topVC isKindOfClass:[IndexViewController class]]) {
        self.selectIndex = 0;
    } else if ([topVC isKindOfClass:[ChangeMsgViewController class]]
               || [topVC isKindOfClass:[LoginViewController class]]) {
        self.selectIndex = 1;
    } else if ([topVC isKindOfClass:[InsterestLabelViewController class]]) {
        self.selectIndex = 2;
    } else if ([topVC isKindOfClass:[CollectionsViewController class]]) {
        self.selectIndex = 3;
    }
    [self.mainTableView reloadData];
    
}

- (void)checkMenuContent {
    if (![[CommonUtil currentUtil] isLogin:NO]) {
        // 未登录
        self.dataArray = [NSArray arrayWithObjects:@"首页", @"登录", nil];
    } else {
        self.dataArray = [NSArray arrayWithObjects:@"首页", @"修改个人资料", @"选择我的兴趣标签", @"收藏的活动", @"退出登录", nil];
    }
}

#pragma mark - UITableViewDelegate UITableViewDataSource

//返回多少个section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

//cell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

//cell样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * indentify = @"normalMenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: indentify];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentify];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:21];
    
    if (_selectIndex == indexPath.row) {
        // 选中样式
        cell.textLabel.textColor = [UIColor whiteColor];
    } else {
        cell.textLabel.textColor = [CommonUtil colorWithHexString:@"#8a8a8a"];
        
    }
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

//设置cell选择方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.parentViewController isKindOfClass:[BaseIndexViewController class]]) {
        BaseIndexViewController *viewController = (BaseIndexViewController *)self.parentViewController;
        [viewController showMenu];
    }
    
    switch (indexPath.row) {
        case 0: {
            // 首页
            
            [self.navigationController popToRootViewControllerAnimated:NO];
            break;
        }
        case 1: {
            if ([[CommonUtil currentUtil] isLogin:YES]) {
                // 修改个人资料
                ChangeMsgViewController *nextController = [[ChangeMsgViewController alloc] initWithNibName:@"ChangeMsgViewController" bundle:nil];
                [self.navigationController pushViewController:nextController animated:NO];
            }
            break;
        }
        case 2: {
            // 选择我的兴趣页面
            InsterestLabelViewController *nextController = [[InsterestLabelViewController alloc] initWithNibName:@"InsterestLabelViewController" bundle:nil];
            [self.navigationController pushViewController:nextController animated:NO];
            break;
        }
        case 3: {
            // 我的收藏页面
            CollectionsViewController *nextController = [[CollectionsViewController alloc] initWithNibName:@"CollectionsViewController" bundle:nil];
            [self.navigationController pushViewController:nextController animated:NO];
            break;
        }
        case 4: {
            // 退出登录
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            delegate.userId = @"";
            [CommonUtil deleteObjectFromUD:@"loginName"];
            [CommonUtil deleteObjectFromUD:@"loginPwd"];
            [[CommonUtil currentUtil] isLogin];
            break;
        }
            
        default:
            break;
    }
    
    _selectIndex = indexPath.row;
    [self.mainTableView reloadData];
    
}

@end
