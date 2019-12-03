//
//  LLNavigationBar.m
//  WXCitizenCard
//
//  Created by 刘江 on 2018/8/4.
//  Copyright © 2018年 Liujiang. All rights reserved.
//

#import <objc/runtime.h>
#import "LLNavigationBar.h"
#import "LLNavigationPrivate-Header.h"
//#import "LLNavigationPublic-Header.h"

@interface LLNavigationBar ()
@property (nonatomic, strong)CAShapeLayer *separateLine;
@property (nonatomic, strong)UIVisualEffectView *backMaskView;

@property (nonatomic, strong)NSNumber *constantHeight;
@property (nonatomic, assign)BOOL immutable;
@end

@implementation LLNavigationBar

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _init];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _init];
    }
    return self;
}
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    if (!_immutable) {
        [super setBackgroundColor:backgroundColor];
        
        [_backMaskView removeFromSuperview];
    }
}

- (void)setImage:(UIImage *)image {
    if (!_immutable) {
        [super setImage:image];
        
        [_backMaskView removeFromSuperview];
    }
}

- (void)_init {
    self.frame = CGRectZero;
    self.showNavigationBarShadow = YES;
    [self addSubview:self.backMaskView];
    self.immutable = NO;
    self.layer.zPosition = 100000000L;
//    self.clipsToBounds = NO;
    
}

- (void)setFrame:(CGRect)frame {
    CGRect informal = frame;
    informal.origin.x = 0;
    informal.origin.y = 0;
    informal.size.width = CGRectGetWidth([UIScreen mainScreen].bounds);
    informal.size.height = self.constantHeight!=nil?self.constantHeight.floatValue: 44+(CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)==40?20:CGRectGetHeight([UIApplication sharedApplication].statusBarFrame));

    [super setFrame:informal];

}

- (void)setConstantHeight:(NSNumber *)constantHeight {
    _constantHeight = constantHeight;
    [self setFrame:CGRectZero];
    self.backMaskView.frame = self.bounds;
    [self setShowNavigationBarShadow:_showNavigationBarShadow];
}

- (void)setShowNavigationBarShadow:(BOOL)showNavigationBarShadow {
    
//    if (_showNavigationBarShadow != showNavigationBarShadow) {
        if (showNavigationBarShadow) {
            [self setShowNavigationBarSeparator:NO];
            self.layer.shadowColor = [UIColor colorWithRed:203/255.f green:203/255.f blue:203/255.f alpha:1].CGColor;
            self.layer.shadowOffset = CGSizeMake(0, 3);
            self.layer.shadowRadius = 3;
            self.layer.shadowOpacity = 0.7;

            [self.layer setShadowPath:[[UIBezierPath bezierPathWithRect:self.bounds] CGPath]];
        }else {
            self.layer.shadowColor = [UIColor clearColor].CGColor;
            self.layer.shadowOffset = CGSizeMake(0, 0);
            self.layer.shadowRadius = 0;
            self.layer.shadowOpacity = 0.f;

            [self.layer setShadowPath:[[UIBezierPath bezierPathWithRect:CGRectZero] CGPath]];
        }
        [self setNeedsDisplay];
//    }
    _showNavigationBarShadow = showNavigationBarShadow;
}

- (void)setShowNavigationBarSeparator:(BOOL)showNavigationBarSeparator {
        if (showNavigationBarSeparator) {
            [self setShowNavigationBarShadow:NO];
            [_separateLine removeFromSuperlayer];
            _separateLine = nil;
            
            [self.layer addSublayer:self.separateLine];
        }else {
            [_separateLine removeFromSuperlayer];
        }
        [self setNeedsDisplay];
    _showNavigationBarSeparator = showNavigationBarSeparator;
}

- (UIVisualEffectView *)backMaskView {
    if (!_backMaskView) {
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _backMaskView = [[UIVisualEffectView alloc] initWithEffect:blur];
        _backMaskView.frame = self.bounds;
    }
    return _backMaskView;
}

