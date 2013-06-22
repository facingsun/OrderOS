//
//  HypnosisterAppDelegate.m
//  OrederOS
//
//  Created by Edward on 13-5-8.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "HypnosisterAppDelegate.h"

#import "HypnosisterFirstViewController.h"

#import "HypnosisterSecondViewController.h"

#import "ThirdViewController.h"
#import "FourthViewController.h"

#import "TCWBFriendViewController.h"

#import "TCWBRebroadcastMsgViewController.h"

#import "FileStreame.h"


@implementation HypnosisterAppDelegate
@synthesize tabBarController=_tabBarController;
@synthesize navigationControl=_navigationControl;
@synthesize window=_window;
@synthesize logout;

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [_navigationControl release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    UIViewController *viewController1 = [[[HypnosisterFirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil] autorelease];
    UIViewController *viewController2 = [[[HypnosisterSecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil] autorelease];
     UIViewController *viewController3 = [[[ThirdViewController alloc] initWithNibName:@"ThirdViewController" bundle:nil] autorelease];
     UIViewController *viewController4 = [[[FourthViewController alloc] initWithNibName:@"FourthViewController" bundle:nil] autorelease];
    
    _tabBarController = [[[UITabBarController alloc] init] autorelease];
    //[_tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"beijing.png"]];
     [_tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.9 green:0.2 blue:0.2 alpha:1.0]];
   // [_tabBarController.tabBarItem setImage:[UIImage imageNamed:@"beijing.png"]];
    _navigationControl=[[[UINavigationController alloc]initWithRootViewController:_tabBarController]autorelease];
     [_navigationControl.navigationBar setTintColor:[UIColor colorWithRed:0.9 green:0.2 blue:0.2 alpha:1.0]];
    //[_navigationControl.navigationBar setBackgroundImage:[UIImage imageNamed:@"tese.jpg"] forBarMetrics:UIBarMetricsDefault];
    _tabBarController.viewControllers = @[viewController1, viewController2,viewController3,viewController4];
    _window.rootViewController = _navigationControl;
    [_window makeKeyAndVisible];
    return YES;
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

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
