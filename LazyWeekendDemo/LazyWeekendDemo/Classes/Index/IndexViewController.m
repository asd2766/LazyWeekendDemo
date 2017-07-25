//
//  IndexViewController.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/21.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "IndexViewController.h"
#import "IndexItemTableViewCell.h"
#import "MenuViewController.h"

@interface IndexViewController ()<IndexItemTableViewCellDelegate> {
    CGFloat menuHeight;
}

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (strong, nonatomic) UILabel *headerLabel;
@property (strong, nonatomic) UIImageView *headerImageView;

//参数
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *headerDescArray;// 顶部描述文字
@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化参数
    self.dataArray = [NSMutableArray array];
    self.headerDescArray = [NSMutableArray array];
    
    [self initData];
    
    [self initHeaderView];
    
    
    self.title = @"懒人周末";
    
    // 设置左边按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cat_me"] style:UIBarButtonItemStyleDone target:self.navigationController action:@selector(showMenu)];
    
    // 设置右边按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_nav_search"] style:UIBarButtonItemStyleDone target:self.navigationController action:@selector(showSearch)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSearch:) name:@"handleSearch" object:nil];
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
                         @"1", @"id",
                         nil];
    [self.dataArray addObject:dic];
    
    dic = [NSDictionary dictionaryWithObjectsAndKeys:
           @"相约西藏，一起过不一样的新年-----西藏“风情”之旅", @"title",
           @"http://www.cdtianya.com/Public/Uploads/image/20150416/20150416173303_51276.jpg", @"imageUrl",
           @"西藏・369km・户外活动", @"location",
           @"2017年1月28日~2017年2月3日", @"time",
           @"266", @"collectionNum", @"3680", @"price",
           @"2", @"id",
           nil];
    [self.dataArray addObject:dic];
    
    dic = [NSDictionary dictionaryWithObjectsAndKeys:
           @"冬天去海南：用18中方式，在海南的冬天里任性过夏天", @"title",
           @"http://www.youbian.com/Images/Articles/2016-03-09/3668457683.jpg", @"imageUrl",
           @"海南・369km・户外活动", @"location",
           @"本周六 8:30", @"time",
           @"51", @"collectionNum", @"2880", @"price",
           @"3", @"id",
           nil];
    [self.dataArray addObject:dic];
    
    // 顶部描述文字
    self.headerDescArray = [NSMutableArray arrayWithObjects:@"请把我留在最好的时光里。",
                            @"睁眼，因为你心为所动。",  @"启程，只为追寻你所爱。", @"我们始终牵手旅行。", @"闭目，难掩喜悦与期待",
                            @"致总有一天会出发的你。", @"要和有趣的人在一起才会快乐。", @"我们做最了解你的人。", @"保持一颗好奇心，因为世界是彩色的。",
                            @"一起走吧，小懒猫。", nil];
}

- (void)initHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -60, _screenWidth, 60)];
    [self.mainTableView addSubview:headerView];
    
    _headerImageView = [[UIImageView alloc] init];
    _headerImageView.image = [UIImage imageNamed:@"tip_cat"];
    [headerView addSubview:_headerImageView];
    
    
    _headerLabel = [[UILabel alloc] init];
    _headerLabel.font = [UIFont systemFontOfSize:13];
    _headerLabel.textColor = RGB(130, 130, 130);
    [headerView addSubview:_headerLabel];
    
}

/**
 *  处理搜索页面传递回来的值
 *
 *  @param notification 通知
 */
- (void)handleSearch:(NSNotification *)notification {
    NSString *keywords = notification.object;
    
    if ([@"全部类目" isEqualToString:keywords]) {
        
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
        
    } else if ([@"户外活动" isEqualToString:keywords]) {
        
    } else if ([@"暂不开放" isEqualToString:keywords]) {
        
    } else if ([@"DIY手作" isEqualToString:keywords]) {
        
    } else if ([@"派对聚会" isEqualToString:keywords]) {
        
    } else if ([@"运动健身" isEqualToString:keywords]) {
        
    } else if ([@"文艺生活" isEqualToString:keywords]) {
        
    } else if ([@"沙龙学堂" isEqualToString:keywords]) {
        
    } else if ([@"茶会雅集" isEqualToString:keywords]) {
        
    }
    
    [self.mainTableView reloadData];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x <= 0) {
        // 开始下拉了
        int index = arc4random() % (self.headerDescArray.count - 1);
        NSString *str = self.headerDescArray[index];
        self.headerLabel.text = str;
        
        // 计算位置
        CGSize size = [CommonUtil sizeWithString:str fontSize:13 sizewidth:MAXFLOAT sizeheight:MAXFLOAT];
        CGFloat maxWidth = size.width + 10 + 20; // 10: 图片与文字之间间隔  35： 图片宽度
        CGFloat x = ceil((_screenWidth - maxWidth)/2);
        self.headerImageView.frame = CGRectMake(x, ceil((60-35)/2), 20, 20);
        self.headerLabel.frame = CGRectMake(CGRectGetMaxX(self.headerImageView.frame) + 10, CGRectGetMinY(self.headerImageView.frame), size.width, 20);
    }
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
    [cell setTitle:dic[@"title"] location:dic[@"location"] time:dic[@"time"] collectionNum:dic[@"collectionNum"] price:dic[@"price"] delegate:self id:dic[@"id"]];
    
    
    
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
    UIButton *button = (UIButton *)sender;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuClick:)]) {
        [self.delegate menuClick:!button.tag];
    }
    
    if (button.tag == 1) {
        // 展开状态, 闭合操作
        button.tag = 0;
    } else {
        // 闭合状态，展开操作
        button.tag = 1;
    }
    
}

/**
 *  点击搜索
 *
 *  @param sender
 */
- (IBAction)clickForSearch:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchClick:)]) {
        [self.delegate searchClick:!button.tag];
    }
    
    if (button.tag == 1) {
        // 展开状态, 闭合操作
        button.tag = 0;
    } else {
        // 闭合状态，展开操作
        button.tag = 1;
    }
}

#pragma mark - IndexItemTableViewCellDelegate
- (void)collectionActivity:(NSDictionary *)activityDic {
    
}
@end
