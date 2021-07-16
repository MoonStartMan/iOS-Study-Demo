//
//  Circle.m
//  Drag-Progress-Demo
//
//  Created by 王潇 on 2021/7/16.
//

#import "Circle.h"

#define RGB(r, g, b) [UIColor colorWithRed: r/255.0 green:g/255.0 blue:b/255.0 alpha: 1.0]

static CGFloat endPointMargin = 1.0f;

@interface Circle()
//  背景Layer
@property (nonatomic, strong) CAShapeLayer *trackLayer;
//  进度Layer
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) UIImageView *endPoint;

@end

@implementation Circle

- (instancetype)initWithFrame:(CGRect)frame lineWidth:(float)lineWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineWidth = lineWidth;
        [self buildLayout];
    }
    return self;
}

-(void)buildLayout
{
    float centerX = self.bounds.size.width/2.0;
    float centerY = self.bounds.size.height/2.0;
    //  半径
    float radius = (self.bounds.size.width - self.lineWidth)/2.0;
    //  创建贝塞尔路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:(-0.5f*M_PI) endAngle:1.5f*M_PI clockwise:YES];
    //  添加背景圆环
    CAShapeLayer *backLayer = [CAShapeLayer layer];
    backLayer.frame = self.bounds;
    backLayer.fillColor = [[UIColor clearColor] CGColor];
    backLayer.strokeColor = [UIColor colorWithRed:50.0/255.0f green:50.0/255.0f blue:50.0/255.0f alpha:1].CGColor;
    backLayer.lineWidth = self.lineWidth;
    backLayer.path = [path CGPath];
    backLayer.strokeEnd = 1;
    [self.layer addSublayer:backLayer];
    
    //  创建进度Layer
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.frame = self.bounds;
    self.progressLayer.fillColor = [[UIColor clearColor] CGColor];
    //  指定path的渲染颜色
    self.progressLayer.strokeColor = [[UIColor blackColor] CGColor];
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.lineWidth = self.lineWidth;
    self.progressLayer.path = [path CGPath];
    self.progressLayer.strokeEnd = 0;
    
    //  设置渐变颜色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[RGB(255, 151, 0) CGColor],(id)[RGB(255, 203, 0) CGColor], nil]];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    [gradientLayer setMask:self.progressLayer]; //  用progressLayer来截取渐变层
    [self.layer addSublayer:gradientLayer];
    
    //  用于显示结束位置的小点
    self.endPoint = [[UIImageView alloc] init];
    self.endPoint.frame = CGRectMake(0, 0, self.lineWidth - endPointMargin*2, self.lineWidth - endPointMargin*2);
    self.endPoint.hidden = YES;
    self.endPoint.backgroundColor = [UIColor blackColor];
    self.endPoint.image = [UIImage imageNamed:@"endPoint"];
    self.endPoint.layer.masksToBounds = YES;
    self.endPoint.layer.cornerRadius = self.endPoint.bounds.size.width/2;
    [self addSubview:self.endPoint];
}

-(void)setProgress:(float)progress
{
    _progress = progress;
    _progressLayer.strokeEnd = progress;
    [self updateEndPoint];
    [_progressLayer removeAllAnimations];
}

//  更新小点的位置
-(void)updateEndPoint
{
    //  转成弧度
    CGFloat angle = M_PI*2*self.progress;
    float radius = (self.bounds.size.width - self.lineWidth) / 2.0;
    int index = (angle)/M_PI_2; //  用户区分在第几象限内
    float needAngle = angle - index*M_PI_2; //  用于计算正弦/余弦的角度
    float x = 0, y = 0; //  用于保存_dotView的frame
    switch (index) {
        case 0:
            x = radius + sinf(needAngle)*radius;
            y = radius - cosf(needAngle)*radius;
            break;
        case 1:
            x = radius + cosf(needAngle)*radius;
            y = radius + sinf(needAngle)*radius;
            break;
        case 2:
            x = radius - sinf(needAngle)*radius;
            y = radius + cosf(needAngle)*radius;
            break;
        case 3:
            x = radius - cosf(needAngle)*radius;
            y = radius - sinf(needAngle)*radius;
            break;
        default:
            break;
    }
    
    //  更新圆环的frame
    CGRect rect = self.endPoint.frame;
    rect.origin.x = x + endPointMargin;
    rect.origin.y = y + endPointMargin;
    self.endPoint.frame = rect;
    //  移动到最前
    [self bringSubviewToFront:self.endPoint];
    self.endPoint.hidden = NO;
    if (self.progress == 0 || self.progress == 1) {
        self.endPoint.hidden = YES;
    }
}

@end
