//
//  LLNavigationPrivate-Header.h
//  NavigationComponent
//
//  Created by 刘江 on 2019/12/1.
//  Copyright © 2019 Liujiang. All rights reserved.
//

#ifndef LLNavigationPrivate_Header_h
#define LLNavigationPrivate_Header_h
#import <UIKit/UIKit.h>
#import "LLNavigationComponent.h"
#import "LLNavigationBar.h"
@protocol LLNavigationPrivateProtocol

+ (void)navigationController:(UINavigationController *)navigationController initWithRootViewController:(UIViewController *)rootViewController;
+ (void)navigationController:(UINavigationController *)navigationController initWithCoder:(NSCoder *)aDecoder;
+ (void)navigationController:(UINavigationController *)navigationController pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
+ (void)navigationController:(UINavigationController *)navigationController presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^)(void))completion;
+ (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated;
+ (void)navigationController:(UINavigationController *)navigationController setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated;
+ (void)navigationController:(UINavigationController *)navigationController setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers;

@end

@protocol LLNavigationTransitionProtocol
+ (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC;

@end

@interface LLNavigationComponent (Extension)
+ (void)addNavigationNewChildElementDelegate:(id<LLNavigationPrivateProtocol>)delegate;
+ (UIViewController *)contributeViewController;
+ (UINavigationController *)contributeNavigationController;
@end

@interface LLNavigationBar (Extension)
@property (nonatomic, strong)NSNumber *constantHeight;
@property (nonatomic, assign)BOOL immutable;
@end

@interface LLNavigationClass: UINavigationController<UINavigationControllerDelegate>

@end

@interface UIViewController(NavigationAction)
@property (nonatomic, assign)int modal;
@property (nonatomic, strong)UIImage *snapshot;

@end

#endif /* LLNavigationPrivate_Header_h */
