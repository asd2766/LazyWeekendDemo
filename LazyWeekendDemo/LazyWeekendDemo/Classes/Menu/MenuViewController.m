//
//  MenuViewController.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/23.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"

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
    
    self.dataArray = [NSArray arrayWithObjects:@"首页", @"修改个人资料", @"选择我的兴趣标签", @"查看我的预订",
                      @"收藏的活动", @"设置", nil];
    
//    [self.mainTableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate UITableViewDataSource

//返回多少个section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
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
    NSLog(@"哎呦喂，我被点击啦， %@", self.navigationController);
    
}

@end
