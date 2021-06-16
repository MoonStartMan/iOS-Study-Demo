//
//  SecondView.m
//  Block-Send-Demo
//
//  Created by 王潇 on 2021/6/13.
//

#import "SecondViewController.h"
#import "FirstViewController.h"
#import <Masonry/Masonry.h>

@implementation SecondViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.title = @"ViewController - Second";
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
    self.titleLabel.text = @"接收数据界面";
    
    self.textField = [[UITextField alloc] init];
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(100);
        make.left.equalTo(self.view.mas_left).with.offset(50);
        make.right.equalTo(self.view.mas_right).with.offset(-50);
        make.height.mas_equalTo(50);
    }];
    
    self.textField.font = [UIFont systemFontOfSize:16.0f weight:UIFontWeightMedium];
    self.textField.placeholder = @"请输入需要传入的内容";
    self.textField.textColor = [UIColor blackColor];
    self.textField.layer.masksToBounds = YES;
    self.textField.layer.cornerRadius = 25;
    self.textField.layer.borderWidth = 2;
    self.textField.layer.borderColor = [UIColor blackColor].CGColor;
    [self.textField setValue:[NSNumber numberWithInt:10] forKey:@"paddingLeft"];
    
    self.returnBtn = [[UIButton alloc] init];
    [self.view addSubview:self.returnBtn];
    [self.returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.mas_bottom).with.offset(100);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    
    [self.returnBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.returnBtn setTintColor: [UIColor whiteColor]];
    [self.returnBtn setBackgroundColor:[UIColor systemBlueColor]];
    self.returnBtn.layer.masksToBounds = YES;
    self.returnBtn.layer.cornerRadius = 25;
    [self.returnBtn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)tap {
    if (self.returnTextBlock) {
        self.returnTextBlock(self.textField.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
