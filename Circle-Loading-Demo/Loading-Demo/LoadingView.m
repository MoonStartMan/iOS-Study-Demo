//
//  LoadingView.m
//  Loading-Demo
//
//  Created by 王潇 on 2021/7/16.
//

#import "LoadingView.h"
#import "CircleView.h"
#import <Masonry/Masonry.h>

@interface LoadingView()

//  进度圆环
@property (nonatomic, strong) CircleView *circleView;
//  第一行Label
@property (nonatomic, strong) UILabel *topLabel;
//  第二行Label
@property (nonatomic, strong) UILabel *bottomLabel;

@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        //  毛玻璃背景
        self.layer.backgroundColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:0.6].CGColor;
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        [self addSubview:visualView];
        [visualView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.offset(0);
        }];
        
        //  进度圆环
        self.circleView = [[CircleView alloc] initWithFrame:CGRectZero lineWidth:3.0f];
        [self addSubview:self.circleView];
        [self.circleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(28);
            make.centerX.equalTo(self.mas_centerX).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(36, 36));
        }];
        
        //  第一行Label
        self.topLabel = [[UILabel alloc] init];
        [self addSubview:self.topLabel];
        [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.circleView.mas_bottom).with.offset(28);
            make.centerX.equalTo(self.mas_centerX).with.offset(0);
            make.height.mas_equalTo(17);
        }];
        self.topLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightRegular];
        self.topLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        
        //  第二行Label
        self.bottomLabel = [[UILabel alloc] init];
        [self addSubview:self.bottomLabel];
        [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topLabel.mas_bottom).with.offset(7);
            make.centerX.equalTo(self.mas_centerX).with.offset(0);
            make.height.mas_equalTo(17);
        }];
        
        self.bottomLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightRegular];
        self.bottomLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        self.bottomLabel.text = @"请勿退出应用";
    }
    return self;
}

- (void)updateProgress {
    self.circleView.progress = self.currentIndex / self.totalPhotoCount;
    self.topLabel.text = [NSString stringWithFormat:@"%ld / %ld 照片保存中",(NSInteger)self.currentIndex,(NSInteger)self.totalPhotoCount];
}

@end
