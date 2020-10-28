//
//  LLNavigationPublic-Header.h
//  NavigationComponent
//
//  Created by 刘江 on 2019/12/1.
//  Copyright © 2019 Liujiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLNavigationBar.h"
#import "LLNavigationItem.h"
@interface UIViewController(NavigationBar)
@property (nonatomic, strong, readonly)LLNavigationBar * navigationBar;
@property (nonatomic, strong, readonly)LLNavigationItem * navigationItem;

@property (nonatomic, assign)BOOL enablePopGesture;
@property (nonatomic, strong, readonly)UIViewController * forwardViewController;
@property (nonatomic, strong, readonly)UIViewController * backwardViewController;
- (UIView *)controllersView;
@end

@protocol LLNavigationActionProtocol <NSObject>
+ (void)openViewController:(UIViewController *)viewController;
+ (void)openViewControllerFromModalStyle:(UIViewController *)viewController;
+ (void)goback;
+ (void)gotoRoot;
+ (void)gobackTimes:(NSUInteger)times;
+ (void)gobackOnce;
+ (void)gobackTwice;
+ (void)gobackThreeTimes;
+ (void)gobackFourTimes;
+ (void)gobackFiveTimes;
+ (void)gobackSixTimes;
+ (void)gobackSevenTimes;
+ (void)gobackEightTimes;
+ (void)gobackNineTimes;

@end
