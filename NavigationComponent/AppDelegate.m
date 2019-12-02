//
//  AppDelegate.m
//  NavigationComponent
//
//  Created by 刘江 on 2019/11/30.
//  Copyright © 2019 Liujiang. All rights reserved.
//

#import "AppDelegate.h"
#import "LLNavigationComponent.h"

#import "ViewController.h"
#import "NavigationController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
+(void)load {
    [LLNavigationComponent contributeForViewController:ViewController.class navigationController:NavigationController.class];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    return YES;
}




@end
