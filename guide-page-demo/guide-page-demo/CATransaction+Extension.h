//
//  CATransaction+Extension.h
//  guide-page-demo
//
//  Created by 王潇 on 2021/3/17.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CATransaction (Extension)

+ (void)performWithoutAnimation:(void (^)(void))actionsWithoutAnimation;

@end

NS_ASSUME_NONNULL_END
