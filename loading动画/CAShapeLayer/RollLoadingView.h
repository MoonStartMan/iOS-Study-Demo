//
//  RollLoadingView.h
//  CAShapeLayer
//
//  Created by 王潇 on 2020/12/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ProgressLabelHeight 20

//RollView PacManViewHeight
#define RollViewHeight 60

//RollView PacManImageRadius
#define RollViewRadius 30

//RollView  PacManImageWH
#define RollViewWH RollViewRadius * M_PI

//RollView PacManImageHeight
#define RollViewHeight 60

//RollView PacManImageXY
#define RollViewXY 2

#define DefaultDuration 3

#define kLightColor [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0].CGColor

#define kMiddleColor [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor

#define kDeepColor [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor

@interface RollLoadingView : UIView

//  进度条
@property (nonnull, strong, nonatomic)UILabel* ProgressLabel;

//  是否显示进度百分比
@property (nonatomic, assign)BOOL HasShowProgress;

//  动画时间
@property (nonatomic, assign)CGFloat Duration;

//  是否允许用户交互
@property (nonatomic, assign)BOOL AllowsInteraction;

//  动画
@property (nonatomic, strong, nonnull)UIView *rollView;

+ (void)Show;

+ (void)ShowInView: (nonnull UIView*)view;

+ (void)Dismiss;

@end

NS_ASSUME_NONNULL_END
