//
//  InsterestLabelViewController.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 17/7/19.
//  Copyright © 2017年 吴筠秋. All rights reserved.
//

#import "InsterestLabelViewController.h"
#import "InsterestLabelCollectionViewCell.h"

// model
#import "InterestLabel+CoreDataClass.h"

@interface InsterestLabelViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionView;

// 参数
@property (strong, nonatomic) NSString *cellId;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation InsterestLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"选择我的兴趣标签";
    
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cat_me"] style:UIBarButtonItemStyleDone target:self.navigationController action:@selector(showMenu)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(clickForSave)];
    
    // UICollection 注册 cell
    _cellId = @"InsterestLabelCell";
    [self.mainCollectionView registerNib:[UINib nibWithNibName:@"InsterestLabelCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:_cellId];
    
    // 获取兴趣标签数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"InterestLabels.plist" ofType:nil];
    
    self.dataArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    // 设置数据选中效果
    NSPredicate *pred = nil;
    NSString *userId = [[CommonUtil currentUtil] getLoginUserid];
    for (NSMutableDictionary *item in self.dataArray) {
        // 判断该标签是否已经保存在数据库中
        pred = [NSPredicate predicateWithFormat:@"userId == %@ && labelId == %@", userId, item[@"id"]];
        InterestLabel *itemLabel = [InterestLabel MR_findFirstWithPredicate:pred];
        if (itemLabel) {
            // 选中过该数据
            item[@"isSelect"] = @"1";
        } else {
            // 该选项选中, 未存储到数据库中, 保存数据
            item[@"isSelect"] = @"0";
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- action

/**
 点击保存
 */
- (void)clickForSave {
    // 保存到数据库中
    NSString *userId = [[CommonUtil currentUtil] getLoginUserid];
    
    NSPredicate *pred = nil;
    for (NSDictionary *item in self.dataArray) {
        // 判断该标签是否已经保存在数据库中
        pred = [NSPredicate predicateWithFormat:@"userId == %@ && labelId == %@", userId, item[@"id"]];
        InterestLabel *itemLabel = [InterestLabel MR_findFirstWithPredicate:pred];
        if (itemLabel && !(item[@"isSelect"] && [item[@"isSelect"] boolValue])) {
            // 该选项未选中, 之前选择过, 删除保存在数据库的数据
            [itemLabel MR_deleteEntity];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        } else if (!itemLabel && item[@"isSelect"] && [item[@"isSelect"] boolValue]) {
            // 该选项选中, 未存储到数据库中, 保存数据
            itemLabel = [InterestLabel MR_createEntity];
            itemLabel.userId = userId;
            itemLabel.labelId = item[@"id"];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
    }
    
    [self showProgressView:self.view];
    [self performSelector:@selector(saveSuccess) withObject:nil afterDelay:0.5f];
}

- (void)saveSuccess {
    [self hideProgressView];
    [self makeToast:@"保存成功"];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---- UICollectionViewDataSource

// section 个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

// cell 的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    InsterestLabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellId forIndexPath:indexPath];
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    UIImage *unselectImage = [UIImage imageNamed:dic[@"unselectImage"]];
    UIImage *selectImage = [UIImage imageNamed:dic[@"selectImage"]];
    if (dic != nil) {
        [cell updateContentWithImage:unselectImage name:dic[@"name"]];
    }
    
    if (dic[@"isSelect"] != nil && [dic[@"isSelect"] boolValue]) {
        // 选中效果
        [cell cellIsSelected:YES image:selectImage];
    } else {
        [cell cellIsSelected:NO image:unselectImage];
    }
    
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout
// cell 的 size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = floor(_screenWidth/3.0);
    return CGSizeMake(width, width);
}

// cell 的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 0, 0, 0);
}

// cell 之间最小的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

// cell 之间最小的列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


#pragma mark UICollectionViewDelegate
// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.dataArray[indexPath.row]];
    
    if (dic[@"isSelect"] && [dic[@"isSelect"] boolValue]) {
        // 选中效果
        dic[@"isSelect"] = @"0";
    } else {
        dic[@"isSelect"] = @"1";
    }
    [self.dataArray replaceObjectAtIndex:indexPath.row withObject:dic];
    [self.mainCollectionView reloadItemsAtIndexPaths:@[indexPath]];
}


@end
