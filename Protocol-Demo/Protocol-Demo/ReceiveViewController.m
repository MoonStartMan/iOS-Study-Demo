//
//  ReceiveViewController.m
//  Protocol-Demo
//
//  Created by 王潇 on 2021/3/4.
//

#import "ReceiveViewController.h"
#import "ReceiveLabel.h"
#import <Masonry/Masonry.h>

@interface ReceiveViewController ()

@property (nonatomic, strong) ReceiveLabel* nameLabel;
@property (nonatomic, strong) ReceiveLabel* ageLabel;
@property (nonatomic, strong) ReceiveLabel* phoneLabel;

@end

@implementation ReceiveViewController
@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"接收数据页面";
    self.nameLabel = [[ReceiveLabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(100);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 20 * 2, 40));
    }];
    
    self.ageLabel = [[ReceiveLabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.ageLabel];
    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(40);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 20 * 2, 40));
    }];
    
    self.phoneLabel = [[ReceiveLabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ageLabel.mas_bottom).with.offset(40);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 20 * 2, 40));
    }];
    
    self.nameLabel.text = [_delegate sendName];
    self.ageLabel.text = [_delegate sendAge];
    self.phoneLabel.text = [_delegate sendPhone];
}

@end
