//
//  AppDelegate.m
//  LazyWeekendDemo
//
//  Created by 吴筠秋 on 16/11/21.
//  Copyright © 2016年 吴筠秋. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

// model
#import "UserData+CoreDataClass.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 注册 MagicalRecord
    [MagicalRecord setupAutoMigratingCoreDataStack];
    
    // 自动登录
    [self autoLogin];
    
    //OC需要添加的代码
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //初始化navigationController
    self.indexViewController = [[IndexViewController alloc] initWithNibName:@"IndexViewController" bundle:nil];
    self.navigationController = [[JQNavigationController alloc] initWithRootViewController:self.indexViewController];
    
    self.baseIndexViewController = [[BaseIndexViewController alloc] initWithNibName:@"BaseIndexViewController" bundle:nil withViewController:self.navigationController];
    
    self.window.rootViewController = self.baseIndexViewController;
    
    //设置Window为主窗口并显示出来
//    [self.navigationController setNavigationBarHidden:YES];
    [self.window makeKeyAndVisible];

    [self.window addSubview:self.navigationController.view];

    // 设置 statusBar 颜色
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    statusBar.backgroundColor = [UIColor grayColor];

    
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToLogin) name:@"needlogin" object:nil];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MagicalRecord cleanUp];
}

#pragma mark -- private
- (void)jumpToLogin {
    LoginViewController *nextController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:nextController animated:NO];
}


/**
 自动登录
 */
- (void)autoLogin {
    NSString *phone = [CommonUtil getObjectFromUD:@"loginName"];
    NSString *pwd = [CommonUtil getObjectFromUD:@"loginPwd"];
    if ([CommonUtil isEmpty:phone] || [CommonUtil isEmpty:pwd]) {
        return;
    }
    
    UserData *user = [UserData MR_findFirstByAttribute:@"phone" withValue:phone];
    if (user && [user.password isEqualToString:pwd]) {
        // 用户名密码正确, 登录成功
        self.userId = user.id;
    }
}

@end
