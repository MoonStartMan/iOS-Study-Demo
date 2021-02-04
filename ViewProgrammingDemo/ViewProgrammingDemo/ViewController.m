//
//  ViewController.m
//  ViewProgrammingDemo
//
//  Created by 王潇 on 2021/2/3.
//

#import "ViewController.h"

@interface ViewController ()

// 定义一个放照片的 UIImageView
@property(nonatomic, strong) UIImageView *OurImages;

// 记录当前展示的照片次序
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  创建 UIImageView
    self.OurImages = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview: self.OurImages];
    
    //  图片会在 View 中显示  并且比例不变
    self.OurImages.contentMode = UIViewContentModeScaleAspectFill;
    //  设置默认的照片 和 默认的次序 (这里要对应 第一张图片 对应下标(次序) 0)
    self.OurImages.image = [UIImage imageNamed:@"1"];
    self.currentIndex = 0;
    
    //  创建 并 添加 两个手势 左滑右滑
    //  注意: 这个手势 默认属性direction(方向)只有向右滑动  所以要为左滑动更改下属性 向右是默认 可以不改
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftAction:)];
    left.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:left];
    
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightAction:)];
    [self.view addGestureRecognizer:right];
}

//  左滑触及的方法 目的是 上一张照片 给自己自定义的方法传参参数标记1
- (void)leftAction:(UISwipeGestureRecognizer *)sender
{
    [self transitionAnimation:1];
}

//  右滑触及的方法 目的是 下一张照片 给自己定义的方法传参数标记0
- (void)rightAction:(UISwipeGestureRecognizer *)sender
{
    [self transitionAnimation:0];
}

- (void)transitionAnimation: (BOOL)isNext
{
    //  创建转场动画
    CATransition *trans = [[CATransition alloc] init];
    //  效果 支持的字段参考 上一篇动画的总结
    trans.type = @"cube";
    if (isNext) {
        trans.subtype = kCATransitionFromRight;
    } else {
        trans.subtype = kCATransitionFromLeft;
    }
    // 动画持续时间
     trans.duration = 1.0f;
    // 调用得到照片的方法
    self.OurImages.image = [self getImage:isNext];
    [self.OurImages.layer addAnimation:trans forKey:@"切换照片"];
}

- (UIImage *)getImage:(BOOL)isNext
{
    if (isNext) {
        // 当 currentIndex = 1时候  (1+1)%5 = 2;  下一张
        self.currentIndex = (self.currentIndex +1)%10;
    } else {
        // 当 currentIndex = 1时候  (1-1+5)%5 = 0; 上一张
      self.currentIndex = (self.currentIndex - 1 + 10)%10;
    }
    // 往数组里面添加图片  图片名与下标名对应
    NSString *imageName = [NSString stringWithFormat:@"%ld",self.currentIndex + 1];
    return [UIImage imageNamed:imageName];
}

@end
