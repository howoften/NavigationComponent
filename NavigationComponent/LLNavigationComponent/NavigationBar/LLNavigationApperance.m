//
//  LLNavigationApperance.m
//  NavigationComponent
//
//  Created by 刘江 on 2019/12/1.
//  Copyright © 2019 Liujiang. All rights reserved.
//

#import "LLNavigationApperance.h"
#import "LLNavigationBar.h"
#import "LLNavigationItem.h"

@implementation LLNavigationApperance

#pragma mark -- LLNavigationPrivateProtocol
+ (void)navigationController:(UINavigationController *)navigationController initWithRootViewController:(UIViewController *)rootViewController {
    if (navigationController.class == [LLNavigationComponent contributeNavigationController].class) {
        [self hiddenNavigationBar:navigationController.navigationBar];
    }
    if (rootViewController.class == [LLNavigationComponent contributeViewController].class) {
        [self hiddenNavigationBar:navigationController.navigationBar];
    }
    LLNavigationBar *bar = [rootViewController valueForKey:@"navigationBar"];
    if (!bar.superview) {
        [rootViewController.view addSubview:bar];
        [bar applyConstraint];
    }
    if ([rootViewController.navigationItem isKindOfClass:[LLNavigationItem class]]) {
        [(LLNavigationItem *)rootViewController.navigationItem setNavigationBar:bar];
    }
//    NSLog(@"%@", NSStringFromSelector(_cmd));
}
+ (void)navigationController:(UINavigationController *)navigationController initWithCoder:(NSCoder *)aDecoder {
    if (navigationController.class == [LLNavigationComponent contributeNavigationController].class) {
        [self hiddenNavigationBar:navigationController.navigationBar];
    }

}

+ (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *rootViewController = viewController;
    LLNavigationBar *bar = [rootViewController valueForKey:@"navigationBar"];
    if (rootViewController.class == [LLNavigationComponent contributeViewController].class) {
        if (!bar.superview) {
            [rootViewController.view addSubview:bar];
            [bar applyConstraint];
        }
        if ([rootViewController.navigationItem isKindOfClass:[LLNavigationItem class]]) {
            [(LLNavigationItem *)rootViewController.navigationItem setNavigationBar:bar];
        }
    }
//    NSLog(@"%@", NSStringFromSelector(_cmd));
}

+ (void)navigationController:(UINavigationController *)navigationController pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    UIViewController *rootViewController = viewController;
//    LLNavigationBar *bar = [rootViewController valueForKey:@"navigationBar"];
//    if (rootViewController.class == [LLNavigationComponent contributeViewController].class) {
//        if (!bar.superview) {
//            [rootViewController.view addSubview:bar];
//            [bar applyConstraint];
//        }
//        if ([rootViewController.navigationItem isKindOfClass:[LLNavigationItem class]]) {
//            [(LLNavigationItem *)rootViewController.navigationItem setNavigationBar:bar];
//        }
//    }

//    NSLog(@"%@", NSStringFromSelector(_cmd));

}
+ (void)navigationController:(UINavigationController *)navigationController presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^)(void))completion {
    if ([viewControllerToPresent isKindOfClass:[LLNavigationComponent contributeNavigationController].class] && (viewControllerToPresent.modalPresentationStyle == UIModalPresentationPageSheet || viewControllerToPresent.modalPresentationStyle == UIModalPresentationFormSheet || viewControllerToPresent.modalPresentationStyle == UIModalPresentationPopover)) {

    }
//    NSLog(@"%@", NSStringFromSelector(_cmd));
}

+ (void)navigationController:(UINavigationController *)navigationController setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *rootViewController = obj;
        if (obj.class == [LLNavigationComponent contributeViewController].class) {
            LLNavigationBar *bar = [rootViewController valueForKey:@"navigationBar"];
            if (!bar.superview) {
                [rootViewController.view addSubview:bar];
                [bar applyConstraint];
            }
            if ([rootViewController.navigationItem isKindOfClass:[LLNavigationItem class]]) {
                [(LLNavigationItem *)rootViewController.navigationItem setNavigationBar:bar];
            }
        }
    }];
//    NSLog(@"%@", NSStringFromSelector(_cmd));
}
+ (void)navigationController:(UINavigationController *)navigationController setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *rootViewController = obj;
        if (obj.class == [LLNavigationComponent contributeViewController].class) {
            LLNavigationBar *bar = [rootViewController valueForKey:@"navigationBar"];
            if (!bar.superview) {
                [rootViewController.view addSubview:bar];
                [bar applyConstraint];
            }
            if ([rootViewController.navigationItem isKindOfClass:[LLNavigationItem class]]) {
                [(LLNavigationItem *)rootViewController.navigationItem setNavigationBar:bar];
            }
        }
    }];
//    NSLog(@"%@", NSStringFromSelector(_cmd));
}

+ (void)hiddenNavigationBar:(UINavigationBar *)bar {
    [bar setTranslucent:YES];
    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    bar.shadowImage = [UIImage new];
    bar.subviews.firstObject.alpha = 0.f;
    bar.hidden = YES;
    
}
@end
