//
//  AppDelegate.h
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/21.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexViewController.h"
#import "MenuViewController.h"
#import "JQNavigationController.h"
#import "SearchViewController.h"
#import "BaseIndexViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) JQNavigationController *navigationController;
@property (strong, nonatomic) IndexViewController *indexViewController;
@property (strong, nonatomic) MenuViewController *menuViewController;
@property (strong, nonatomic) SearchViewController *searchViewController;
@property (strong, nonatomic) BaseIndexViewController *baseIndexViewController;

@end

