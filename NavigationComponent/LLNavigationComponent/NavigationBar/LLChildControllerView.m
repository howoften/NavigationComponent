//
//  LLChildControllerView.m
//  NavigationComponent
//
//  Created by liujiang on 2020/10/26.
//  Copyright © 2020 Liujiang. All rights reserved.
//

#import "LLNavigationPublic-Header.h"
#import "LLChildControllerView.h"

@implementation LLChildControllerView
- (void)addSubview:(UIView *)view {
    [super addSubview:view];
    
    UIViewController *next = (UIViewController *)self.nextResponder;
    if ([next isKindOfClass:[UIViewController class]]) {
        [self bringSubviewToFront:next.navigationBar];
    }
}

@end
