//
//  ViewController.m
//  Drag-Progress-Demo
//
//  Created by 王潇 on 2021/7/16.
//

#import "ViewController.h"
#import "CircleProgress.h"

@interface ViewController ()

@property (nonatomic, strong) CircleProgress *circle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self addCircle];
}

- (void)addCircle
{
    CGFloat margin = 15.0f;
    CGFloat circleWidth = [UIScreen mainScreen].bounds.size.width - 2*margin;
    self.circle = [[CircleProgress alloc] initWithFrame:CGRectMake(0, 0, circleWidth, circleWidth)];
    self.circle.center = self.view.center;
    [self.view addSubview:self.circle];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(self.circle.frame) + 50, self.view.bounds.size.width - 2*50, 30)];
    [slider addTarget:self action:@selector(sliderMethod:) forControlEvents:UIControlEventValueChanged];
    [slider setMaximumValue:1];
    [slider setMinimumValue:0];
    [slider setMinimumTrackTintColor:[UIColor colorWithRed:255/255.0f green:151/255.0f blue:0/255.0f alpha:1]];
    [self.view addSubview:slider];
}

- (void)sliderMethod:(UISlider *)slider
{
    self.circle.progress = slider.value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
