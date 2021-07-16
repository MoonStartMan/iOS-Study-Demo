//
//  CircleView.m
//  Loading-Demo
//
//  Created by 王潇 on 2021/7/16.
//

#import "CircleView.h"

@interface CircleView()
//  背景Layer
@property (nonatomic, strong) CAShapeLayer *backLayer;
//  进度Layer
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame lineWidth:(float)lineWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineWidth = lineWidth;
        self.backLayer = [CAShapeLayer layer];
        self.progressLayer = [CAShapeLayer layer];
        [self.layer addSublayer:self.backLayer];
        [self.layer addSublayer:self.progressLayer];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    float centerX = self.bounds.size.width/2.0;
    float centerY = self.bounds.size.height/2.0;
    //  半径
    float radius = (self.bounds.size.width - self.lineWidth)/2.0;
    //  创建贝塞尔路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:(-0.5f*M_PI) endAngle:1.5f*M_PI clockwise:YES];
    //  添加背景圆环
    self.backLayer.frame = self.bounds;
    self.backLayer.fillColor = [[UIColor clearColor] CGColor];
    self.backLayer.strokeColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.15].CGColor;
    self.backLayer.lineWidth = self.lineWidth;
    self.backLayer.path = [path CGPath];
    self.backLayer.strokeEnd = 1;
    
    //  创建进度Layer
    self.progressLayer.frame = self.bounds;
    self.progressLayer.fillColor = [[UIColor clearColor] CGColor];
    //  指定path的渲染颜色
    self.progressLayer.strokeColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.lineWidth = self.lineWidth;
    self.progressLayer.path = [path CGPath];
}

-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    self.progressLayer.strokeEnd = progress;
}

@end
