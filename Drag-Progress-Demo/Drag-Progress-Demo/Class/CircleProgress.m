//
//  CircleProgress.m
//  Drag-Progress-Demo
//
//  Created by 王潇 on 2021/7/16.
//

#import "CircleProgress.h"
#import "Circle.h"

@interface CircleProgress()

@property (nonatomic, strong) Circle *circle;

@property (nonatomic, strong) UILabel *percentLabel;

@end

@implementation CircleProgress

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    float lineWidth = 0.1*self.bounds.size.width;
    self.percentLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.percentLabel.textColor = [UIColor whiteColor];
    self.percentLabel.textAlignment = NSTextAlignmentCenter;
    self.percentLabel.font = [UIFont boldSystemFontOfSize:50];
    self.percentLabel.text = @"0%";
    [self addSubview:self.percentLabel];
    
    self.circle = [[Circle alloc] initWithFrame:self.bounds lineWidth:lineWidth];
    [self addSubview:self.circle];
}

#pragma mark - Setter方法
- (void)setProgress:(float)progress
{
    _progress = progress;
    _circle.progress = progress;
    _percentLabel.text = [NSString stringWithFormat:@"%.0f%%", progress*100];
}

@end
