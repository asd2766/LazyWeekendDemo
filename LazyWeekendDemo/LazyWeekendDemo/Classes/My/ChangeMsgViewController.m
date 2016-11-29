//
//  ChangeMsgViewController.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/29.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "ChangeMsgViewController.h"

@interface ChangeMsgViewController ()

@end

@implementation ChangeMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 设置左边按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cat_me"] style:UIBarButtonItemStyleDone target:self.navigationController action:@selector(showMenu)];
    
    // 设置右边按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(clickForSave)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - action

/**
 *  保存
 */
- (void)clickForSave {
    NSLog(@"啊啊啊啊，要保存啦");
}

@end
