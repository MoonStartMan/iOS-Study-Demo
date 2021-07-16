//
//  ViewController.m
//  Loading-Demo
//
//  Created by 王潇 on 2021/7/16.
//

#import "ViewController.h"
#import "LoadingView.h"
#import <Masonry/Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) LoadingView *loadingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loadingView = [[LoadingView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.loadingView];
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.centerY.equalTo(self.view.mas_centerY).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(150, 155));
    }];
    
    self.loadingView.currentIndex = 1;
    self.loadingView.totalPhotoCount = 5;
    [self.loadingView updateProgress];
}


@end