- (CAShapeLayer *)separateLine {
    if (!_separateLine) {
        UIBezierPath *line = [UIBezierPath bezierPath];
        [line moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
        [line addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        [line closePath];
        _separateLine = [CAShapeLayer layer];
        _separateLine.frame = self.bounds;
        [_separateLine setLineWidth:0.5/2];
        [_separateLine setStrokeColor:[UIColor colorWithWhite:0 alpha:0.3].CGColor];
        _separateLine.path = line.CGPath;
    }
    return _separateLine;
}
@end


@interface UIViewController()

@property (nonatomic, strong)LLNavigationBar *navigationBar;
//@property (nonatomic, assign)BOOL configed;
@end

static const void *kNavigationBarKey = &kNavigationBarKey;
static const void *kEnableGestureKey = &kEnableGestureKey;

//static const void *kConfigedKey = &kConfigedKey;
@implementation UIViewController(NavigationBar)

- (void)setNavigationBar:(LLNavigationBar *)navigationBar {
    objc_setAssociatedObject(self, &kNavigationBarKey, navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LLNavigationBar *)navigationBar {
    LLNavigationBar *bar = objc_getAssociatedObject(self, &kNavigationBarKey);
    if (!bar) {
        bar = [[LLNavigationBar alloc] init];
        bar.immutable = ![self isKindOfClass:[LLNavigationComponent contributeViewController].class];

        [self setNavigationBar:bar];
    }
    return bar;
}

- (UIViewController *)forwardViewController {//TODO 持有
    if (self.navigationController) {
        NSInteger index = [self.navigationController.viewControllers indexOfObject:self]+1;
        if (index > -1 && index < self.navigationController.viewControllers.count) {
            return self.navigationController.viewControllers[index];
        }else if (index == self.navigationController.viewControllers.count && self.navigationController.presentedViewController) {
            if ([self.navigationController.presentedViewController isKindOfClass:[UINavigationController class]]) {
                return [((UINavigationController *)self.navigationController.presentedViewController).viewControllers firstObject];
            }else {
                return self.navigationController.presentedViewController;
            }
        }
    }else if (self.presentedViewController) {
        if ([self.presentedViewController isKindOfClass:[UINavigationController class]]) {
            return [((UINavigationController *)self.presentedViewController).viewControllers firstObject];
        }else {
            return self.presentedViewController;
        }
    }
    return nil;
}
- (UIViewController *)backwardViewController {
    if (self.navigationController) {
        NSInteger index = [self.navigationController.viewControllers indexOfObject:self]-1;
        if (index > -1 && index < self.navigationController.viewControllers.count) {
            return self.navigationController.viewControllers[index];
        }else if (index == -1 && self.navigationController.presentingViewController) {
            if ([self.navigationController.presentingViewController isKindOfClass:[UINavigationController class]]) {
                return [((UINavigationController *)self.navigationController.presentingViewController).viewControllers lastObject];
            }else {
                return self.navigationController.presentingViewController;
            }
        }
    }else if (self.presentingViewController) {
        if ([self.presentingViewController isKindOfClass:[UINavigationController class]]) {
            return [((UINavigationController *)self.presentingViewController).viewControllers lastObject];
        }else {
            return self.presentingViewController;
        }
    }
    return nil;
}
- (void)setEnablePopGesture:(BOOL)enablePopGesture {
    objc_setAssociatedObject(self, &kEnableGestureKey, @(enablePopGesture), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
- (BOOL)enablePopGesture {
    NSNumber *enable = objc_getAssociatedObject(self, &kEnableGestureKey);
    if (!enable) {
        enable = @(YES);
        [self setEnablePopGesture:enable.boolValue];
    }
    return [enable boolValue];
    
}
//- (BOOL)configed {
//    return [objc_getAssociatedObject(self, &kConfigedKey) boolValue];
//}
//
//- (void)setConfiged:(BOOL)configed {
//    objc_setAssociatedObject(self, &kConfigedKey, @(configed), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

@end
