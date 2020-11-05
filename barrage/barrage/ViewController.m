//
//  ViewController.m
//  barrage
//
//  Created by 王潇 on 2020/10/31.
//

#import "ViewController.h"
#import "BulletManager.h"
#import "BulletView.h"

@interface ViewController ()

@property (nonatomic, strong) BulletManager* manger;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manger = [[BulletManager alloc] init];
    __weak typeof(self) myself = self;
    self.manger.generateViewBlock = ^(BulletView *view) {
        [myself addBulletView:view];
    };
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"start" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 40);
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"stop" forState:UIControlStateNormal];
    btn.frame = CGRectMake(250, 100, 100, 40);
    [btn addTarget:self action:@selector(clickStopBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)clickBtn {
    [self.manger start];
}

- (void)clickStopBtn {
    [self.manger stop];
}

- (void)addBulletView:(BulletView *)view {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    view.frame = CGRectMake(width, 300 + view.trajectory * 50, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    [self.view addSubview:view];
    
    [view startAnimation];
}

@end
