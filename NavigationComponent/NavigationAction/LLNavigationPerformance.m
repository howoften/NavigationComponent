//
//  LLNavigationPerformance.m
//  NavigationComponent
//
//  Created by 刘江 on 2019/12/2.
//  Copyright © 2019 Liujiang. All rights reserved.
//

#import "LLNavigationPerformance.h"
#import "LLNavigationHelper.h"
#import <objc/runtime.h>
#

@interface UIViewController()

@property (nonatomic, assign)int modal;
@property (nonatomic, strong)UIImage *snapshot;

@end

static const void *kModalKey = &kModalKey;
static const void *kSnapshotKey = &kSnapshotKey;
@implementation UIViewController(NavigationAction)

- (void)setModal:(int)modal {
    objc_setAssociatedObject(self, &kModalKey, @(modal), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (int)modal {
    return [objc_getAssociatedObject(self, &kModalKey) intValue];
}

- (void)setSnapshot:(UIImage *)snapshot {
    objc_setAssociatedObject(self, &kSnapshotKey, snapshot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)snapshot {
    return objc_getAssociatedObject(self, &kSnapshotKey);

}

@end

@implementation LLNavigationPerformance
+ (void)openViewController:(UIViewController *)viewController {
    UIViewController *current = [LLNavigationHelper topViewController];
    if (current.navigationController) {
        [current.navigationController pushViewController:viewController animated:YES];
    }else {
        NSLog(@"[LLNavigationPerformance openViewController:], current viewcontroller is not contained in navigationController");
    }
}
+ (void)openViewControllerFromModalStyle:(UIViewController *)viewController {
    UIViewController *current = [LLNavigationHelper topViewController];
    if (current.navigationController) {
        viewController.modal = 1;
        [current.navigationController pushViewController:viewController animated:YES];
    }else {
        NSLog(@"[LLNavigationPerformance openViewControllerInNewStack:], current viewcontroller is not contained in navigationController");
    }
}
+ (void)goback {
    UIViewController *current = [LLNavigationHelper topViewController];
     if (current.navigationController.presentingViewController) {
        [current.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else if (current.presentingViewController) {
        [current dismissViewControllerAnimated:YES completion:nil];
    }else if (current.navigationController) {
        [current.navigationController popViewControllerAnimated:YES];
    }
}

+ (void)gotoRoot {
    UIViewController *current = [LLNavigationHelper topViewController];
     if (current.navigationController.presentingViewController) {
        [current.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else if (current.presentingViewController) {
        [current dismissViewControllerAnimated:YES completion:nil];
    }else if (current.navigationController) {
        [current.navigationController popToRootViewControllerAnimated:YES];
    }
}

+ (void)gobackOnce {
    [self gobackTimes:1];
}

+ (void)gobackTwice {
    [self gobackTimes:2];
}
+ (void)gobackThreeTimes {
    [self gobackTimes:3];
}
+ (void)gobackFourTimes {
    [self gobackTimes:4];
}
+ (void)gobackFiveTimes {
    [self gobackTimes:5];
}
+ (void)gobackSixTimes {
    [self gobackTimes:6];
}
+ (void)gobackSevenTimes {
    [self gobackTimes:7];
}
+ (void)gobackEightTimes {
    [self gobackTimes:8];
}
+ (void)gobackNineTimes {
    [self gobackTimes:9];
}

+ (void)gobackTimes:(NSUInteger)times {
    UIViewController *current = [LLNavigationHelper topViewController];
     if (current.navigationController.presentingViewController) {
        [current.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else if (current.presentingViewController) {
        [current dismissViewControllerAnimated:YES completion:nil];
    }else if (current.navigationController) {
        NSUInteger count = current.navigationController.viewControllers.count;
        NSUInteger index =MAX(0, count-1-times);
        [current.navigationController popToViewController:current.navigationController.viewControllers[index] animated:YES];
    }
}
+ (UIViewController *)forwardViewController {
    return nil;
}
+ (UIViewController *)backwardViewController {
    return nil;
}
@end

