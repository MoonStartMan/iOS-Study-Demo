//
//  RollLoadingView.m
//  CAShapeLayer
//
//  Created by 王潇 on 2020/12/21.
//

#import "RollLoadingView.h"

@implementation RollLoadingView

static RollLoadingView* _ShowLoadingView;

static BOOL _IsShow;

- (instancetype)CreateLoadingView {
    
    RollLoadingView* view = [[RollLoadingView alloc] initWithFrame:CGRectMake((ScreenWidth - RollViewWH)/2, ScreenHeight / 2 - RollViewHeight / 2, RollViewWH, RollViewHeight)];
    
    [view addSubview:self.ProgressLabel];
    
    [view addSubview:view.rollView];
    
    [view InitLayer];
    
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    
    self = [super initWithCoder:coder];
    
    return self;
}

+ (void)Show {
    _IsShow = YES;
    
    RollLoadingView* loadingView = [[RollLoadingView alloc] CreateLoadingView];
    
    UIWindow* keyWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    
    [keyWindow addSubview: loadingView];
    
    _ShowLoadingView = loadingView;
}

+ (void)ShowInView:(UIView *)view{
    _IsShow = YES;
    
    RollLoadingView* loadingView = [[RollLoadingView alloc] CreateLoadingView];
    
    [view addSubview: loadingView];
    
    _ShowLoadingView = loadingView;
}

//  release
+ (void)Dismiss {
    //  去除
    if (_IsShow) {
        _IsShow = NO;
        
        [_ShowLoadingView removeFromSuperview];
        
        _ShowLoadingView = nil;
    }
}

- (void)HasSettingDuration {
    //  开启定时
    if (self.Duration != 0 && self.Duration != DefaultDuration) {
        [self AfterExecution:self.Duration WithOperation:^{
            [RollLoadingView Dismiss];
        }];
    } else {
        //  三秒自动消失
        [self AfterExecution:DefaultDuration WithOperation:^{
            [RollLoadingView Dismiss];
        }];
    }
}

- (void)AfterExecution: (CGFloat)delay WithOperation: (void (^)(void))completion {
    dispatch_time_t after = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    
    dispatch_after(after, dispatch_get_main_queue(), ^{
        completion();
    });
}

- (UILabel *)ProgressLabel {
    
    if(!_ProgressLabel) {
        
        CGFloat y = self.rollView.frame.origin.y + RollViewRadius * 2 +20;
        
        _ProgressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, RollViewWH, ProgressLabelHeight)];
        
        _ProgressLabel.text = @"正在加载...";
        
        [_ProgressLabel setValue:[UIColor lightGrayColor] forKey:@"textColor"];
        
        _ProgressLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _ProgressLabel;
    
}

- (UIView *)rollView {
    
    if(!_rollView) {
        _rollView = [[UIView alloc] initWithFrame:self.bounds];
        _rollView.backgroundColor = [UIColor colorWithRed:100/255 green:100/255 blue:100/255 alpha:1];
    }
    
    return _rollView;
}

- (void)StartAnimation {
    //  定义四个路径
    //  左半圆
    
    //{{{47.123889803846893, 60}, {30, 2}} {{47.123889803846893, 60}, {30, 0}}
}

