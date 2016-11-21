//
//  IndexViewController.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/21.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "IndexViewController.h"
#import "IndexItemTableViewCell.h"

@interface IndexViewController ()

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

//参数
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化参数
    self.dataArray = [NSMutableArray array];
    
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma private
/**
 *  初始化数据
 */
- (void)initData {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"日本奇幻动漫游学之旅 | 【名侦探柯南】会告诉你“真想只有一个！”", @"title",
                         @"http://www.khvip.com/files/2015-6/20150613150254184155.jpg", @"imageUrl",
                         @"东京・369km・户外活动", @"location",
                         @"2017年2月1日~2017年2月8日", @"time",
                         @"25", @"collectionNum", @"19200", @"price",
                         nil];
    [self.dataArray addObject:dic];
    
    dic = [NSDictionary dictionaryWithObjectsAndKeys:
           @"相约西藏，一起过不一样的新年-----西藏“风情”之旅", @"title",
           @"http://www.cdtianya.com/Public/Uploads/image/20150416/20150416173303_51276.jpg", @"imageUrl",
           @"西藏・369km・户外活动", @"location",
           @"2017年1月28日~2017年2月3日", @"time",
           @"266", @"collectionNum", @"3680", @"price",
           nil];
    [self.dataArray addObject:dic];
    
    dic = [NSDictionary dictionaryWithObjectsAndKeys:
           @"冬天去海南：用18中方式，在海南的冬天里任性过夏天", @"title",
           @"http://www.youbian.com/Images/Articles/2016-03-09/3668457683.jpg", @"imageUrl",
           @"海南・369km・户外活动", @"location",
           @"本周六 8:30", @"time",
           @"51", @"collectionNum", @"2880", @"price",
           nil];
    [self.dataArray addObject:dic];
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
    CGFloat imgHeight = 230 * _screenWidthRatio;
    return imgHeight + 230/2;
}

//cell样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * indentify = @"indexCell";
    IndexItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: indentify];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"IndexItemTableViewCell" bundle:nil] forCellReuseIdentifier:indentify];
        cell = [tableView dequeueReusableCellWithIdentifier:indentify];

    }
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    [cell setHeaderImage:dic[@"imageUrl"]];
    [cell setTitle:dic[@"title"] location:dic[@"location"] time:dic[@"time"] collectionNum:dic[@"collectionNum"] price:dic[@"price"]];
    
    return cell;
}

//设置cell选择方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"哎呦我被点击啦");
    
}

#pragma mark - action
/**
 *  菜单栏点击
 *
 *  @param sender
 */
- (IBAction)clickForMenu:(id)sender {
}

/**
 *  点击搜索
 *
 *  @param sender
 */
- (IBAction)clickForSearch:(id)sender {
}
@end
