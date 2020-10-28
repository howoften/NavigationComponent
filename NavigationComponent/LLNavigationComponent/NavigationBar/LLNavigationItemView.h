//
//  LLNavigationItemView.h
//  NavigationComponent
//
//  Created by liujiang on 2020/10/26.
//  Copyright © 2020 Liujiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLNavigationItemView : UIView
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *subTitle;
@property (nonatomic, strong)UIImage *image;

@property (nonatomic, strong)UIFont *titleFont;
@property (nonatomic, strong)UIColor *titleColor;
@property (nonatomic, strong)UIFont *subTitleFont;
@property (nonatomic, strong)UIColor *subTitleColor;

+ (instancetype)titleItemView;
+ (instancetype)sideItemView;
- (void)setTitleView:(UIView *)view;
- (void)setSideItemView:(UIView *)view;
- (void)setTextColor:(UIColor *)color forState:(UIControlState)state;
- (void)setTextFont:(UIFont *)font;

@end

