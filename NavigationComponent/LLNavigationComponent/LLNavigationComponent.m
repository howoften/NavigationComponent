//
//  LLNavigationComponent.m
//  NavigationComponent
//
//  Created by 刘江 on 2019/11/30.
//  Copyright © 2019 Liujiang. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LLNavigationComponent.h"
#import "LLNavigationPrivate-Header.h"
#import "LLMehodSwizzle.h"
#import "LLNavigationApperance.h"
#import "LLNavigationAction.h"
#import "LLNavigationPerformance.h"

@interface LLNavigationComponent ()
@property (nonatomic, strong)id standard_viewcontroller;
@property (nonatomic, strong)id standard_navigationcontroller;
@property (nonatomic, strong)NSPointerArray *delegates;
@property (nonatomic, strong)NSMutableDictionary *popGestures;

@property (nonatomic, strong)id<UINavigationControllerDelegate> navigationDelegat;
@end

static LLNavigationComponent *component = nil;
@implementation LLNavigationComponent
+ (LLNavigationComponent *)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        component = [[LLNavigationComponent alloc] init];
        component.delegates = [NSPointerArray weakObjectsPointerArray];
        component.popGestures = [NSMutableDictionary dictionaryWithCapacity:0];
        component.navigationDelegat = [LLNavigationClass new];
        [component addNavigationNewChildElementDelegate:(id<LLNavigationPrivateProtocol>)LLNavigationApperance.class];
        [component addNavigationNewChildElementDelegate:(id<LLNavigationPrivateProtocol>)LLNavigationAction.class];
    });
    return component;
}

+ (void)contributeForViewController:(Class _Nonnull __unsafe_unretained)viewController navigationController:(Class _Nonnull __unsafe_unretained)navigationController {
    id vc_entity = viewController.new;
    id nav_entity = navigationController.new;
    NSAssert(!([vc_entity isKindOfClass:[UINavigationController class]] || [vc_entity isKindOfClass:[UITabBarController class]] || ![vc_entity isKindOfClass:[UIViewController class]] || [vc_entity isKindOfClass:[NSClassFromString(@"UIInputWindowController") class]] || ![nav_entity isKindOfClass:[UINavigationController class]]), @"[LLNavigationComponent contributeForViewController:navigationController:], Can not finish configuration, ViewController type or navigationController type is wrong !");
    [self share].standard_viewcontroller = vc_entity;
    [self share].standard_navigationcontroller = nav_entity;
    
    [self swizzlingForStandaredNavigationController:nav_entity];
}

+ (void)enablePopGestureRecongnizerAndProtectRootViewControllerPopAction:(UINavigationController *_Nonnull)navigationController {
    [LLNavigationAction.class navigationController:navigationController enablePopGesture:YES];
}

+ (void)protectRootViewControllerPopAction:(UINavigationController *_Nonnull)navigationController {
    [LLNavigationAction.class navigationController:navigationController enablePopGesture:NO];
}

- (void)addNavigationNewChildElementDelegate:(id<LLNavigationPrivateProtocol>)delegate {
    [self.delegates addPointer:(__bridge void * _Nullable)(delegate)];
}

+ (void)swizzlingForStandaredNavigationController:(UINavigationController *_Nonnull)navigationController {

    [LLMehodSwizzle swizzleForClass:navigationController.class originSEL:@selector(initWithRootViewController:) anotherClass:[LLNavigationClass class] newSEL:@selector(initWithRootViewController:)];
    [LLMehodSwizzle swizzleForClass:navigationController.class originSEL:@selector(initWithCoder:) anotherClass:[LLNavigationClass class] newSEL:@selector(initWithCoder:)];
    [LLMehodSwizzle swizzleForClass:navigationController.class originSEL:@selector(pushViewController:animated:) anotherClass:[LLNavigationClass class] newSEL:@selector(pushViewController:animated:)];
    [LLMehodSwizzle swizzleForClass:navigationController.class originSEL:@selector(presentViewController:animated:completion:) anotherClass:[LLNavigationClass class] newSEL:@selector(presentViewController:animated:completion:)];
    [LLMehodSwizzle swizzleForClass:navigationController.class originSEL:@selector(setViewControllers:animated:) anotherClass:[LLNavigationClass class] newSEL:@selector(setViewControllers:animated:)];
    [LLMehodSwizzle swizzleForClass:navigationController.class originSEL:@selector(setViewControllers:) anotherClass:[LLNavigationClass class] newSEL:@selector(setViewControllers:)];

    [LLMehodSwizzle swizzleForClass:navigationController.class originSEL:@selector(setDelegate:) anotherClass:[LLNavigationClass class] newSEL:@selector(setDelegate:)];
//    [LLMehodSwizzle swizzleForClass:navigationController.class originSEL:@selector(viewDidLoad) anotherClass:[LLNavigationClass class] newSEL:@selector(viewDidLoad)];
    [LLMehodSwizzle swizzleForClass:navigationController.class originSEL:@selector(interactivePopGestureRecognizer) anotherClass:[LLNavigationClass class] newSEL:@selector(interactivePopGestureRecognizer)];
}

