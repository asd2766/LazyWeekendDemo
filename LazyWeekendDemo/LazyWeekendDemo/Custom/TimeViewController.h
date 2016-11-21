//
//  TimeViewController.h
//  zhaoxiewang
//
//  Created by 潇潇 on 15/11/12.
//  Copyright © 2015年 吴筠秋. All rights reserved.
//

#import "BaseViewController.h"

@protocol TimeViewControllerDelegate <NSObject>

-(void)sendTimeWith:(NSString * )time;

@end

@interface TimeViewController : BaseViewController<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic, weak)id<TimeViewControllerDelegate>delegate;

@end
