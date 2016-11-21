//
//  DatePickerViewController.m
//  wedding
//
//  Created by Jianyong Duan on 14/11/24.
//  Copyright (c) 2014年 daoshun. All rights reserved.
//

#import "DatePickerViewController.h"
#import <CoreText/CoreText.h>
#import "CommonUtil.h"
#import "CommonUtil+Date.h"
#import "Consts.h"

@interface DatePickerViewController () {
    NSDateComponents *components;

}

@end

@implementation DatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    
    if (self.selectDate == nil) {
        self.selectDate = [NSDate date];
    }
    
    components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger day = [components day];
    NSInteger month= [components month];
//    NSInteger year= [components year];

    [_pickerView selectRow:100 inComponent:0 animated:NO];
    [_pickerView selectRow:month - 1 inComponent:1 animated:NO];
    [_pickerView selectRow:day - 1 inComponent:2 animated:NO];
    
//    CGFloat width = (CGRectGetWidth([UIScreen mainScreen].bounds) - 7*4) / 3;
//    //添加分割线
//    UIView *underline = [[UIView alloc] initWithFrame:CGRectMake(7, 0, width, 1)];
//    underline.backgroundColor = RGB(161, 161, 161);
//    [_pickerView addSubview:underline];
//    
//    underline.frame = CGRectMake(7*2 + width, 0, width, 1);
//    [_pickerView addSubview:underline];
//    
//    underline.frame = CGRectMake(7*3 + width*2, 0, width, 1);
//    [_pickerView addSubview:underline];
//    
//    underline.frame = CGRectMake(7, CGRectGetHeight(_pickerView.frame) - 1, width, 1);
//    [_pickerView addSubview:underline];
//    
//    underline.frame = CGRectMake(7*2 + width, CGRectGetHeight(_pickerView.frame) - 1, width, 1);
//    [_pickerView addSubview:underline];
//    
//    underline.frame = CGRectMake(7*3 + width*2, CGRectGetHeight(_pickerView.frame) - 1, width, 1);
//    [_pickerView addSubview:underline];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonOKClick:(id)sender {
    NSString *dateString;
    if(_dicTag == 99){
        dateString = [NSString stringWithFormat:@"%ld-%ld-%ld"
                      ,(long)[components year] - 200 + [_pickerView selectedRowInComponent:0]
                      ,(long)[_pickerView selectedRowInComponent:1] + 1
                      ,(long)[_pickerView selectedRowInComponent:2] + 1];
    }else{
        dateString = [NSString stringWithFormat:@"%ld-%ld-%ld"
                      ,(long)[components year] - 100 + [_pickerView selectedRowInComponent:0]
                      ,(long)[_pickerView selectedRowInComponent:1] + 1
                      ,(long)[_pickerView selectedRowInComponent:2] + 1];
    }
    
    self.selectDate = [CommonUtil getDateForString:dateString format:@"yyyy-M-d"];
    
//    if ([_selectDate compare:[NSDate date]] == NSOrderedAscending) {
//        return;
//    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(datePicker:selectedDate:)]) {
        [_delegate datePicker:self selectedDate:_selectDate];
    }
    
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:NO];
    } else {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (IBAction)clickForCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIPickerViewDataSource UIPickerViewDelegate
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
//    CGRect rect = self.lineImageView1.frame;
//    rect.origin.x = CGRectGetWidth(pickerView.frame) / 2 - 44;
//    self.lineImageView1.frame = rect;
//    
//    rect = self.lineImageView2.frame;
//    rect.origin.x = CGRectGetWidth(pickerView.frame) / 2  + 40;
//    self.lineImageView2.frame = rect;
    
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return 200;
    } else if (component == 1 ) {
        return 12;
    } else {

        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:_selectDate];
        
        NSUInteger numberOfDaysInMonth = range.length;
        return numberOfDaysInMonth;
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return CGRectGetWidth([UIScreen mainScreen].bounds) / 3;

}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    CGFloat width = (CGRectGetWidth([UIScreen mainScreen].bounds) - 35*4) / 3;
    if(component==0)
    {
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, width, 32)];
        label.font = [UIFont systemFontOfSize:18];
        label.textAlignment = NSTextAlignmentCenter;
        NSInteger year;
        if(_dicTag == 99){
            year = [components year] - 200 + row;
        }else{
             year = [components year] - 100 + row;
        }
        label.textColor = RGB(161, 161, 161);
//        if (year < [components year]) {
//            label.textColor = RGB(161, 161, 161);
//        } else {
//            label.textColor = RGB(224, 32, 32);
//        }
        
        label.text = [NSString stringWithFormat:@"%ld", (long)year];
        
        if (self.selectDate != nil) {
            NSString *yearStr = [CommonUtil getStringForDate:self.selectDate format:@"yyyy"];
            if([yearStr integerValue] == 2015 && year == 1915){
               label.textColor = RGB(204, 0, 0);
            }
                
            if ([yearStr integerValue] == year) {
                label.textColor = RGB(204, 0, 0);
            }
        }
        
        
        return label;
    } else if (component == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(35, 0, width, 32)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 32)];
        label.font = [UIFont systemFontOfSize:18];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"%ld",(long) row + 1];
        
        label.textColor = RGB(161, 161, 161);

        if (self.selectDate != nil){
            NSString *month = [CommonUtil getStringForDate:self.selectDate format:@"M"];
            if ([month integerValue] == row+1) {
                label.textColor = RGB(204, 0, 0);
            }

        }
        
        [view addSubview:label];
        return view;

    } else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(35, 0, width, 32)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 32)];
        label.font = [UIFont systemFontOfSize:18];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"%ld", (long)row + 1];
        
        label.textColor = RGB(161, 161, 161);

        if (self.selectDate != nil){
            NSString *day = [CommonUtil getStringForDate:self.selectDate format:@"d"];
            if ([day integerValue] == row+1) {
                label.textColor = RGB(204, 0, 0);
            }
        }
        
        
        [view addSubview:label];
        return view;
        
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *dateString;
    if(_dicTag == 99){
        dateString = [NSString stringWithFormat:@"%ld-%ld-%ld"
                      ,[components year] - 200 + [_pickerView selectedRowInComponent:0]
                      ,[_pickerView selectedRowInComponent:1] + 1
                      ,[_pickerView selectedRowInComponent:2] + 1];
    }else{
        dateString = [NSString stringWithFormat:@"%ld-%ld-%ld"
                      ,[components year] - 100 + [_pickerView selectedRowInComponent:0]
                      ,[_pickerView selectedRowInComponent:1] + 1
                      ,[_pickerView selectedRowInComponent:2] + 1];
    }
    
    if (component == 1) {
        //修改月份，将日期选中为1号
        if(_dicTag == 99){
            dateString = [NSString stringWithFormat:@"%ld-%ld-1"
                          ,[components year] - 200 + [_pickerView selectedRowInComponent:0]
                          ,[_pickerView selectedRowInComponent:1] + 1];
        }else{
            dateString = [NSString stringWithFormat:@"%ld-%ld-1"
                          ,[components year] - 100 + [_pickerView selectedRowInComponent:0]
                          ,[_pickerView selectedRowInComponent:1] + 1];
        }
        
    }
    self.selectDate = [CommonUtil getDateForString:dateString format:@"yyyy-M-d"];
    
    if (component == 0) {
        [pickerView reloadComponent:0];
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
    } else if (component == 1) {
        
        [pickerView reloadComponent:1];
        //将日选中第1号
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
        [pickerView reloadComponent:2];
    } else{
        [pickerView reloadComponent:2];
    }
}

@end
