//
//  ViewController.m
//  iOS_五子棋大战
//
//  Created by 王潇 on 2020/11/12.
//

#import "ViewController.h"
#import "GobangView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIColor *backgroundColor =[ UIColor colorWithRed:230.0/ 255.0 green: 192.0 / 255.0 blue: 148.0 / 255.0 alpha: 1.0];
    GobangView *gobangView = [[GobangView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.width)];
    gobangView.backgroundColor = backgroundColor;
    [self.view addSubview:gobangView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
