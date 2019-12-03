//
//  LLNavigationInteractivePop.m
//  NavigationComponent
//
//  Created by 刘江 on 2019/12/3.
//  Copyright © 2019 Liujiang. All rights reserved.
//

#import "LLNavigationInteractivePop.h"
#import "LLNavigationPrivate-Header.h"
#import "LLMehodSwizzle.h"
@implementation LLNavigationInteractivePop
+ (void)navigationController:(UINavigationController<UIGestureRecognizerDelegate> *)navigationController enablePopGesture:(BOOL)enable {
    UIGestureRecognizer *popGesture = navigationController.interactivePopGestureRecognizer;
    popGesture = [LLNavigationComponent popGestureForNavigationController:navigationController];
    navigationController.enablePopGesture = enable;
    if (popGesture.delegate != navigationController) {
        [self implementGestureDelegate:navigationController];
        
        if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            popGesture.delegate = navigationController;
        }
    }
}

+ (void)implementGestureDelegate:(id)instance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [LLMehodSwizzle swizzleForClass:[instance class] originSEL:@selector(gestureRecognizerShouldBegin:) anotherClass:LLNavigationClass.class newSEL:@selector(gestureRecognizerShouldBegin:)];
        
    });
}
@end

@interface LLNavigationClass ()

@end

@implementation LLNavigationClass (GestureDelegate)

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    UIGestureRecognizer *popGesture = self.interactivePopGestureRecognizer;
    popGesture = [LLNavigationComponent popGestureForNavigationController:self];
    if (gestureRecognizer == popGesture) {
        // 屏蔽调用rootViewController的滑动返回手势
        if (!self.enablePopGesture || self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0] || self.topViewController.modal == 1 || !self.topViewController.enablePopGesture) {
            return NO;
        }
    }
    return YES;
}

@end


