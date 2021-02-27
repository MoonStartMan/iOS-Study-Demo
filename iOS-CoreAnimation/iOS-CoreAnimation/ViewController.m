//
//  ViewController.m
//  iOS-CoreAnimation
//
//  Created by 王潇 on 2021/2/27.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CALayer *redLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.redLayer = [CALayer layer];
    
    self.redLayer.bounds = CGRectMake(0, 0, 100, 100);
    
    self.redLayer.position = CGPointMake(100, 100);
    
    self.redLayer.backgroundColor = [UIColor redColor].CGColor;
    
    [self.view.layer addSublayer: self.redLayer];
    
}

//  基本动画，移动
- (void) test01 {
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 300)];
    
    basicAnimation.duration = 3;
    
    basicAnimation.removedOnCompletion = NO;
    
    basicAnimation.fillMode = kCAFillModeForwards;
    
    [self.redLayer addAnimation:basicAnimation forKey:nil];
}

//  基本动画，缩放
- (void) test02 {
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    //  缩小小于1，放大大于1
    basicAnimation.toValue = @0.5;
    
    basicAnimation.duration = 3;
    
    basicAnimation.removedOnCompletion = NO;
    
    basicAnimation.fillMode = kCAFillModeForwards;
    
    [self.redLayer addAnimation:basicAnimation forKey:nil];
}

//  基本动画,旋转
- (void) test03 {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    
    basicAnimation.toValue = @(M_PI * 2);
    
    basicAnimation.repeatCount = 10;
    
    basicAnimation.removedOnCompletion = NO;
    
    basicAnimation.fillMode = kCAFillModeForwards;
    
    [self.redLayer addAnimation:basicAnimation forKey:nil];
}

//  按指定路径走的动画
- (void) test04 {
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    keyAnimation.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 200, 200)].CGPath;
    
    keyAnimation.duration = 3;
    
    [self.redLayer addAnimation:keyAnimation forKey:nil];
}

//  抖动
- (void) test05 {
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    
    keyAnimation.values = @[@(-M_PI_4/4), @(M_PI_4/4), @(-M_PI_4/4)];
    
    keyAnimation.repeatCount = CGFLOAT_MAX;
    
    //  keyAnimation.duration = 0.25;   //  all animation's duration is 0.25
    
    [self.redLayer addAnimation:keyAnimation forKey:nil];
}

//  组动画:多个动画同时进行
- (void) test06 {
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    //  1.路径
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    pathAnimation.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 200, 200)].CGPath;
    
    //  2.旋转
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    
    rotationAnimation.byValue = @(M_PI * 2);
    
    //  3.缩放
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.toValue = @(0.5);
    
    animationGroup.animations = @[pathAnimation, rotationAnimation, scaleAnimation];
    
    animationGroup.duration = 3;
    
    animationGroup.repeatCount = CGFLOAT_MAX;
    
    [self.redLayer addAnimation:animationGroup forKey:nil];
}


@end
