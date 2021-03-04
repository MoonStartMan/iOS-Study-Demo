//
//  FirstResponderView.m
//  UIResponder-Demo
//
//  Created by 王潇 on 2021/3/3.
//

#import "FirstResponderView.h"

@implementation FirstResponderView

/** 演示设置为第一响应者 */
- (void)setBecomeFirstResponder {
    //  判断对象是否已经是第一响应者
    if ([self isFirstResponder]) {
        return;
    }
    //  判断对象是否允许成为第一响应者
    if ([self canBecomeFirstResponder]) {
        //  设置第一响应者
        [self becomeFirstResponder];
    }
}

/** 演示放弃第一响应者 */
- (void)setResignFirstResponder {
    //  判断对象是否不是第一响应者
    if (![self isFirstResponder]) {
        return;
    }
    //  判断对象是否允许放弃第一响应者
    if ([self canResignFirstResponder]) {
        //  设置放弃第一响应者
        [self resignFirstResponder];
    }
}

/** 重写方法,允许对象成为第一响应者 */
- (BOOL)canBecomeFirstResponder {
    return YES;
}

/** 手指按下时响应 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"--->手指按下时响应");
}

/** 手指移动时响应 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    NSLog(@"--->手指移动时响应");
}

/** 手指抬起时响应 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    NSLog(@"--->手指抬起时响应");
}

/** 触摸取消(意外中断，如:电话，Home键退出等) */
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    NSLog(@"--->取消触摸响应");
}

/** 开始加速 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [super motionBegan:motion withEvent:event];
    NSLog(@"--->开始加速");
}

/** 结束加速 */
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [super motionEnded:motion withEvent:event];
    NSLog(@"--->结束加速");
}

/** 加速取消 (取消中断, 如:电话,Home键退出等) */
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [super motionCancelled:motion withEvent:event];
    NSLog(@"--->加速取消");
}



@end
