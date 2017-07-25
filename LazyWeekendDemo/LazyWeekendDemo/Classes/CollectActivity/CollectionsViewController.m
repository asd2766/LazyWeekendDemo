//
//  CollectionsViewController.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 2017/7/25.
//  Copyright © 2017年 吴筠秋. All rights reserved.
//

#import "CollectionsViewController.h"
#import "Collections+CoreDataClass.h"
#import "CollectionItemTableViewCell.h"

@interface CollectionsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

// 参数
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation CollectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cat_me"] style:UIBarButtonItemStyleDone target:self.navigationController action:@selector(showMenu)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 获取数据
    NSString *userId = [[CommonUtil currentUtil] getLoginUserid];
    NSArray *array = [Collections MR_findByAttribute:@"userId" withValue:userId];
    self.dataArray = [NSMutableArray arrayWithArray:array];
    [self showNoDataViewBydataArray:self.dataArray frame:self.mainTableView.frame view:self.mainTableView title:@"暂无数据" desc:@""];
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
    return 111;
}

//cell样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * indentify = @"indexCell";
    CollectionItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: indentify];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"CollectionItemTableViewCell" bundle:nil] forCellReuseIdentifier:indentify];
        cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    }
    
    Collections *item = self.dataArray[indexPath.row];
    [cell updateCellByImageUrl:item.activityImageUrl title:item.activityTitle location:item.activityLocation];
    
    return cell;
}

//设置cell选择方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"哎呦我被点击啦");
    
}

// cell 是否可以编辑,删除等
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

// 删除的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  @"删除";
}

// 点击删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"点击删除啦");
    
    Collections *item = self.dataArray[indexPath.row];
    [item MR_deleteEntity];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [self.mainTableView reloadData];
}

@end
