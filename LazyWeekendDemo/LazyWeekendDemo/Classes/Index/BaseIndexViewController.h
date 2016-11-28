//
//  BaseIndexViewController.h
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/23.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseIndexViewController : BaseViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
             withViewController:(UIViewController *)viewController;

- (void)showMenu;

- (void)showSearch;

@end
