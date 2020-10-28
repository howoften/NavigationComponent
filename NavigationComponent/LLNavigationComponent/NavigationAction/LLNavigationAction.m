//
//  LLNavigationAction.m
//  NavigationComponent
//
//  Created by 刘江 on 2019/12/1.
//  Copyright © 2019 Liujiang. All rights reserved.
//

#import "LLNavigationAction.h"
#import "LLNavigationAnimator.h"
#import "LLNavigationHelper.h"
#import "LLNavigationInteractivePop.h"

@implementation LLNavigationAction
+ (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if ((toVC.modal == 1 && operation == UINavigationControllerOperationPush) || (fromVC.modal == 1 && operation == UINavigationControllerOperationPop)) {
//        if (toVC.modal == 1) {
//            [toVC.navigationItem setHidesBackButton:YES];
//        }
        return operation == UINavigationControllerOperationPop ? [LLNavigationAnimator popAnimator] : [LLNavigationAnimator pushAnimator];
    }
   
    return nil;
}

+ (void)navigationController:(UINavigationController *)navigationController enablePopGesture:(BOOL)enable {
    [LLNavigationInteractivePop navigationController:navigationController enablePopGesture:enable];
}

@end
