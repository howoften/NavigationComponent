//
//  LLNavigationHelper.h
//  NavigationComponent
//
//  Created by 刘江 on 2019/12/1.
//  Copyright © 2019 Liujiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LLNavigationHelper : NSObject
+ (UIViewController *)topViewController;
+ (UIImage *)shotWithView:(UIView *)view;
+ (UIImage *)shotWithView:(UIView *)view scope:(CGRect)scope;
@end
