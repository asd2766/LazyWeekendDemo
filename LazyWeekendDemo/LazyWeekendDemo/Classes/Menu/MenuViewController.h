//
//  MenuViewController.h
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/23.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "BaseViewController.h"

@interface MenuViewController : BaseViewController

@property (strong, nonatomic) UINavigationController *navigationController;

@property (assign, nonatomic) NSInteger selectIndex;

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

- (void)handleSelectIndex;
@end
