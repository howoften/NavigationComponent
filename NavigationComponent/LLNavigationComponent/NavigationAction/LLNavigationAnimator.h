//
//  LLNavigationAnimator.h
//  NavigationComponent
//
//  Created by 刘江 on 2019/12/2.
//  Copyright © 2019 Liujiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
NS_ASSUME_NONNULL_BEGIN

@interface LLNavigationAnimator : NSObject<UIViewControllerAnimatedTransitioning>
+ (instancetype)popAnimator;
+ (instancetype)pushAnimator;
@end

NS_ASSUME_NONNULL_END
