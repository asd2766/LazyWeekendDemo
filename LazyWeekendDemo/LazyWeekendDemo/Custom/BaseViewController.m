/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "BaseViewController.h"
#import "AppDelegate.h"

@interface BaseViewController ()<MBProgressHUDDelegate>

@end

@implementation BaseViewController

//此方法设置的是白色子体
//******************************************
- (UIStatusBarStyle)preferredStatusBarStyle
{
//    return UIStatusBarStyleLightContent;//白色时间
    return UIStatusBarStyleDefault;//黑色时间
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}
//******************************************

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpStock) name:@"jumpStock" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backIndex) name:@"backIndex" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToMy) name:@"jumpToMy" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginBackBefore:) name:@"loginBackBefore" object:nil];
    
    [self initNoDataView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)backClickByDimiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - private
- (void)showProgressView:(UIView *)view{

    // Set the hud to display with a color
    
    //初始化加载框
    self.progressHUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:self.progressHUD];
    
    [self.progressHUD show:YES];
}

- (void)hideProgressView{
   
    [self.progressHUD hide:YES];
    
}

//拨打电话
- (IBAction)clickForCall:(id)sender{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"0577-85519999"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

- (void)initNoDataView{
    
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"NoDataView" owner:nil options:nil];
    if (views.count > 0) {
        self.noDataView = views[0];
    }
    
}

/**
 *  设置无数据页面的文字信息
 *
 *  @param title 标题
 *  @param desc  描述文字
 */
- (void)setNodataTitle:(NSString *)title desc:(NSString *)desc{
    
    self.noDataView.titleLabel.text = title;
    self.noDataView.descLabel.text = desc;
    
}

#pragma mark - private
/** 显示通用弹框
 * @param title         标题
 * @param smallTitle    小标题
 * @param detail        详细内容
 * @param type  类型（正确，错误）
 */
- (void)showNormalAlertView:(NSString *)title smallTitle:(NSString *)smallTitle
                     detail:(NSString *)detail alertType:(NormalAlertType)alertType{
    
//    NormalAlertViewController *viewController = [[NormalAlertViewController alloc] initWithNibName:@"NormalAlertViewController" bundle:nil];
//    
//    
//    UIViewController* controller = self.view.window.rootViewController;
//    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
//        viewController.modalPresentationStyle=UIModalPresentationOverCurrentContext;
//    }else{
//        controller.modalPresentationStyle = UIModalPresentationCurrentContext;
//    }
//    
//    
//    
//    [controller presentViewController:viewController animated:YES completion:^{
////        viewController.view.superview.backgroundColor = [UIColor clearColor];
//        [viewController setTitle:title smallTitle:smallTitle detail:detail];
//        [viewController setAlertType:alertType];
//    }];
}

/**
 *  是否显示没有数据页面
 *
 *  @param array 数据
 *  @param frame 显示页面的frame
 *  @param view  父页面
 *  @param title 标题
 *  @param desc  描述
 */
- (void)showNoDataViewBydataArray:(NSArray *)array frame:(CGRect)frame view:(UIView *)view
                            title:(NSString *)title desc:(NSString *)desc{
    self.noDataView.titleLabel.text = title;
    self.noDataView.descLabel.text = nil;
    if ([CommonUtil arrayIsEmpty:array]) {
        if (self.noDataView.superview) {
            return;
        }
        
        self.noDataView.frame = frame;
        CGRect frame1 = self.noDataView.contentView.frame;
        [self.noDataView setNeedsLayout];
        [view addSubview:self.noDataView];
        NSLog(@"x: %f, y: %f, w: %f, h: %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
        NSLog(@"x: %f, y: %f, w: %f, h: %f", frame1.origin.x, frame1.origin.y, frame1.size.width, frame1.size.height);
        NSLog(@"x: %f, y: %f, w: %f, h: %f", view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    }else{
        
        if (self.noDataView.superview) {
            [self.noDataView removeFromSuperview];
        }
        
    }
    
}

#pragma mark - 监听
//进货单
- (void)jumpStock{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.tabBarController setSelectedIndex:3];
}

//返回首页
- (void)backIndex{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.tabBarController setSelectedIndex:0];
}

//进入我的页面
- (void)jumpToMy{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.tabBarController setSelectedIndex:4];
}

////订单详情
//- (void)backOrderDetail{
//    [self.navigationController popToRootViewControllerAnimated:NO];
//    [self.tabBarController setSelectedIndex:2];
//    
//    MyOrderViewController *nextController = [[MyOrderViewController alloc] initWithNibName:@"MyOrderViewController" bundle:nil];
//    [self.navigationController pushViewController:nextController animated:NO];
//}

/**
 *  返回进入进货单之前的一个页面
 *
 *  @param notiction 
 */
- (void)loginBackBefore:(NSNotification *)notiction{
    NSDictionary *userInfo = notiction.userInfo;
    NSString *beforeItemTag = userInfo[@"beforeItemTag"];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.tabBarController setSelectedIndex:[beforeItemTag intValue]];
}

@end
