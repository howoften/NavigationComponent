//
//  LLNavigationApperance.m
//  NavigationComponent
//
//  Created by 刘江 on 2019/12/1.
//  Copyright © 2019 Liujiang. All rights reserved.
//

#import "LLNavigationApperance.h"
#import "LLNavigationBar.h"

@implementation LLNavigationApperance

#pragma mark -- LLNavigationPrivateProtocol
+ (void)navigationController:(UINavigationController *)navigationController initWithRootViewController:(UIViewController *)rootViewController {
    [self clearNavigationBar:navigationController.navigationBar];
    LLNavigationBar *bar = [rootViewController valueForKey:@"navigationBar"];
    if (!bar.superview) {
        [rootViewController.view addSubview:bar];
        
    }
//    NSLog(@"%@", NSStringFromSelector(_cmd));
}
+ (void)navigationController:(UINavigationController *)navigationController initWithCoder:(NSCoder *)aDecoder {
    [self clearNavigationBar:navigationController.navigationBar];
//    NSLog(@"%@", NSStringFromSelector(_cmd));
}

+ (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    LLNavigationBar *bar = [viewController valueForKey:@"navigationBar"];
    if (!bar.superview) {
        [viewController.view addSubview:bar];
        
    }
//    NSLog(@"%@", NSStringFromSelector(_cmd));
}

+ (void)navigationController:(UINavigationController *)navigationController pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    LLNavigationBar *bar = [viewController valueForKey:@"navigationBar"];
    if (!bar.superview) {
        [viewController.view addSubview:bar];
        
    }

    
//    NSLog(@"%@", NSStringFromSelector(_cmd));

}
+ (void)navigationController:(UINavigationController *)navigationController presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^)(void))completion {
    if ([viewControllerToPresent isKindOfClass:[LLNavigationComponent contributeNavigationController].class] && (viewControllerToPresent.modalPresentationStyle == UIModalPresentationPageSheet || viewControllerToPresent.modalPresentationStyle == UIModalPresentationFormSheet || viewControllerToPresent.modalPresentationStyle == UIModalPresentationPopover)) {
#ifdef __IPHONE_13_0
            UIViewController *top = [(UINavigationController *)viewControllerToPresent topViewController];
            top.navigationBar.constantHeight = @56;
#endif
    }
//    NSLog(@"%@", NSStringFromSelector(_cmd));
}

+ (void)navigationController:(UINavigationController *)navigationController setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LLNavigationBar *bar = [obj valueForKey:@"navigationBar"];
        if (!bar.superview) {
            [obj.view addSubview:bar];
            
        }
    }];
//    NSLog(@"%@", NSStringFromSelector(_cmd));
}
+ (void)navigationController:(UINavigationController *)navigationController setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LLNavigationBar *bar = [obj valueForKey:@"navigationBar"];
        if (!bar.superview) {
            [obj.view addSubview:bar];
            
        }
    }];
//    NSLog(@"%@", NSStringFromSelector(_cmd));
}

+ (void)clearNavigationBar:(UINavigationBar *)bar {
    [bar setTranslucent:YES];
    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    bar.shadowImage = [UIImage new];
    bar.subviews.firstObject.alpha = 0.f;
}
@end
