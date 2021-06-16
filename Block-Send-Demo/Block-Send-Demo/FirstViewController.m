//
//  FirstView.m
//  Block-Send-Demo
//
//  Created by 王潇 on 2021/6/13.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import <Masonry/Masonry.h>

@implementation FirstViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.frame = [UIScreen mainScreen].bounds;
}

- (void)setUI {
    self.title = @"ViewController - First";
    self.titleLabel = [[UILabel alloc] init];
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(100);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.height.mas_equalTo(30);
    }];
    
    self.titleLabel.font = [UIFont systemFontOfSize:30.0f weight:UIFontWeightBold];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"传入数据界面";
    
    self.inputTextField = [[UITextField alloc] init];
    [self.view addSubview:self.inputTextField];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(100);
        make.left.equalTo(self.view.mas_left).with.offset(50);
        make.right.equalTo(self.view.mas_right).with.offset(-50);
        make.height.mas_equalTo(50);
    }];
    
    self.inputTextField.font = [UIFont systemFontOfSize:16.0f weight:UIFontWeightMedium];
    self.inputTextField.placeholder = @"请输入需要传入的内容";
    self.inputTextField.textColor = [UIColor blackColor];
    self.inputTextField.layer.masksToBounds = YES;
    self.inputTextField.layer.cornerRadius = 25;
    self.inputTextField.layer.borderWidth = 2;
    self.inputTextField.layer.borderColor = [UIColor blackColor].CGColor;
    [self.inputTextField setValue:[NSNumber numberWithInt:10] forKey:@"paddingLeft"];
    
    self.sendBtn = [[UIButton alloc] init];
    [self.view addSubview:self.sendBtn];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputTextField.mas_bottom).with.offset(100);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    
    [self.sendBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.sendBtn setTintColor: [UIColor whiteColor]];
    [self.sendBtn setBackgroundColor:[UIColor systemBlueColor]];
    self.sendBtn.layer.masksToBounds = YES;
    self.sendBtn.layer.cornerRadius = 25;
    [self.sendBtn addTarget:self action:@selector(sender:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)sender:(UIButton *)sender {
    SecondViewController *SVC = [[SecondViewController alloc] init];
    SVC.textField.text = self.inputTextField.text;
    SVC.returnTextBlock = ^(NSString * _Nonnull showText) {
        self.inputTextField.text = showText;
    };
    [self.navigationController pushViewController:SVC animated:YES];
}

@end
