//
//  LLNavigationBar.h
//  WXCitizenCard
//
//  Created by 刘江 on 2018/8/4.
//  Copyright © 2018年 Liujiang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NSString * LLNavigationBarSeparatorStyleKey;
extern LLNavigationBarSeparatorStyleKey const LLNavigationBarSeparatorStyleNone;
extern LLNavigationBarSeparatorStyleKey const LLNavigationBarSeparatorStyleLine;
extern LLNavigationBarSeparatorStyleKey const LLNavigationBarSeparatorStyleShadow;

@interface LLNavigationBar : UIView
@property (nonatomic, copy)LLNavigationBarSeparatorStyleKey separatorStyle;
@property (nonatomic, strong)UIColor *separatorColor;
@property (nonatomic, strong)UIImage *backgroundImage;

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *subTitle;
@property (nonatomic, copy)NSString *leftItemTitle;
@property (nonatomic, strong)UIImage *leftItemImage;
@property (nonatomic, copy)NSString *rightItemTitle;
@property (nonatomic, strong)UIImage *rightItemImage;

@property (nonatomic, strong)UIView *titleView;
@property (nonatomic, strong)UIView *leftView;
@property (nonatomic, strong)UIView *rightView;

@property (nonatomic, strong)UIFont *titleFont;
@property (nonatomic, strong)UIColor *titleColor;
@property (nonatomic, strong)UIFont *subTitleFont;
@property (nonatomic, strong)UIColor *subTitleColor;

- (void)setLeftItemTextColor:(UIColor *)color forState:(UIControlState)state;
- (void)setLeftItemTextFont:(UIFont *)font;
- (void)setRightItemTextColor:(UIColor *)color forState:(UIControlState)state;
- (void)setRightItemTextFont:(UIFont *)font;

- (void)addLeftViewTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
- (void)addRightViewTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end

