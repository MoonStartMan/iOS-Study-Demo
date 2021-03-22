//
//  ViewController.m
//  loading-demo
//
//  Created by 王潇 on 2021/3/19.
//

#import "ViewController.h"
#import "UIView+VLAdditions.h"
#import "LoadingView.h"
#import <Masonry/Masonry.h>
#import "InputTextView.h"

@interface ViewController ()

@property (nonatomic, strong) LoadingView *loadingView;

@property (nonatomic, strong) InputTextView* startTextView;

@property (nonatomic, strong) InputTextView* endTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.loadingView = [[LoadingView alloc] init];
    [self.view addSubview:self.loadingView];
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(100);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    self.loadingView.hidden = YES;
    
    self.startTextView = [[InputTextView alloc] init];
    [self.view addSubview:self.startTextView];
    [self.startTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loadingView.mas_top).with.offset(20);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.height.mas_equalTo(30);
    }];
    self.startTextView.textLabel.text = @"输入开始百分比区间:(0-1)";
    
    self.endTextView = [[InputTextView alloc] init];
    [self.view addSubview:self.endTextView];
    [self.endTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startTextView.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.height.mas_equalTo(30);
    }];
    self.endTextView.textLabel.text = @"输入结束百分比区间:(0-1)";
    
    UIButton *downLoadBtn = [[UIButton alloc] init];
    [downLoadBtn addTarget:self action:@selector(startMove) forControlEvents:UIControlEventTouchUpInside];
    [downLoadBtn setTitle:@"开始" forState:UIControlStateNormal];
    [downLoadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    downLoadBtn.titleLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightBold];
    [self.view addSubview:downLoadBtn];
    [downLoadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.endTextView.mas_bottom).with.offset(100);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    downLoadBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    downLoadBtn.layer.borderWidth = 4;
    downLoadBtn.layer.cornerRadius = 10;
    downLoadBtn.layer.masksToBounds = YES;
}

- (void)startMove {
    CGFloat startVal = self.startTextView.textField.text.floatValue;
    CGFloat endVal = self.endTextView.textField.text.floatValue;
    [self.loadingView updatePressPathStartVal:startVal updatePressPathEndVal:endVal];
}

@end
