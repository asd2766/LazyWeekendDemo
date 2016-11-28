//
//  SearchViewController.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/28.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@property (strong, nonatomic) UIViewController *contentViewController;
@property (strong, nonatomic) UIView *animationMask;

@end

@implementation SearchViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
             withViewController:(UIViewController *)viewController {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.contentViewController = viewController;
        [self.view insertSubview:self.animationMask atIndex:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
