//
//  LLNavigationItem.m
//  NavigationComponent
//
//  Created by liujiang on 2020/10/21.
//  Copyright © 2020 Liujiang. All rights reserved.
//

#import "LLNavigationItem.h"
#import "LLNavigationBar.h"
@interface LLNavigationItem()

@end

@implementation LLNavigationItem
//static  int updateFlag = 0;
- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    self.navigationBar.title = title;
//    if (!self.navigationBar) {
//        updateFlag++;
//    }
}
- (void)setTitleView:(UIView *)titleView {
    [super setTitleView:titleView];
    self.navigationBar.titleView = titleView;
//    if (!self.navigationBar) {
//        updateFlag++;
//    }
}
- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    self.navigationBar.subTitle = subTitle;
}
- (void)setLeftItemTitle:(NSString *)leftItemTitle {
    _leftItemTitle = leftItemTitle;
    self.navigationBar.leftItemTitle = leftItemTitle;
}
- (void)setLeftItemImage:(UIImage *)leftItemImage {
    _leftItemImage = leftItemImage;
    self.navigationBar.leftItemImage = leftItemImage;
}
- (void)setRightItemTitle:(NSString *)rightItemTitle {
    _rightItemTitle = rightItemTitle;
    self.navigationBar.rightItemTitle = rightItemTitle;
}
- (void)setRightItemImage:(UIImage *)rightItemImage {
    _rightItemImage = rightItemImage;
    self.navigationBar.rightItemImage = rightItemImage;
}
- (void)setLeftView:(UIView *)leftView {
    _leftView = leftView;
    _leftItemTitle = nil;
    _leftItemImage = nil;
    _leftItemTextColor = nil;
    _leftItemFont = nil;
    self.navigationBar.leftView = leftView;
}
- (void)setRightView:(UIView *)rightView {
    _rightView = rightView;
    _rightItemTitle = nil;
    _rightItemImage = nil;
    _rightItemFont = nil;
    _rightItemTextColor = nil;
    self.navigationBar.rightView = rightView;
}
- (void)setLeftItemTextColor:(UIColor *)color {
    _leftItemTextColor = color;
    [self.navigationBar setLeftItemTextColor:color forState:UIControlStateNormal];
}
- (void)setLeftItemFont:(UIFont *)font {
    _leftItemFont = font;
    [self.navigationBar setLeftItemTextFont:font];
}
- (void)setRightItemTextColor:(UIColor *)color {
    _rightItemTextColor = color;
    [self.navigationBar setRightItemTextColor:color forState:UIControlStateNormal];
}
- (void)setRightItemFont:(UIFont *)font {
    _rightItemFont = font;
    [self.navigationBar setRightItemTextFont:font];
}
- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    self.navigationBar.titleFont = titleFont;
}
- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.navigationBar.titleColor = titleColor;
}
- (void)setSubTitleFont:(UIFont *)subTitleFont {
    _subTitleFont = subTitleFont;
    self.navigationBar.subTitleFont = subTitleFont;
}
- (void)setSubTitleColor:(UIColor *)subTitleColor {
    _subTitleColor = subTitleColor;
    self.navigationBar.subTitleColor = subTitleColor;
    
}


- (void)setNavigationBar:(LLNavigationBar *)navigationBar {
    if (![navigationBar isKindOfClass:[LLNavigationBar class]]) {
        return;
    }

    LLNavigationBar *previous = _navigationBar;
    _navigationBar = navigationBar;
    if (previous) {
        return;
    }
    self.title = self.title;
    self.subTitle = self.subTitle;
    self.leftItemTitle = self.leftItemTitle;
    self.leftItemImage = self.leftItemImage;
    self.rightItemTitle = self.rightItemTitle;
    self.rightItemImage = self.rightItemImage;
    if (self.titleFont) {
        self.titleFont = self.titleFont;
    }
    if (self.titleColor) {
        self.titleColor = self.titleColor;
    }
    if (self.subTitleFont) {
        self.subTitleFont= self.subTitleFont;
    }
    if (self.subTitleColor) {
        self.subTitleColor = self.subTitleColor;
    }
    if (self.leftView) {
        self.leftView = self.leftView;
    }
    if (self.titleView) {
        self.titleView = self.titleView;
    }
    if (self.rightView) {
        self.rightView = self.rightView;
    }
    if (self.leftItemFont) {
        [self.navigationBar setLeftItemTextFont:self.leftItemFont];
    }
    if (self.leftItemTextColor) {
        [self.navigationBar setLeftItemTextColor:self.leftItemTextColor forState:UIControlStateNormal];
    }
    if (self.rightItemFont) {
        [self.navigationBar setRightItemTextFont:self.rightItemFont];
    }
    if (self.rightItemTextColor) {
        [self.navigationBar setRightItemTextColor:self.rightItemTextColor forState:UIControlStateNormal];
    }
    
    
}
@end

#import <objc/runtime.h>
@implementation UIViewController(navigationItem_t)
- (void)setNavigationItem_t:(LLNavigationItem *)navigationItem_t {
    objc_setAssociatedObject(self, @selector(navigationItem_t), navigationItem_t, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LLNavigationItem *)navigationItem_t {
    return objc_getAssociatedObject(self, @selector(navigationItem_t));
}

@end
