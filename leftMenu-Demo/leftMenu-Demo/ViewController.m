//
//  ViewController.m
//  leftMenu-Demo
//
//  Created by 王潇 on 2021/4/26.
//

#import "ViewController.h"
#import "DrawerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


@end
