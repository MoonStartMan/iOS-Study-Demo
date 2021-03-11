//
//  ShowViewController.m
//  NSNotificationCenter-Demo
//
//  Created by 王潇 on 2021/3/11.
//

#import "ShowViewController.h"
#import "ViewController.h"
#import <Masonry/Masonry.h>

@interface ShowViewController ()

//  输入要传值的文字
@property (strong, nonatomic) UITextField *textField;

//  传入按钮
@property (strong, nonatomic) UIButton *sendButton;

//  开始传值
- (void)startValue: (id)sender;

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"接受通知界面";
    
    self.textField = [[UITextField alloc] init];
    [self.view addSubview: self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(124);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 40 * 2, 40));
    }];
    
    self.textField.layer.cornerRadius = 10;
    self.textField.layer.masksToBounds = YES;
    self.textField.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightBold];
    self.textField.textColor = [UIColor redColor];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.textField.leftView = leftView;
    self.textField.layer.borderWidth = 2;
    self.textField.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.sendButton = [[UIButton alloc] init];
    [self.view addSubview: self.sendButton];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.mas_bottom).with.offset(40);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(200, 80));
    }];
    
    [self.sendButton setTitle:@"开始传值" forState:UIControlStateNormal];
    [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightBold];
    self.sendButton.layer.cornerRadius = 10.0f;
    self.sendButton.layer.masksToBounds = YES;
    self.sendButton.backgroundColor = [UIColor blackColor];
    [self.sendButton addTarget:self action:@selector(startValue:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)startValue:(id)sender {
    ViewController *VC = [[ViewController alloc] init];
    
    [VC view];
    
    [self.navigationController pushViewController:VC animated:YES];
    //  发布通知----第三部
    [[NSNotificationCenter defaultCenter]postNotificationName:@"labelTextNotification" object:self.textField.text];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
