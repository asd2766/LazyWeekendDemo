//
//  IndexViewController.h
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/21.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "BaseViewController.h"

@protocol IndexViewControllerDelegate <NSObject>

@optional
- (void)menuClick:(BOOL)isOpen;

- (void)searchClick:(BOOL)isOpen;

@end

@interface IndexViewController : BaseViewController

@property (assign, nonatomic) id<IndexViewControllerDelegate> delegate;
@end
