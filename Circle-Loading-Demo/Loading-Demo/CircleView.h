//
//  CircleView.h
//  Loading-Demo
//
//  Created by 王潇 on 2021/7/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleView : UIView

- (instancetype)initWithFrame:(CGRect)frame lineWidth:(float)lineWidth;

@property (assign, nonatomic) CGFloat progress;

@property (assign, nonatomic) CGFloat lineWidth;

@end

NS_ASSUME_NONNULL_END
