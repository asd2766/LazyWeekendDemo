//
//  SearchViewController.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/28.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "SearchViewController.h"
#import "TPKeyboardAvoidingCollectionView.h"
#import "SearchItemCollectionViewCell.h"
#import "BaseIndexViewController.h"

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *locationLabel;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingCollectionView *mainCollectionView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

// 参数
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"全部类目", @"name",
                         @"ic_all_small_gray", @"iconImage", nil];
    [self.dataArray addObject:dic];
    
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"户外活动", @"name",
           @"ic_c_montain_samll_small", @"iconImage", nil];
    [self.dataArray addObject:dic];
    
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"暂不开放", @"name",
           @"ic_music_small_small", @"iconImage", nil];
    [self.dataArray addObject:dic];
    
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"DIY手作", @"name",
           @"ic_pic_small_small", @"iconImage", nil];
    [self.dataArray addObject:dic];
    
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"派对聚餐", @"name",
           @"ic_c_persons", @"iconImage", nil];
    [self.dataArray addObject:dic];
    
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"运动健身", @"name",
           @"ic_basketball_small_small", @"iconImage", nil];
    [self.dataArray addObject:dic];
    
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"文艺生活", @"name",
           @"ic_c_leaf_small_small", @"iconImage", nil];
    [self.dataArray addObject:dic];
    
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"沙龙学堂", @"name",
           @"ic_c_stage_small_small", @"iconImage", nil];
    [self.dataArray addObject:dic];
    
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"茶会雅集", @"name",
           @"ic_bar_small_small", @"iconImage", nil];
    [self.dataArray addObject:dic];
    
    [self.mainCollectionView registerNib:[UINib nibWithNibName:@"SearchItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SearchItemCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
// cell 数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

// cell 样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchItemCell" forIndexPath:indexPath];
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    
    BOOL isSelected = (indexPath.row == self.selectIndex);
    
    [cell setImage:dic[@"iconImage"] name:dic[@"name"] isSelected:isSelected];
    
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout
// cell 尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = floor((_screenWidth - 30 - 10*3)/3);
    return CGSizeMake(width, 30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 30, 10, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 30;
}

#pragma mark UICollectionViewDelegate
// 选择实现
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndex = indexPath.row;
    [collectionView reloadData];
    
    BaseIndexViewController *viewController = (BaseIndexViewController *)self.parentViewController;
    [viewController showMenu];
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"handleSearch" object:dic[@"name"]];
}

@end
