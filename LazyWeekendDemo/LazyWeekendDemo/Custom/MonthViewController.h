//
//  MonthViewController.h
//  zhaoxiewang
//
//  Created by 吴筠秋 on 16/4/6.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "BaseViewController.h"

@protocol MonthViewControllerDelegate <NSObject>

@optional

- (void)datePickerWithSelectedDate:(NSDate *)selectedDate;

@end


@interface MonthViewController : BaseViewController

@property (weak, nonatomic) id<MonthViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *buttonOK;
@property (assign, nonatomic) NSInteger dicTag;

- (IBAction)buttonOKClick:(id)sender;
- (IBAction)clickForCancel:(id)sender;

//参数
@property (nonatomic, strong) NSDate *selectDate;

@end

