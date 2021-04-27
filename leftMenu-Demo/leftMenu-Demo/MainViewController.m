//
//  MainViewController.m
//  leftMenu-Demo
//
//  Created by 王潇 on 2021/4/26.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 64, 100, 30)];
    [btn setTitle:@"点击展开" forState:UIControlStateNormal];
    btn.titleLabel.textColor = [UIColor whiteColor];
    [btn setBackgroundColor: [UIColor blackColor]];
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightBold];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)btnClick{
    showLeft(YES);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
