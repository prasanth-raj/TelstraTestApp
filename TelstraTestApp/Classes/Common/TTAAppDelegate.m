//
//  AppDelegate.m
//  TelstraTestApp
//
//  Created by Prasanth Raj S on 17/10/15.
//  Copyright (c) 2015 Cognizant Technologies Solutions Pvt Ltd. All rights reserved.
//

#import "TTAAppDelegate.h"
#import "TTADataListViewController.h"

@interface TTAAppDelegate ()

@end

@implementation TTAAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UINavigationController *rootController = [[UINavigationController alloc]initWithRootViewController:[[TTADataListViewController alloc]init]];
    self.window.rootViewController = rootController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
