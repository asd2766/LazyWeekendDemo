//
//  BaseIndexViewController.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/23.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#define vSpeedFloat   0.5    //滑动速度
#define kMainPageDistance   (64 + 40)   //打开左侧窗时，中视图(右视图)露出的宽度

#import "BaseIndexViewController.h"
#import "IndexViewController.h"
#import "MenuViewController.h"
#import "SearchViewController.h"


static const CGFloat kMaxBlackMaskAlpha = 0.8f;
static const NSTimeInterval menuOpenAnimationDuration = 0.48f;
static const NSTimeInterval menuCloseAnimationDuration = 0.48f;

typedef NS_OPTIONS(NSInteger, MenuState) {
    Closed,
    Open,
    Showing
};

@interface BaseIndexViewController ()<UIGestureRecognizerDelegate> {
    CGFloat menuHeight;
}

@property (strong, nonatomic) MenuViewController *menuVC;
@property (strong, nonatomic) SearchViewController *searchVC;
@property (strong, nonatomic) UIViewController *currentVC;

@property (strong, nonatomic) UIViewController *contentViewController;
//@property (strong, nonatomic) UIView *animationMask;
@property (nonatomic) MenuState state;

@end

@implementation BaseIndexViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
             withViewController:(UIViewController *)viewController {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
        [self addChildViewController:self.menuVC];
        self.menuVC.navigationController = (UINavigationController *)viewController;
        
        self.searchVC = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
        [self addChildViewController:self.searchVC];
        self.searchVC.navigationController = (UINavigationController *)viewController;
        
        self.contentViewController = viewController;
//        [self.view insertSubview:self.animationMask atIndex:0];
        
        [self.view addSubview:self.menuVC.view];
        _currentVC = self.menuVC;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    menuHeight = _screenHeight - 64 - 40;
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - getter + setter
//- (UIView *)animationMask {
//    if (!_animationMask) {
//        _animationMask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _screenWidth, _screenHeight)];
//        _animationMask.backgroundColor = [UIColor blackColor];
//        _animationMask.alpha = 0.0;
//        //autoresizingMask 属性的意思就是自动调整子控件与父控件中间的位置，宽高
//        _animationMask.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    }
//    return _animationMask;
//}


#pragma mark - private

// 显示菜单
- (void)showMenu {
    [self transitionFromOldViewController:_currentVC toNewViewController:self.menuVC];
    
    if (self.state == Closed) {
        [self openWithView:self.menuVC.mainTableView];
    }else {
        [self closeWithView:self.menuVC.mainTableView];
    }
}

- (void)showSearch {
    [self transitionFromOldViewController:_currentVC toNewViewController:self.searchVC];
    
    if (self.state == Closed) {
        [self openWithView:self.searchVC.testLabel];
    }else {
        [self closeWithView:self.searchVC.testLabel];
    }
}

// 展开
- (void)openWithView:(UIView *)view {
    
    [self openMenuWithDuration:menuOpenAnimationDuration withView:view];
}

- (void)openMenuWithDuration:(NSTimeInterval)duration withView:(UIView *)view{
    [UIView animateWithDuration:duration
                          delay:0.0f
         usingSpringWithDamping:0.85 // 弹簧效果 0 ~ 1.0 之间，越小越明显
          initialSpringVelocity:20 // 初始速度，数值越大一开始移动越快
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
                         self.contentViewController.view.center = CGPointMake(self.contentViewController.view.center.x, _screenHeight/2 + menuHeight);
                         
                         CGAffineTransform transf = CGAffineTransformIdentity;
                         view.transform = CGAffineTransformScale(transf, 1.0f, 1.0f);
                         
//                         self.animationMask.alpha = 0;
                         
                     }
                     completion:^(BOOL finished) {
                         self.state = Open;
//                         [self.view sendSubviewToBack:self.animationMask];
                     }];
}


// 关闭
- (void)closeWithView:(UIView *)view {
    [self closeMenuWithDuration:menuCloseAnimationDuration WithView:view];
}

- (void)closeMenuWithDuration:(NSTimeInterval)duration WithView:(UIView *)view{
    [UIView animateWithDuration:duration
                          delay:0.0f
         usingSpringWithDamping:1
          initialSpringVelocity:20
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
                         self.contentViewController.view.center = CGPointMake(self.contentViewController.view.center.x, _screenHeight/2);
                         
                         CGAffineTransform transf = CGAffineTransformIdentity;
                         view.transform = CGAffineTransformScale(transf, 0.9f, 0.9f);
                         
//                         self.animationMask.alpha = kMaxBlackMaskAlpha;
                     }
                     completion:^(BOOL finished) {
                         self.state = Closed;
//                         [self.view sendSubviewToBack:self.animationMask];
                     }];
}


//转换子视图控制器
- (void)transitionFromOldViewController:(UIViewController *)oldViewController
                    toNewViewController:(UIViewController *)newViewController{
    
    if (newViewController == _currentVC) {
        return;
    }
    
    newViewController.view.frame = self.view.bounds;
    
    [self transitionFromViewController:oldViewController toViewController:newViewController duration:0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {

        if (finished) {
            [newViewController didMoveToParentViewController:self];
            _currentVC = newViewController;
        }else{
            _currentVC = oldViewController;
        }
    }];
}
@end
