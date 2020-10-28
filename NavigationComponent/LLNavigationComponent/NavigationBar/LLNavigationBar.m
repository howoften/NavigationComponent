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
#import "LLNavigationItemView.h"
#import "LLNavigationHelper.h"

@interface LLNavigationBar ()
@property (nonatomic, strong)UIImageView *barBackgroundView;
@property (nonatomic, strong)UIView *barContentView;
@property (nonatomic, strong)UIVisualEffectView *blurView;

@property (nonatomic, strong)UIView *borderLine;

@property (nonatomic, weak)LLNavigationItemView *defaultTitleView;
@property (nonatomic, weak)LLNavigationItemView *defaultLeftView;
@property (nonatomic, weak)LLNavigationItemView *defaultRightView;

@property (nonatomic, strong)UIColor *backgroundColor_;

@end

LLNavigationBarSeparatorStyleKey const LLNavigationBarSeparatorStyleNone = @"LLNavigationBarSeparatorStyle.Key.None";
LLNavigationBarSeparatorStyleKey const LLNavigationBarSeparatorStyleLine = @"LLNavigationBarSeparatorStyle.Key.Line";
LLNavigationBarSeparatorStyleKey const LLNavigationBarSeparatorStyleShadow = @"LLNavigationBarSeparatorStyle.Key.Shadow";
@implementation LLNavigationBar
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self construct];
        self.separatorStyle = LLNavigationBarSeparatorStyleLine;
        self.separatorColor = [UIColor colorWithWhite:0.2 alpha:1];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self construct];
        self.separatorStyle = LLNavigationBarSeparatorStyleLine;
        self.separatorColor = [UIColor colorWithWhite:0.2 alpha:1];
    }
    return self;
}
- (void)setSeparatorColor:(UIColor *)separatorColor {
    if (CGColorEqualToColor(separatorColor.CGColor, _separatorColor.CGColor)) {
        return;
    }
    _separatorColor = separatorColor;
    if ([_separatorStyle isEqualToString:LLNavigationBarSeparatorStyleLine]) {
        self.borderLine.backgroundColor = separatorColor;
        
    }else if ([_separatorStyle isEqualToString:LLNavigationBarSeparatorStyleShadow]) {
        self.barBackgroundView.layer.shadowColor = separatorColor.CGColor;

    }
    
}

