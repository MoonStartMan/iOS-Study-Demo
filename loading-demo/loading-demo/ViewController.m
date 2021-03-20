//
//  ViewController.m
//  loading-demo
//
//  Created by 王潇 on 2021/3/19.
//

#import "ViewController.h"
#import "UIView+VLAdditions.h"
#import <Masonry/Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) UIBezierPath *trackPath;

@property (nonatomic, strong) CAShapeLayer *trackLayer;

@property (nonatomic, strong) UIBezierPath *progressPath;

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, strong) CABasicAnimation* pathAnimation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    self.pathAnimation.delegate = (id)self;
    
    UIButton *downLoadBtn = [[UIButton alloc] init];
    [downLoadBtn addTarget:self action:@selector(startMove) forControlEvents:UIControlEventTouchUpInside];
    [downLoadBtn setTitle:@"下载" forState:UIControlStateNormal];
    [downLoadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    downLoadBtn.titleLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightBold];
    [self.view addSubview:downLoadBtn];
    [downLoadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(100);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    downLoadBtn.layer.borderColor = [UIColor blackColor].CGColor;
    downLoadBtn.layer.borderWidth = 4;
    downLoadBtn.layer.cornerRadius = 10;
    downLoadBtn.layer.masksToBounds = YES;
}

- (void)startMove {
    CGRect mybound = CGRectMake(50, 100, 50, 50);
    [self startProgressAction:mybound];
    [self updateAnimate:2];
}

//画两个圆形
-(void)startProgressAction:(CGRect)mybound
{
    //底下的框（灰色）不会动的
    _trackPath = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:(mybound.size.width - 0.7)/ 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    _trackLayer = [CAShapeLayer new];
    [self.view.layer addSublayer:_trackLayer];
    _trackLayer.fillColor = nil;
    _trackLayer.strokeColor=[UIColor grayColor].CGColor;
    _trackLayer.path = _trackPath.CGPath;
    _trackLayer.lineWidth=4;
    _trackLayer.frame = mybound;
    
    //会动的
    _progressPath = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:(mybound.size.width - 0.7)/ 2 startAngle:- M_PI_2 endAngle:(M_PI * 2) - M_PI_2 clockwise:YES];
    _progressLayer = [CAShapeLayer new];
    [self.view.layer addSublayer:_progressLayer];
    _progressLayer.fillColor = nil;
    _progressLayer.strokeColor=[UIColor blackColor].CGColor;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.path = _progressPath.CGPath;
    _progressLayer.lineWidth=4;
    _progressLayer.frame = mybound;
    _progressLayer.strokeEnd = 1;
    _progressLayer.strokeStart = 0;
}

- (void)updateAnimate:(CGFloat)seconds {
    self.pathAnimation.duration = seconds;
    self.pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    self.pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    self.pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    self.pathAnimation.fillMode = kCAFillModeBoth;
    self.pathAnimation.removedOnCompletion = NO;
    [_progressLayer addAnimation:self.pathAnimation forKey:@"strokeEndAnimation"];
}



@end
