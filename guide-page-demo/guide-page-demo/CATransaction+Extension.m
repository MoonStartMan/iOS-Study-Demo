//
//  CATransaction+Extension.m
//  guide-page-demo
//
//  Created by 王潇 on 2021/3/17.
//

#import "CATransaction+Extension.h"

@implementation CATransaction (Extension)

+ (void)performWithoutAnimation:(void (^)(void))actionsWithoutAnimation {
    [self begin];
    [self setValue:@(true) forKey:kCATransactionDisableActions];
    actionsWithoutAnimation ?: actionsWithoutAnimation();
    [self commit];
}

@end
