//
//  LLNavigationAnimator.m
//  NavigationComponent
//
//  Created by 刘江 on 2019/12/2.
//  Copyright © 2019 Liujiang. All rights reserved.
//

#import "LLNavigationAnimator.h"
#import "LLNavigationHelper.h"
//#import "LLNavigationPrivate-Header.h"
@implementation LLNavigationAnimator
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    
    // For a Push:
    //      fromView = The current top view controller.
    //      toView   = The incoming view controller.
    // For a Pop:
    //      fromView = The outgoing view controller.
    //      toView   = The new top view controller.
    UIView *fromView;
    UIView *toView;
    
    // In iOS 8, the viewForKey: method was introduced to get views that the
    // animator manipulates.  This method should be preferred over accessing
    // the view of the fromViewController/toViewController directly.
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    fromView.frame = [transitionContext initialFrameForViewController:fromViewController];
    toView.frame = [transitionContext finalFrameForViewController:toViewController];
    // If a push is being animated, the incoming view controller will have a
    // higher index on the navigation stack than the current top view
    // controller.
    BOOL isPop = !([toViewController.navigationController.viewControllers indexOfObject:toViewController] > [fromViewController.navigationController.viewControllers indexOfObject:fromViewController]) || !fromViewController.navigationController;
    
    if (fromViewController.navigationController.viewControllers.count == 2 && !isPop) {
        for (UIView *sub in containerView.subviews) {
            if ([sub isKindOfClass:[UIImageView class]] && sub.tag > 10000000) {
                [sub removeFromSuperview];
            }
        }
    }
    
    
    if (!isPop) {
        UIImageView *snapshot = [LLNavigationAnimator snapshotForViewController:fromViewController];
        [containerView addSubview:snapshot];
        [fromView removeFromSuperview];
        [containerView addSubview:toView];
        
        toView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(containerView.frame)-CGRectGetMinY(fromView.frame));
        CATransform3D fold = CATransform3DIdentity;
        fold.m34 = 1.0/-600;
        fold = CATransform3DScale(fold, 0.95, 0.95, 1);
        
        snapshot.layer.zPosition = -1000.f;
        [UIView animateWithDuration:[self transitionDuration:transitionContext]/2 animations:^{
            snapshot.layer.transform = fold;
        } completion:nil];

        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            toView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];

        }];
    }else {
        [self positionSnapshotViewFrom:toViewController inView:containerView];
        UIImageView *snapshot = [self findSnapshotFrom:toViewController inView:containerView];
//        [containerView insertSubview:toView belowSubview:snapshot];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([self transitionDuration:transitionContext]/2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [UIView animateWithDuration:[self transitionDuration:transitionContext]/2 animations:^{
                 snapshot.layer.transform = CATransform3DIdentity;
             } completion:^(BOOL finished) {
             }];
         });
         
         [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
             fromView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(containerView.frame)-CGRectGetMinY(fromView.frame));;
         } completion:^(BOOL finished) {
             [containerView addSubview:toView];
             [snapshot removeFromSuperview];
             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];

         }];
        
    }
    
}


+ (UIImageView *)snapshotForViewController:(UIViewController *)viewController {
    UIImageView *snapshot = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(viewController.view.frame), CGRectGetHeight(viewController.view.frame))];
    snapshot.tag = viewController.navigationController.hash/1000+[viewController.navigationController.viewControllers indexOfObject:viewController];
    snapshot.image = [LLNavigationHelper shotWithView:viewController.view];
    
    return snapshot;
}
- (void)positionSnapshotViewFrom:(UIViewController *)viewController inView:(UIView *)containerView {
    UIImageView *snapshot = nil;
    NSInteger snapshotTag = viewController.navigationController.hash/1000+[viewController.navigationController.viewControllers indexOfObject:viewController];
    NSUInteger index = containerView.subviews.count;
    NSArray *subviews = [containerView.subviews copy];
    for (int i = 0; i < subviews.count; i++) {
        UIImageView *sub = subviews[i];
        if (sub.tag == snapshotTag) {
            snapshot = sub;
            //                [containerView insertSubview:snapshot belowSubview:fromView];
            index = i;
            break;
        }
    }
    if (!snapshot) {
        snapshot = [LLNavigationAnimator snapshotForViewController:viewController];
        CATransform3D fold = CATransform3DIdentity;
        fold.m34 = 1.0/-600;
        fold = CATransform3DScale(fold, 0.95, 0.95, 1);
        snapshot.layer.transform = fold;
        [containerView addSubview:snapshot];
        for (int i = 0; i < subviews.count; i++) {
            UIImageView *sub = subviews[i];
            if (sub.tag > snapshotTag) {
                [containerView insertSubview:snapshot belowSubview:sub];
                break;
            }
        }
    }
    
}

- (UIImageView *)findSnapshotFrom:(UIViewController *)viewController inView:(UIView *)containerView {
    UIImageView *snapshot = nil;
    NSInteger snapshotTag = viewController.navigationController.hash/1000+[viewController.navigationController.viewControllers indexOfObject:viewController];
    NSUInteger index = containerView.subviews.count;
    NSArray *subviews = [containerView.subviews copy];
    for (int i = 0; i < subviews.count; i++) {
        UIImageView *sub = subviews[i];
        if (sub.tag == snapshotTag) {
            snapshot = sub;
            //                [containerView insertSubview:snapshot belowSubview:fromView];
            index = i;
            //                break;
        }
    }
    for (int i = (int)index+1; i < subviews.count; i++) {
        UIImageView *sub = subviews[i];
        if ([sub isKindOfClass:[UIImageView class]] && sub.tag > 1000000) {
            sub.hidden = YES;
            [sub removeFromSuperview];
        }
    }
    return snapshot;
}

@end
