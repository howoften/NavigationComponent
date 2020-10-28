//
//  LLNavigationComponent.h
//  NavigationComponent
//
//  Created by 刘江 on 2019/11/30.
//  Copyright © 2019 Liujiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLNavigationPublic-Header.h"
@interface LLNavigationComponent : NSObject<LLNavigationActionProtocol>
+ (void)contributeForViewController:(Class _Nonnull __unsafe_unretained)viewController navigationController:(Class _Nonnull __unsafe_unretained)navigationController;

//一下方法在 base-navigationcontroller  - viewDidLoad中调用
//可选
+ (void)enablePopGestureRecongnizerAndProhibitRootViewControllerPopAction:(UINavigationController *_Nonnull)navigationController;
//必须
+ (void)prohibitRootViewControllerPopAction:(UINavigationController *_Nonnull)navigationController;

@end
