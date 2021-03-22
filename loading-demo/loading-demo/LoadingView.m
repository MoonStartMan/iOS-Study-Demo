//
//  LoadingView.m
//  loading-demo
//
//  Created by 王潇 on 2021/3/22.
//

#import "LoadingView.h"

@interface LoadingView()<CAAnimationDelegate>

//  固定的圆圈 Path
@property (nonatomic, strong) UIBezierPath *trackPath;
//  固定的圆圈 Layer
@property (nonatomic, strong) CAShapeLayer *trackLayer;
//  可动的圆圈 Path
@property (nonatomic, strong) UIBezierPath *progressPath;
//  可动的圆圈 Layer
@property (nonatomic, strong) CAShapeLayer *progressLayer;
//  路径动画
@property (nonatomic, strong) CABasicAnimation *pathAnimation;

//  画两个圆形
- (void)startProgressAction:(CGRect)mybound;

@end

@implementation LoadingView

- (instancetype) init{
    self = [super init];
    if (self) {
        self.pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        self.pathAnimation.delegate = self;
        [self setUI];
    }
    return self;
}

- (void)updatePressPathStartVal:(CGFloat)startValue updatePressPathEndVal:(CGFloat)endValue {
    //  总的过渡时间
    CGFloat totalDuration = 5.0;
    //  当前动画所需要的时间
    CGFloat currentDuration = 0.0;
    currentDuration = (endValue - startValue) * totalDuration;
    self.pathAnimation.duration = currentDuration;
    self.pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    self.pathAnimation.fromValue = [NSNumber numberWithFloat:startValue];
    self.pathAnimation.toValue = [NSNumber numberWithFloat:endValue];
    self.pathAnimation.fillMode = kCAFillModeBoth;
    self.pathAnimation.removedOnCompletion = NO;
    [self.progressLayer addAnimation:self.pathAnimation forKey:@"strokeEndAnimation"];
    self.progess = endValue;
}

#pragma mark - private Methods

- (void)setUI {
    [self startProgressAction:CGRectMake(0, 0, 50, 50)];
}

- (void)startProgressAction:(CGRect)mybound {
    //  固定的圆圈
    _trackPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:(mybound.size.width - 2) / 2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    _trackLayer = [CAShapeLayer new];
    [self.layer addSublayer:_trackLayer];
    _trackLayer.fillColor = nil;
    _trackLayer.strokeColor = [UIColor grayColor].CGColor;
    _trackLayer.path = _trackPath.CGPath;
    _trackLayer.lineWidth = 4;
    _trackLayer.frame = mybound;
    
    //  可动的圆圈
    _progressPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:(mybound.size.width - 2) / 2 startAngle:- M_PI_2 endAngle:(M_PI * 2) - M_PI_2 clockwise:YES];
    _progressLayer = [CAShapeLayer new];
    [self.layer addSublayer:_progressLayer];
    _progressLayer.fillColor = nil;
    _progressLayer.strokeColor = [UIColor redColor].CGColor;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.path = _progressPath.CGPath;
    _progressLayer.lineWidth = 4;
    _progressLayer.frame = mybound;
    _progressLayer.strokeEnd = 1;
    _progressLayer.strokeStart = 0;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.progess == 1) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
}

@end
