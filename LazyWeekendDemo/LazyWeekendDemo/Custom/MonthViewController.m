//
//  MonthViewController.m
//  zhaoxiewang
//
//  Created by 吴筠秋 on 16/4/6.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "MonthViewController.h"

@interface MonthViewController (){
    NSDateComponents *components;
}

@end

@implementation MonthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    
    if (self.selectDate == nil) {
        self.selectDate = [NSDate date];
    }
    
    components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger month= [components month];
    [_pickerView selectRow:100 inComponent:0 animated:NO];
    [_pickerView selectRow:month - 1 inComponent:1 animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonOKClick:(id)sender {
    NSString *dateString;
    if(_dicTag == 99){
        dateString = [NSString stringWithFormat:@"%ld-%ld"
                      ,(long)[components year] - 200 + [_pickerView selectedRowInComponent:0]
                      ,(long)[_pickerView selectedRowInComponent:1] + 1];
    }else{
        dateString = [NSString stringWithFormat:@"%ld-%ld"
                      ,(long)[components year] - 100 + [_pickerView selectedRowInComponent:0]
                      ,(long)[_pickerView selectedRowInComponent:1] + 1];
    }
    
    self.selectDate = [CommonUtil getDateForString:dateString format:@"yyyy-M"];
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(datePickerWithSelectedDate:)]) {
        [_delegate datePickerWithSelectedDate:_selectDate];
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
    return 2;
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
        dateString = [NSString stringWithFormat:@"%ld-%ld"
                      ,[components year] - 200 + [_pickerView selectedRowInComponent:0]
                      ,[_pickerView selectedRowInComponent:1] + 1];
    }else{
        dateString = [NSString stringWithFormat:@"%ld-%ld"
                      ,[components year] - 100 + [_pickerView selectedRowInComponent:0]
                      ,[_pickerView selectedRowInComponent:1] + 1];
    }
    
    self.selectDate = [CommonUtil getDateForString:dateString format:@"yyyy-M"];
    
    if (component == 0) {
        [pickerView reloadComponent:0];
        [pickerView reloadComponent:1];
    } else if (component == 1) {
        [pickerView reloadComponent:1];
    }
}

@end