- (void)setSeparatorStyle:(LLNavigationBarSeparatorStyleKey)separatorStyle {
    _separatorStyle = separatorStyle;
    self.borderLine.hidden = ![separatorStyle isEqualToString:LLNavigationBarSeparatorStyleLine];
    if ([_separatorStyle isEqualToString:LLNavigationBarSeparatorStyleShadow]) {
        self.barBackgroundView.layer.shadowColor = self.separatorColor.CGColor;
        self.barBackgroundView.layer.shadowOffset = CGSizeMake(0, 3);
        self.barBackgroundView.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44+[self statusBarHeight])].CGPath;
        self.barBackgroundView.layer.shadowRadius = 3;
        self.barBackgroundView.layer.shadowOpacity = 0.7;
    }else {
        self.barBackgroundView.layer.shadowColor = [UIColor clearColor].CGColor;
        self.barBackgroundView.layer.shadowOffset = CGSizeMake(0, 0);
        self.barBackgroundView.layer.shadowRadius = 0;
        self.barBackgroundView.layer.shadowOpacity = 0;
    }
    
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.backgroundColor_ = backgroundColor;
    self.barBackgroundView.backgroundColor = backgroundColor;
    self.barBackgroundView.image = nil;
    self.blurView.hidden = YES;
}
- (UIColor *)backgroundColor {
    return self.backgroundColor_;
}
- (void)setBackgroundImage:(UIImage *)backgroundImage {
    self.barBackgroundView.image = backgroundImage;
    self.barBackgroundView.backgroundColor = nil;
    self.blurView.hidden = YES;
}
- (void)construct {
    if (self.barBackgroundView) {
        return;
    }
    self.barBackgroundView = [[UIImageView alloc] init];
    [self addSubview:self.barBackgroundView];
    self.barBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    self.barBackgroundView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:0.8];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.barBackgroundView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.barBackgroundView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.barBackgroundView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.barBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.barBackgroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:44+[self statusBarHeight]]];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
    [self addSubview:self.blurView];
    self.blurView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.blurView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.barBackgroundView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.blurView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.barBackgroundView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.blurView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.barBackgroundView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.blurView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.barBackgroundView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    self.barContentView = [UIView new];
    [self addSubview:self.barContentView];
    self.barContentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.barContentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.barContentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.barContentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.barContentView addConstraint:[NSLayoutConstraint constraintWithItem:self.barContentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:44]];
    
    LLNavigationItemView *leftItem = [LLNavigationItemView sideItemView];
    [self.barContentView addSubview:leftItem];
    leftItem.translatesAutoresizingMaskIntoConstraints = NO;
    [self.barContentView addConstraint:[NSLayoutConstraint constraintWithItem:leftItem attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.barContentView attribute:NSLayoutAttributeLeft multiplier:1 constant:8]];
    [self.barContentView addConstraint:[NSLayoutConstraint constraintWithItem:leftItem attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.barContentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    LLNavigationItemView *titleItem = [LLNavigationItemView titleItemView];
    [self.barContentView addSubview:titleItem];
    titleItem.translatesAutoresizingMaskIntoConstraints = NO;
    [self.barContentView addConstraint:[NSLayoutConstraint constraintWithItem:titleItem attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.barContentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.barContentView addConstraint:[NSLayoutConstraint constraintWithItem:titleItem attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.barContentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self.barContentView addConstraint:[NSLayoutConstraint constraintWithItem:titleItem attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:leftItem attribute:NSLayoutAttributeRight multiplier:1 constant:11]];
    
    LLNavigationItemView *rightItem = [LLNavigationItemView sideItemView];
    [self.barContentView addSubview:rightItem];
    rightItem.translatesAutoresizingMaskIntoConstraints = NO;
    [self.barContentView addConstraint:[NSLayoutConstraint constraintWithItem:rightItem attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.barContentView attribute:NSLayoutAttributeRight multiplier:1 constant:-8]];
    [self.barContentView addConstraint:[NSLayoutConstraint constraintWithItem:rightItem attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.barContentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self.barContentView addConstraint:[NSLayoutConstraint constraintWithItem:rightItem attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:titleItem attribute:NSLayoutAttributeRight multiplier:1 constant:11]];
    
    self.borderLine = [UIView new];
    [self addSubview:self.borderLine];
    self.borderLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.borderLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.borderLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.borderLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.borderLine addConstraint:[NSLayoutConstraint constraintWithItem:self.borderLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0.7]];
    
    self.defaultTitleView = titleItem;
    self.defaultLeftView = leftItem;
    self.defaultRightView = rightItem;
}

- (void)applyConstraint {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1 constant:[self statusBarHeight]]];
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:44]];
    
}
- (CGFloat)statusBarHeight {
    if (@available(iOS 11.0, *)) {
        if ([UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom > 0) {
            return 44;
        }
    }
    return 20;
}
- (void)setTitle:(NSString *)title {
    self.defaultTitleView.title = title;
}
- (void)setSubTitle:(NSString *)subTitle {
    self.defaultTitleView.subTitle = subTitle;
}
-(void)setLeftItemTitle:(NSString *)leftItemTitle {
    self.defaultLeftView.title = leftItemTitle;
}
- (void)setLeftItemImage:(UIImage *)leftItemImage {
    self.defaultLeftView.image = leftItemImage;
}
- (void)setRightItemTitle:(NSString *)rightItemTitle {
    self.defaultRightView.title = rightItemTitle;
}
- (void)setRightItemImage:(UIImage *)rightItemImage {
    self.defaultRightView.image = rightItemImage;
}
- (void)setTitleView:(UIView *)titleView {
    [self.defaultTitleView setTitleView:titleView];
}
- (void)setLeftView:(UIView *)leftView {
    [self.defaultLeftView setSideItemView:leftView];
}
- (void)setRightView:(UIView *)rightView {
    [self.defaultRightView setSideItemView:rightView];
}
- (void)setLeftItemTextColor:(UIColor *)color forState:(UIControlState)state {
    [self.defaultLeftView setTextColor:color forState:state];
}
- (void)setLeftItemTextFont:(UIFont *)font {
    [self.defaultLeftView setTextFont:font];
}
- (void)setRightItemTextColor:(UIColor *)color forState:(UIControlState)state {
    [self.defaultRightView setTextColor:color forState:state];
}
- (void)setRightItemTextFont:(UIFont *)font {
    [self.defaultRightView setTextFont:font];
}
- (void)setTitleFont:(UIFont *)titleFont {
    self.defaultTitleView.titleFont = titleFont;
}
- (void)setTitleColor:(UIColor *)titleColor {
    self.defaultTitleView.titleColor = titleColor;
}
- (void)setSubTitleFont:(UIFont *)subTitleFont {
    self.defaultTitleView.subTitleFont = subTitleFont;
}
- (void)setSubTitleColor:(UIColor *)subTitleColor {
    self.defaultTitleView.subTitleColor = subTitleColor;
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
        bar = [LLNavigationBar new];
        [self setNavigationBar:bar];
    }
    if ([LLNavigationHelper instanceClass:self isEqualTo:[LLNavigationComponent contributeViewController]]) {
        return bar;
    }
    return nil;
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


@end
