//
//  LLNavigationInteractivePop.h
//  NavigationComponent
//
//  Created by 刘江 on 2019/12/3.
//  Copyright © 2019 Liujiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
NS_ASSUME_NONNULL_BEGIN

@interface LLNavigationInteractivePop : NSObject
+ (void)navigationController:(UINavigationController *)navigationController enablePopGesture:(BOOL)enable;

@end

NS_ASSUME_NONNULL_END
