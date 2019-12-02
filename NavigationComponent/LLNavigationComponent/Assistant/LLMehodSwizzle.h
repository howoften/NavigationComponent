//
//  LLMehodSwizzle.h
//  NavigationComponent
//
//  Created by 刘江 on 2019/11/30.
//  Copyright © 2019 Liujiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLMehodSwizzle : NSObject
+ (void)swizzleForClass:(Class _Nonnull __unsafe_unretained)cls originSEL:(SEL _Nonnull)originSEL anotherClass:(Class _Nonnull __unsafe_unretained)aCls newSEL:(SEL _Nonnull)newSEL;

@end
