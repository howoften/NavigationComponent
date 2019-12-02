//
//  LLMehodSwizzle.m
//  NavigationComponent
//
//  Created by 刘江 on 2019/11/30.
//  Copyright © 2019 Liujiang. All rights reserved.
//

#import <objc/runtime.h>
#import "LLMehodSwizzle.h"

@implementation LLMehodSwizzle

+ (void)swizzleForClass:(Class _Nonnull __unsafe_unretained)cls originSEL:(SEL _Nonnull)originSEL anotherClass:(Class _Nonnull __unsafe_unretained)aCls newSEL:(SEL _Nonnull)newSEL {
            
            SEL originalSelector = originSEL;
            SEL swizzledSelector = newSEL;
            
            Method originalMethod = class_getInstanceMethod(cls, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(aCls, swizzledSelector);
            BOOL didAddMethod =
            class_addMethod(cls,
                            originalSelector,
                            method_getImplementation(swizzledMethod),
                            method_getTypeEncoding(swizzledMethod));
            
            if (didAddMethod) {
                class_replaceMethod(aCls,
                                                   swizzledSelector,
                                                   method_getImplementation(originalMethod),
                                                   method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }

}


@end
