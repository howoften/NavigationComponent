//
//  LLNavigationBar.h
//  WXCitizenCard
//
//  Created by 刘江 on 2018/8/4.
//  Copyright © 2018年 Liujiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LLNavigationBar : UIImageView
//only one property will be enabled
@property (nonatomic, assign)BOOL showNavigationBarShadow; //layer shadow, default is YES
@property (nonatomic, assign)BOOL showNavigationBarSeparator; //layer border, default is NO

@end

