//
//  ViewController.m
//  CAShapeLayer
//
//  Created by 王潇 on 2020/12/21.
//

#import "ViewController.h"
#import "RollLoadingView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [RollLoadingView Show];
}

@end
