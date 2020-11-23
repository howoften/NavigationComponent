//
//  LLNavigationItemView.m
//  NavigationComponent
//
//  Created by liujiang on 2020/10/26.
//  Copyright © 2020 Liujiang. All rights reserved.
//

#import "LLNavigationItemView.h"

@interface LLNavigationItemView()
@property (nonatomic)BOOL isTitleView;
@property (nonatomic, strong)UIView *titleContentView;
@property (nonatomic, weak)UILabel *titleLabel;
@property (nonatomic, weak)UILabel *subTitleLabel;
@property (nonatomic, weak)UIButton *sideButton;
@end
@implementation LLNavigationItemView
+ (instancetype)titleItemView {
    LLNavigationItemView *view = [LLNavigationItemView new];
    view.isTitleView = YES;
    UIView *contentView = [UIView new];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:contentView];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:[UIScreen mainScreen].bounds.size.width*0.85]];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
    [contentView addSubview:titleLabel];
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    constraint.priority = UILayoutPriorityDefaultLow;
    [contentView addConstraint:constraint];
    
    UILabel *subTitleLabel = [[UILabel alloc] init];
    subTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    subTitleLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
    [contentView addSubview:subTitleLabel];
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:subTitleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:titleLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:3]];
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:subTitleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:subTitleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    NSLayoutConstraint *sconstraint = [NSLayoutConstraint constraintWithItem:subTitleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    sconstraint.priority = UILayoutPriorityDefaultLow;
    [contentView addConstraint:sconstraint];
    
    
    view.titleContentView = contentView;
    view.titleLabel = titleLabel;
    view.subTitleLabel = subTitleLabel;
    return view;
}

+ (instancetype)sideItemView {
    LLNavigationItemView *view = [LLNavigationItemView new];
    view.isTitleView = NO;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view addSubview:btn];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [view addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:[UIScreen mainScreen].bounds.size.width*0.38]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:44]];
        [btn setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    view.sideButton = btn;
    return view;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self.sideButton setTitle:title forState:UIControlStateNormal];
}

- (void)setSubTitle:(NSString *)subTitle {
    if ([subTitle isKindOfClass:[NSString class]] && subTitle.length > 0) {
        self.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
        self.subTitleLabel.text = subTitle;
    }else {
        self.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
        self.subTitleLabel.text = nil;
    }
}
- (void)setImage:(UIImage *)image {
    [self.sideButton setImage:image forState:UIControlStateNormal];
}
- (void)setTitleView:(UIView *)view {
    if (self.isTitleView) {
        for (UIView *sub in self.titleContentView.subviews) {
            [sub removeFromSuperview];
        }
        [self.titleContentView addSubview:view];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.titleContentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleContentView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [self.titleContentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.titleContentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        [self.titleContentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.titleContentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [self.titleContentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.titleContentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    }
}
- (void)setSideItemView:(UIView *)view {
    if (!self.isTitleView) {
        [self.sideButton removeFromSuperview];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:view];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:[UIScreen mainScreen].bounds.size.width*0.38]];
    }
}

- (void)setTextColor:(UIColor *)color forState:(UIControlState)state {
    [self.sideButton setTitleColor:color forState:state];
}
- (void)setTextFont:(UIFont *)font {
    self.sideButton.titleLabel.font = font;
}
- (void)setTitleFont:(UIFont *)titleFont {
    self.titleLabel.font = titleFont;
}
- (void)setTitleColor:(UIColor *)titleColor {
    self.titleLabel.textColor = titleColor;
}
- (void)setSubTitleFont:(UIFont *)subTitleFont {
    self.subTitleLabel.font = subTitleFont;
}
- (void)setSubTitleColor:(UIColor *)subTitleColor {
    self.subTitleLabel.textColor = subTitleColor;
}
- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    if (self.sideButton) {
//        if (self.sideButton.titleLabel.text.length > 0 || self.sideButton.imageView.image.size.width > 0)
        [self.sideButton addTarget:target action:action forControlEvents:controlEvents];
    }
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(10, 10);
}
@end
