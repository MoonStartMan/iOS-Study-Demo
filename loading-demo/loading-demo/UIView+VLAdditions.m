//
//  CATransaction+VLAdditions.m
//  loading-demo
//
//  Created by 王潇 on 2021/3/19.
//

#import "UIView+VLAdditions.h"

@implementation UIView(VLAdditions)

- (void)setX:(CGFloat)x {
    CGRect frame = CGRectMake(x, self.y, self.width, self.height);
    self.frame = frame;
}

- (CGFloat)x {
    return CGRectGetMinX(self.frame);
}

- (void)setY:(CGFloat)y {
    CGRect frame = CGRectMake(self.x, y, self.width, self.height);
    self.frame = frame;
}

- (CGFloat)y {
    return CGRectGetMinY(self.frame);
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = CGRectMake(self.x, self.y, width, self.height);
    self.frame = frame;
}

- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = CGRectMake(self.x, self.y, self.width, height);
    self.frame = frame;
}

- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

- (void)setSize:(CGSize)size {
    self.width = size.width;
    self.height = size.height;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin {
    self.x = origin.x;
    self.y = origin.y;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setTop:(CGFloat)top {
    self.y = top;
}

- (CGFloat)top {
    return self.y;
}

- (void)setBottom:(CGFloat)bottom {
    self.y = bottom - self.height;
}

- (CGFloat)bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setLeft:(CGFloat)left {
    self.x = left;
}

- (CGFloat)left {
    return self.x;
}

- (void)setRight:(CGFloat)right {
    self.x = right - self.width;
}

- (CGFloat)right {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)centerY {
    return self.y + self.height / 2.f;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)centerX {
    return self.x + self.width / 2.f;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

@end
