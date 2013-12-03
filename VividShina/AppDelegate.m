//
//  AppDelegate.m
//  VividShina
//
//  Created by icreative-mini on 13-11-27.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    
    HomeViewController *homeVC = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    self.navVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    self.navVC.navigationBarHidden = YES;
    [self fakeNavigationBar];
    
    self.window.rootViewController = self.navVC;
    [self.window makeKeyAndVisible];
    
    
//    调用registerApp方法来初始化SDK
    [ShareSDK registerApp:@"df86d0587b1"];
    [self addApplication];
    
    return YES;
}

- (void)fakeNavigationBar
{
    UIImageView *navigationBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title.jpg"]];
    [navigationBar setFrame:CGRectMake(0, 0, 1024, 82)];
    [self.navVC.view addSubview:navigationBar];
    
    UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_line.jpg"]];
    [line setFrame:CGRectMake(0, 82, 1024, 2)];
    [self.navVC.view addSubview:line];
}

- (void)addApplication
{
    //添加微信应用
    [ShareSDK connectWeChatTimelineWithAppId:@"wxbce3f0bff27259cd" wechatCls:[WXApi class]];

    //添加新浪微博应用
    [ShareSDK connectSinaWeiboWithAppKey:@"2384851066" appSecret:@"ffa34ef75bdd4ae01b705dd9ed0fd499" redirectUri:@"http://www.sharesdk.com"];
    
    //添加腾讯微博应用
    [ShareSDK connectTencentWeiboWithAppKey:@"801420561" appSecret:@"543c3e59c84c2cdbafa4eaf32f1a7a12" redirectUri:@"http://www.el-lady.com.cn/futurist2013/"];
    
    //添加邮件
    [ShareSDK connectMail];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
