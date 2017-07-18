//
//  BaseIndexViewController.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/23.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "BaseIndexViewController.h"
#import "IndexViewController.h"
#import "MenuViewController.h"
#import "SearchViewController.h"


//static const CGFloat kMaxBlackMaskAlpha = 0.8f;
static const NSTimeInterval menuOpenAnimationDuration = 0.45f;
static const NSTimeInterval menuCloseAnimationDuration = 0.45f;

typedef NS_OPTIONS(NSInteger, MenuState) {
    Closed,
    Open,
    Showing
};

@interface BaseIndexViewController ()<UIGestureRecognizerDelegate> {
    CGFloat menuHeight;
}

@property (strong, nonatomic) MenuViewController *menuVC; // 菜单页面
@property (strong, nonatomic) SearchViewController *searchVC; // 搜索页面
@property (strong, nonatomic) UIViewController *currentVC; // 当前显示的 viewController

@property (strong, nonatomic) UIViewController *contentViewController; // 主题的 navgationController
@property (nonatomic) MenuState state; // 状态
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture; // 拖动手势
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture; // 点击手势


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
        
        [self.view addSubview:self.menuVC.view];
        _currentVC = self.menuVC;
        
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        
        self.navigationController = (UINavigationController *)viewController;
        
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

#pragma mark - 拖动手势处理方法
- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    
    CGPoint viewCenter = gesture.view.center;
    CGPoint translation = [gesture translationInView:gesture.view.superview];
    
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        
        viewCenter.y = fabs(viewCenter.y + translation.y);
        self.contentViewController.view.center = viewCenter;
        if (viewCenter.y >= _screenHeight/2 && viewCenter.y <= _screenHeight/2 + menuHeight) {
            // 拖动的距离在展开菜单栏的高度范围内
//            viewCenter.y = fabs(viewCenter.y + translation.y);
            
            if (viewCenter.y >= _screenHeight/2 && viewCenter.y <= _screenHeight/2 + menuHeight) {
                
//                self.contentViewController.view.center = viewCenter;
                
                // 缩放百分比
                CGFloat transformPercentage = 1 - fabs((CGRectGetMinY(self.contentViewController.view.frame) / menuHeight));
                [self transformAtPercentage:transformPercentage];
                [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
                
            } // end if viewCenter.y >= _screenHeight/2 && viewCenter.y <= _screenHeight/2 + menuHeight
            
        } // enf if viewCenter.y >= _screenHeight/2 && viewCenter.y <= _screenHeight/2 + menuHeight
        
        [gesture setTranslation:CGPointZero inView:self.contentViewController.view];
        
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        // 拖动结束，闭合菜单
        UIView *view = nil;
        if (_currentVC == self.menuVC) {
            // 菜单页面
            view = self.menuVC.mainTableView;
        } else {
            // 搜索页面
            view = self.searchVC.mainView;
        }
        
        // 如果拖动范围高于展开区域, 关闭菜单栏
        if (viewCenter.y <= _screenHeight/2 + menuHeight) {
            [self closeWithView:view];
        } else {
            // 回到展开区域内
            viewCenter.y = _screenHeight/2 + menuHeight;
            [UIView animateWithDuration:0.3f animations:^{
                self.contentViewController.view.center = viewCenter;
            }];

        }
    }
    
}

#pragma mark - 点击手势处理
- (void)handleTap:(UITapGestureRecognizer *)gesture {
    UIView *view = nil;
    if (_currentVC == self.menuVC) {
        // 菜单页面
        view = self.menuVC.mainTableView;
    } else {
        // 搜索页面
        view = self.searchVC.mainView;
    }
    [self closeWithView:view];
}

#pragma mark - Set the required transformation based on percentage
- (void) transformAtPercentage:(CGFloat)percentage {
    CGAffineTransform transf = CGAffineTransformIdentity;
    CGFloat newTransformValue =  fabs((percentage)/10 - 1);
    if (_currentVC == self.menuVC) {
        // 菜单页面
        self.menuVC.mainTableView.transform = CGAffineTransformScale(transf, newTransformValue, newTransformValue);
    } else {
        // 搜索页面
        self.searchVC.mainView.transform = CGAffineTransformScale(transf, newTransformValue, newTransformValue);
    }
}

#pragma mark - private

// 显示或者关闭菜单页面
- (void)showMenu {
    
    if (self.state == Closed) {
        [self transitionFromOldViewController:_currentVC toNewViewController:self.menuVC];
        [self openWithView:self.menuVC.mainTableView];
        [self.menuVC handleSelectIndex];
    }else {
        [self closeWithView:self.menuVC.mainTableView];
    }
}

// 显示或者关闭搜索页面
- (void)showSearch {
    
    if (self.state == Closed) {
        [self transitionFromOldViewController:_currentVC toNewViewController:self.searchVC];
        [self openWithView:self.searchVC.mainView];
    }else {
        [self closeWithView:self.searchVC.mainView];
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
          initialSpringVelocity:10 // 初始速度，数值越大一开始移动越快
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
                         self.contentViewController.view.center = CGPointMake(self.contentViewController.view.center.x, _screenHeight/2 + menuHeight);
                         
                         CGAffineTransform transf = CGAffineTransformIdentity;
                         view.transform = CGAffineTransformScale(transf, 1.0f, 1.0f);
                         
                     }
                     completion:^(BOOL finished) {
                         self.state = Open;
                         // 添加手势
                         [self.contentViewController.view addGestureRecognizer:self.panGesture];
                         [self.contentViewController.view addGestureRecognizer:self.tapGesture];
                         
                     }];
}


// 关闭
- (void)closeWithView:(UIView *)view {
    [self closeMenuWithDuration:menuCloseAnimationDuration WithView:view];
}

- (void)closeMenuWithDuration:(NSTimeInterval)duration WithView:(UIView *)view{
    
    //设置状态栏是否隐藏
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [UIView animateWithDuration:duration
                          delay:0.0f
         usingSpringWithDamping:0.90f
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
                         self.contentViewController.view.center = CGPointMake(self.contentViewController.view.center.x, _screenHeight/2);
                         
                         CGAffineTransform transf = CGAffineTransformIdentity;
                         view.transform = CGAffineTransformScale(transf, 0.9f, 0.9f);
                         
                     }
                     completion:^(BOOL finished) {
                         self.state = Closed;
                         [self.contentViewController.view removeGestureRecognizer:self.panGesture];
                         [self.contentViewController.view removeGestureRecognizer:self.tapGesture];
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
