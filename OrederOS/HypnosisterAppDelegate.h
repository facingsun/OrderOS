//
//  HypnosisterAppDelegate.h
//  OrederOS
//
//  Created by Edward on 13-5-8.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HypnosisterAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>{
    BOOL logout;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationControl;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (assign, nonatomic) BOOL                  logout;

@end