- (void)InitLayer {
    CGPoint CircleCenter = CGPointMake(self.rollView.frame.size.width / 2, self.rollView.frame.size.height / 2);
    //(47.123890,47.123890)
    UIBezierPath *CircleLeft = [UIBezierPath bezierPath];
    [CircleLeft addArcWithCenter:CircleCenter radius:RollViewRadius startAngle:M_PI_2 endAngle:M_PI_2 + M_PI clockwise:YES];
    CAShapeLayer* CircleLeftLayer = [CAShapeLayer layer];
    CircleLeftLayer.path = CircleLeft.CGPath;
    CircleLeftLayer.strokeColor = [[UIColor lightGrayColor] CGColor];
    CircleLeftLayer.fillColor = [[UIColor clearColor] CGColor];
    //{17.123889803846893, 0}, {30, 60}
    //  右半圆
    UIBezierPath* CircleRight = [UIBezierPath bezierPath];
    [CircleRight addArcWithCenter:CircleCenter radius:RollViewRadius startAngle:M_PI_2 endAngle:-M_PI_2 clockwise:NO];
    CAShapeLayer* CircleRightLayer = [CAShapeLayer layer];
    CircleRightLayer.path = CircleRight.CGPath;
    CircleRightLayer.strokeColor = [[UIColor lightGrayColor] CGColor];
    CircleRightLayer.fillColor = [[UIColor clearColor] CGColor];
    //{17.123889803846893, 0}, {30, 60}
    //  左直线
    CGFloat LineY = 2 * RollViewRadius;
    CGFloat LineX = CircleLeft.bounds.origin.x + RollViewRadius;
    
    CGPoint LineStartPoint = CGPointMake(LineX, LineY);
    
    UIBezierPath* LineLeft = [UIBezierPath bezierPath];
    [LineLeft moveToPoint:CGPointMake(LineX - 1.5 * RollViewRadius, LineY)];
    [LineLeft addLineToPoint:LineStartPoint];
    CAShapeLayer *LineLeftLayer = [CAShapeLayer layer];
    LineLeftLayer.path = LineLeft.CGPath;
    LineLeftLayer.strokeColor = [[UIColor lightGrayColor] CGColor];
    //{17.123889803846893, 60}, {30, 2}}  {{17.123889803846893, 60}, {30, 0}}
    NSLog(@"path is %@", NSStringFromCGRect(LineLeft.bounds));
    //  右直线
    UIBezierPath *LineRight = [UIBezierPath bezierPath];
    [LineRight moveToPoint:CGPointMake(LineX + 1.5 * RollViewRadius, LineY)];
    LineRight.lineWidth = 2;
    [LineRight addLineToPoint:LineStartPoint];
    CAShapeLayer *LineRightLayer = [CAShapeLayer layer];
    LineRightLayer.path = LineRight.CGPath;
    LineRightLayer.strokeColor = [[UIColor lightGrayColor] CGColor];
    NSLog(@"Rightpath is %@", NSStringFromCGRect(LineRight.bounds));
    
    [self InitAnimation:CircleLeftLayer ForKey:@"CircleLeft"];
    [self InitAnimation:CircleRightLayer ForKey:@"CircleRight"];
    [self InitAnimation:LineLeftLayer ForKey:@"LineLeft"];
    [self InitAnimation:LineRightLayer ForKey:@"LineRight"];
    
    [self.rollView.layer addSublayer:CircleRightLayer];
    [self.rollView.layer addSublayer:CircleLeftLayer];
    [self.rollView.layer addSublayer:LineRightLayer];
    [self.rollView.layer addSublayer:LineLeftLayer];
}

