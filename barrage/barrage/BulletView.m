//
//  BulletView.m
//  barrage
//
//  Created by 王潇 on 2020/10/31.
//

#import "BulletView.h"

#define Padding 10
#define PhotoHeight 30

@interface BulletView()

@property (nonatomic, strong) UILabel* lbComment;
@property (nonatomic, strong) UIImageView *photoIgv;

@end

@implementation BulletView

//  初始化弹幕
- (instancetype)initWithComment: (NSString *) comment {
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];
        self.layer.cornerRadius = 15;
        NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        
        CGFloat width = [comment sizeWithAttributes:attr].width;
        
        self.bounds = CGRectMake(0, 0, width + 2*Padding + PhotoHeight, 30);
        self.lbComment.text = comment;
        self.lbComment.frame = CGRectMake(Padding + PhotoHeight, 0, width, 30);
        
        self.photoIgv.frame = CGRectMake(-Padding, -Padding, PhotoHeight + Padding, PhotoHeight + Padding);
        self.photoIgv.layer.cornerRadius = (PhotoHeight + Padding)/2;
        self.photoIgv.layer.borderColor = [UIColor orangeColor].CGColor;
        self.photoIgv.layer.borderWidth = 1;
        self.photoIgv.image = [UIImage imageNamed:@"car"];
    }
    return self;
}

//  开始动画
- (void)startAnimation {
    
    //  根据弹幕长度执行动画效果
    //  根据 v = s/t, 时间相同的情况下，距离越长， 速度就越快
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 4.0f;
    CGFloat wholeWidth = screenWidth + CGRectGetWidth(self.bounds);
    
    //  弹幕开始
    if(self.moveStatusBlock) {
        self.moveStatusBlock(Start);
    }
    
    //  t = s/v;
    CGFloat speed = wholeWidth/duration;
    CGFloat enterDuration = CGRectGetWidth(self.bounds)/speed;
    [self performSelector:@selector(enterScreen) withObject:nil afterDelay:enterDuration];
    
    __block CGRect frame = self.frame;
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x -= wholeWidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if(self.moveStatusBlock) {
            self.moveStatusBlock(End);
        }
    }];
}

- (void)enterScreen {
    if(self.moveStatusBlock) {
        self.moveStatusBlock(Enter);
    }
}

//  结束动画
- (void)stopAnimation {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

//  弹幕的初始化
- (UILabel *)lbComment {
    if(!_lbComment) {
        _lbComment = [[UILabel alloc] initWithFrame:CGRectZero];
        _lbComment.font = [UIFont systemFontOfSize:14];
        _lbComment.textColor = [UIColor whiteColor];
        _lbComment.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbComment];
    }
    return _lbComment;
}

- (UIImageView *)photoIgv {
    if (!_photoIgv) {
        _photoIgv = [UIImageView new];
        _photoIgv.clipsToBounds = YES;
        _photoIgv.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_photoIgv];
    }
    return _photoIgv;
}

@end
