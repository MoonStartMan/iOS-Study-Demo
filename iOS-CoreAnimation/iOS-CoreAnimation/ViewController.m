//
//  ViewController.m
//  iOS-CoreAnimation
//
//  Created by 王潇 on 2021/2/27.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>

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
    
    UIButton *animationBtn1 = [[UIButton alloc] initWithFrame:CGRectZero];
    animationBtn1.backgroundColor = [UIColor blackColor];
    [animationBtn1 setTitle:@"按钮1" forState:UIControlStateNormal];
    [animationBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    animationBtn1.titleLabel.font = [UIFont systemFontOfSize:12];
    animationBtn1.layer.cornerRadius = 10;
    [animationBtn1 addTarget:self action:@selector(test01) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *animationBtn2 = [[UIButton alloc] initWithFrame:CGRectZero];
    animationBtn2.backgroundColor = [UIColor blackColor];
    [animationBtn2 setTitle:@"按钮2" forState:UIControlStateNormal];
    [animationBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    animationBtn2.titleLabel.font = [UIFont systemFontOfSize:12];
    animationBtn2.layer.cornerRadius = 10;
    [animationBtn2 addTarget:self action:@selector(test02) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *animationBtn3 = [[UIButton alloc] initWithFrame:CGRectZero];
    animationBtn3.backgroundColor = [UIColor blackColor];
    [animationBtn3 setTitle:@"按钮3" forState:UIControlStateNormal];
    [animationBtn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    animationBtn3.titleLabel.font = [UIFont systemFontOfSize:12];
    animationBtn3.layer.cornerRadius = 10;
    [animationBtn3 addTarget:self action:@selector(test03) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *animationBtn4 = [[UIButton alloc] initWithFrame:CGRectZero];
    animationBtn4.backgroundColor = [UIColor blackColor];
    [animationBtn4 setTitle:@"按钮4" forState:UIControlStateNormal];
    [animationBtn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    animationBtn4.titleLabel.font = [UIFont systemFontOfSize:12];
    animationBtn4.layer.cornerRadius = 10;
    [animationBtn4 addTarget:self action:@selector(test04) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *animationBtn5 = [[UIButton alloc] initWithFrame:CGRectZero];
    animationBtn5.backgroundColor = [UIColor blackColor];
    [animationBtn5 setTitle:@"按钮5" forState:UIControlStateNormal];
    [animationBtn5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    animationBtn5.titleLabel.font = [UIFont systemFontOfSize:12];
    animationBtn5.layer.cornerRadius = 10;
    [animationBtn5 addTarget:self action:@selector(test05) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *animationBtn6 = [[UIButton alloc] initWithFrame:CGRectZero];
    animationBtn6.backgroundColor = [UIColor blackColor];
    [animationBtn6 setTitle:@"按钮6" forState:UIControlStateNormal];
    [animationBtn6 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    animationBtn6.titleLabel.font = [UIFont systemFontOfSize:12];
    animationBtn6.layer.cornerRadius = 10;
    [animationBtn6 addTarget:self action:@selector(test06) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:animationBtn1];
    [self.view addSubview:animationBtn2];
    [self.view addSubview:animationBtn3];
    [self.view addSubview:animationBtn4];
    [self.view addSubview:animationBtn5];
    [self.view addSubview:animationBtn6];
    
    [animationBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.top.equalTo(self.view.mas_top).with.offset(200);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    [animationBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_right).with.offset(-120);
        make.top.mas_equalTo(animationBtn1.mas_top).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    [animationBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(animationBtn1.mas_left).with.offset(0);
        make.top.equalTo(animationBtn1.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    [animationBtn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(animationBtn2.mas_right).with.offset(0);
        make.top.equalTo(animationBtn3.mas_top).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    [animationBtn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(animationBtn3.mas_right).with.offset(0);
        make.top.equalTo(animationBtn3.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    [animationBtn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(animationBtn4.mas_right).with.offset(0);
        make.top.equalTo(animationBtn5.mas_top).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
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
