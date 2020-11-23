//
//  LLNavigationItem.h
//  NavigationComponent
//
//  Created by liujiang on 2020/10/21.
//  Copyright © 2020 Liujiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLNavigationBar;
@interface LLNavigationItem : UINavigationItem
@property (nonatomic, weak)UIViewController *viewController;
@property (nonatomic, weak)LLNavigationBar *navigationBar;

@property (nonatomic, copy)NSString *subTitle;
@property (nonatomic, copy)NSString *leftItemTitle;
@property (nonatomic, strong)UIImage *leftItemImage;
@property (nonatomic, copy)NSString *rightItemTitle;
@property (nonatomic, strong)UIImage *rightItemImage;

@property (nonatomic, strong)UIView *leftView;
@property (nonatomic, strong)UIView *rightView;

@property (nonatomic, strong)UIFont *titleFont;
@property (nonatomic, strong)UIColor *titleColor;
@property (nonatomic, strong)UIFont *subTitleFont;
@property (nonatomic, strong)UIColor *subTitleColor;
@property (nonatomic, strong)UIFont *leftItemFont;
@property (nonatomic, strong)UIColor *leftItemTextColor;
@property (nonatomic, strong)UIFont *rightItemFont;
@property (nonatomic, strong)UIColor *rightItemTextColor;

- (void)addLeftViewTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
- (void)addRightViewTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end

@interface UIViewController(navigationItem_t)
@property (nonatomic, strong)LLNavigationItem *navigationItem_t;
@end
