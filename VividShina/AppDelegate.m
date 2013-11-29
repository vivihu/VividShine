//
//  AppDelegate.m
//  VividShina
//
//  Created by icreative-mini on 13-11-27.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.windowLevel = UIWindowLevelStatusBar + 1.0f;

    HomeViewController *homeVC = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    self.navVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    self.navVC.navigationBarHidden = YES;
    [self fakeNavigationBar];
    
    self.window.rootViewController = self.navVC;
    [self.window makeKeyAndVisible];
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
