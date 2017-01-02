//
//  SearchViewController.h
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/28.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (assign, nonatomic) NSInteger selectIndex;

@property (strong, nonatomic) UINavigationController *navigationController;

@end
