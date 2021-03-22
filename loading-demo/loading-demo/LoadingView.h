//
//  LoadingView.h
//  loading-demo
//
//  Created by 王潇 on 2021/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoadingView : UIView

/// 百分比数值
@property (nonatomic, assign) CGFloat progess;

/// 更新可动圆 百分比
- (void)updatePressPathStartVal:(CGFloat)startValue updatePressPathEndVal:(CGFloat)endValue;

@end

NS_ASSUME_NONNULL_END