+ (UIViewController *)contributeViewController {
    return [self share].standard_viewcontroller;
}
+ (UINavigationController *)contributeNavigationController {
    return [self share].standard_navigationcontroller;
}
+ (UIGestureRecognizer *)popGestureForNavigationController:(UINavigationController *)navigationController {
    if ([navigationController isKindOfClass:[UINavigationController class]]) {
       return [component.popGestures objectForKey:[NSString stringWithFormat:@"%lx", (unsigned long)navigationController.hash]];
    }
    return nil;
}

+ (void)openViewController:(UIViewController *)viewController { [LLNavigationPerformance openViewController:viewController]; }
+ (void)openViewControllerFromModalStyle:(UIViewController *)viewController {[LLNavigationPerformance openViewControllerFromModalStyle:viewController]; }
+ (void)goback {[LLNavigationPerformance goback]; }
+ (void)gotoRoot { [LLNavigationPerformance gotoRoot]; }
+ (void)gobackOnce { [LLNavigationPerformance gobackOnce]; }
+ (void)gobackTwice { [LLNavigationPerformance gobackTwice]; }
+ (void)gobackThreeTimes { [LLNavigationPerformance gobackThreeTimes]; }
+ (void)gobackFourTimes { [LLNavigationPerformance gobackFourTimes]; }
+ (void)gobackFiveTimes { [LLNavigationPerformance gobackFiveTimes]; }
+ (void)gobackSixTimes {[LLNavigationPerformance gobackSixTimes]; }
+ (void)gobackSevenTimes {[LLNavigationPerformance gobackSevenTimes]; }
+ (void)gobackEightTimes { [LLNavigationPerformance gobackEightTimes]; }
+ (void)gobackNineTimes {[LLNavigationPerformance gobackNineTimes]; }
+ (void)gobackTimes:(NSUInteger)times {[LLNavigationPerformance gobackTimes:times]; }


@end

@implementation LLNavigationClass
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    id nav = [super initWithRootViewController:rootViewController];
    for (id element in component.delegates) {
        if ([element respondsToSelector:@selector(navigationController:initWithRootViewController:)]) {
            [[element class] navigationController:self initWithRootViewController:rootViewController];
        }
    }
    [(UINavigationController *)nav setDelegate:component.navigationDelegat];
    return nav;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    id nav =  [super initWithCoder:aDecoder];
    for (id element in component.delegates) {
        if ([element respondsToSelector:@selector(navigationController:initWithCoder:)]) {
            [[element class] navigationController:self initWithCoder:aDecoder];
        }
    }
    [nav setDelegate:component.navigationDelegat];
    return nav;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    for (id element in component.delegates) {
        if ([element respondsToSelector:@selector(navigationController:pushViewController:animated:)]) {
            [[element class] navigationController:self pushViewController:viewController animated:animated];
        }
    }
    [super pushViewController:viewController animated:animated];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^)(void))completion {
    for (id element in component.delegates) {
        if ([element respondsToSelector:@selector(navigationController:presentViewController:animated:completion:)]) {
            [[element class] navigationController:self presentViewController:viewControllerToPresent animated:flag completion:completion];
        }
    }
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    for (id element in component.delegates) {
        if ([element respondsToSelector:@selector(navigationController:willShowViewController:animated:)]) {
            [[element class] navigationController:navigationController willShowViewController:viewController animated:animated];
        }
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    id<UIViewControllerAnimatedTransitioning> animator = nil;
  
    for (int i = 0; i <component.delegates.count && animator == nil; i++ ) {
        id element = [component.delegates pointerAtIndex:i];
        if ([element respondsToSelector:@selector(navigationController:animationControllerForOperation:fromViewController:toViewController:)]) {
            animator = [[element class] navigationController:navigationController animationControllerForOperation:operation fromViewController:fromVC toViewController:toVC];
        }
    }
    return animator;
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    for (id element in component.delegates) {
        if ([element respondsToSelector:@selector(setViewControllers:animated:)]) {
            [[element class] navigationController:self setViewControllers:viewControllers animated:animated];
        }
    }
    [super setViewControllers:viewControllers animated:animated];
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{
    for (id element in component.delegates) {
        if ([element respondsToSelector:@selector(navigationController:setViewControllers:)]) {
            [[element class] navigationController:self setViewControllers:viewControllers];
        }
    }
    [super setViewControllers:viewControllers];
}

- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate {
    if (!self.delegate && [NSStringFromClass(delegate.class) isEqualToString:@"LLNavigationClass"]) {
        [super setDelegate:delegate];
    }else {
        NSLog(@"%@", [NSString stringWithFormat:@"[%@ setDelegate:], this selector is prohibit.", NSStringFromClass([component.standard_navigationcontroller class])]);
    }
}

//- (void)viewDidLoad {
////    [self viewDidLoad];
//    for (id element in component.delegates) {
//        if ([element respondsToSelector:@selector(navigationController:viewDidLoad:)]) {
//            [[element class] navigationController:self viewDidLoad:nil];
//        }
//    }
//}

- (UIGestureRecognizer *)interactivePopGestureRecognizer {
    UIGestureRecognizer *gesture = [super interactivePopGestureRecognizer];
    [component.popGestures setObject:gesture forKey:[NSString stringWithFormat:@"%lx", (unsigned long)self.hash]];
    return nil;
}

@end