- (void)InitAnimation:(CAShapeLayer*)layer ForKey:(NSString*)key{
    //设置动画
    //颜色渐变
    CABasicAnimation* GraduallyColorAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    GraduallyColorAnimation.toValue = (__bridge id _Nullable)([[UIColor greenColor] CGColor]);
    GraduallyColorAnimation.fromValue = (__bridge id _Nullable)([[UIColor lightGrayColor] CGColor]);
    GraduallyColorAnimation.duration = DefaultDuration / 2;
    GraduallyColorAnimation.repeatCount = CGFLOAT_MAX;
    GraduallyColorAnimation.autoreverses = YES;
    GraduallyColorAnimation.removedOnCompletion = NO;
    [layer addAnimation:GraduallyColorAnimation forKey:@"changeColor"];
    //左半圆动画
    if([key isEqualToString:@"CircleLeft"]){
        CABasicAnimation* CircleLeftAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        CircleLeftAnimation.toValue = [NSNumber numberWithFloat:1];
        CircleLeftAnimation.fromValue = [NSNumber numberWithInt:0];
        CircleLeftAnimation.repeatCount = CGFLOAT_MAX;
        CircleLeftAnimation.removedOnCompletion = NO;
        CircleLeftAnimation.duration = DefaultDuration / 2;
        CircleLeftAnimation.autoreverses = YES;
        [layer addAnimation:CircleLeftAnimation forKey:@"CircleLeft"];
    }else if ([key isEqualToString:@"CircleRight"]){
        //右半圆动画
        CABasicAnimation* CircleRightAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        CircleRightAnimation.toValue = [NSNumber numberWithFloat:1];
        CircleRightAnimation.fromValue = [NSNumber numberWithInt:0];
        CircleRightAnimation.repeatCount = CGFLOAT_MAX;
        CircleRightAnimation.removedOnCompletion = NO;
        CircleRightAnimation.autoreverses = YES;
        CircleRightAnimation.duration = DefaultDuration / 2;
        [layer addAnimation:CircleRightAnimation forKey:@"CircleRight"];
    }else if([key isEqualToString:@"LineLeft"]){
        //左直线动画
        CABasicAnimation* LineLeftAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        LineLeftAnimation.toValue = [NSNumber numberWithFloat:1];
        LineLeftAnimation.repeatCount = CGFLOAT_MAX;
        LineLeftAnimation.removedOnCompletion = NO;
        LineLeftAnimation.autoreverses = YES;
        LineLeftAnimation.duration = DefaultDuration / 2;
        [layer addAnimation:LineLeftAnimation forKey:@"LineLeft"];
    }else{        //右直线动画
        CABasicAnimation* LineRightAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        LineRightAnimation.toValue = [NSNumber numberWithFloat:1];
        LineRightAnimation.repeatCount = CGFLOAT_MAX;
        LineRightAnimation.removedOnCompletion = NO;
        LineRightAnimation.autoreverses = YES;
        LineRightAnimation.duration = DefaultDuration / 2;
        [layer addAnimation:LineRightAnimation forKey:@"LineRight"];
    }
}

- (void)EatAnimation{
    
    UIBezierPath* Despath = [UIBezierPath bezierPath];
    
    [Despath addArcWithCenter:self.rollView.center radius:self.rollView.bounds.size.width / 2 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    //Change Path
    UIBezierPath* maskpath = [UIBezierPath bezierPath];
    [maskpath addArcWithCenter:self.rollView.center radius:RollViewWH / 2 startAngle:M_PI_4 endAngle:M_PI + M_PI_2 + M_PI_4 clockwise:YES];
    //mask
    CAShapeLayer* mask = [CAShapeLayer layer];
    mask.frame = self.rollView.bounds;
    mask.path = maskpath.CGPath;
    //eatAnimation
    CABasicAnimation* eatAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    
    
    //    CAKeyframeAnimation* eatAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //Forerver
    eatAnimation.fromValue = (__bridge id _Nullable)(maskpath.CGPath);
    eatAnimation.toValue = (__bridge id _Nullable)(Despath.CGPath);
    eatAnimation.repeatCount = CGFLOAT_MAX;
    //time
    eatAnimation.duration = 0.5f;
    eatAnimation.removedOnCompletion = NO;
    
    //MoveAnimation
    CABasicAnimation* moveAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    moveAnimation.fromValue = [NSNumber numberWithFloat:mask.frame.origin.x];
    moveAnimation.toValue = [NSNumber numberWithFloat:ScreenWidth - mask.frame.size.width / 2];
    moveAnimation.repeatCount = 1;
    moveAnimation.autoreverses = NO;
    moveAnimation.duration = DefaultDuration;
    moveAnimation.removedOnCompletion = NO;
    //设置结束状态，一直保持结束的状态
    moveAnimation.fillMode = kCAFillModeForwards;
    
    //HasShowProgress
    self.rollView.layer.mask = mask;
    
    if(self.HasShowProgress){
        [mask addAnimation:eatAnimation forKey:@"eat"];
    }else{
        //        [self.pacman.layer addAnimation:moveAnimation forKey:@"move"];
        //        [mask addAnimation:eatAnimation forKey:@"eat"];
    }
    
}

@end
