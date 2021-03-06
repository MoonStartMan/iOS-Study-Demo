//
//  ViewController.m
//  Protocol-Demo
//
//  Created by 王潇 on 2021/3/4.
//

#import "SendViewController.h"
#import "dataProtocol.h"
#import "sendUITextField.h"
#import "ReceiveViewController.h"

#import <Masonry/Masonry.h>

@interface SendViewController ()

@property (strong, nonatomic) sendUITextField *nameTextField;
@property (strong, nonatomic) sendUITextField *ageTextField;
@property (strong, nonatomic) sendUITextField *phoneTextField;
@property (strong, nonatomic) UIButton *sendButton;

@end

@implementation SendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"传递数据页面";
    self.nameTextField = [[sendUITextField alloc] initWithTextFiledName:@"请输入需要传递的名字"];
    [self.view addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(100);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 20*2, 60));
    }];
    
    self.ageTextField = [[sendUITextField alloc] initWithTextFiledName:@"请输入需要传递的年龄"];
    [self.view addSubview:self.ageTextField];
    [self.ageTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameTextField.mas_bottom).with.offset(40);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 20*2, 60));
    }];
    
    self.phoneTextField = [[sendUITextField alloc] initWithTextFiledName:@"请输入需要传递的手机号码"];
    [self.view addSubview: self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ageTextField.mas_bottom).with.offset(40);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 20*2, 60));
    }];
    
    self.sendButton = [[UIButton alloc] init];
    [self.view addSubview: self.sendButton];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).with.offset(40);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 40*2, 40));
    }];
    
    self.sendButton.layer.cornerRadius = ceil(40/2);
    [self.sendButton setTitle:@"提交信息" forState:UIControlStateNormal];
    [self.sendButton setTintColor:[UIColor whiteColor]];
    self.sendButton.backgroundColor = [UIColor blackColor];
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightBold];
    [self.sendButton addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)sendMessage{
    NSString *regexpMobile = @"^1[345789]\\d{9}$";
    NSPredicate *checkMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexpMobile];
    BOOL isMobilePhone = [checkMobile evaluateWithObject: self.phoneTextField.text];
    
    NSString *regAge = @"^[0-9]*$";
    NSPredicate *checkAge = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regAge];
    BOOL isAge = [checkAge evaluateWithObject: self.ageTextField.text];
    
    NSString *regName = @"^[\u4e00-\u9fa5]{0,}$";
    NSPredicate *checkName = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regName];
    BOOL isName = [checkName evaluateWithObject: self.nameTextField.text];
    
    if (self.nameTextField.text == nil || self.ageTextField.text == nil || self.phoneTextField.text == nil) {
        return;
    } else if (self.phoneTextField.text.length != 11) {
        /** 提示最多11位*/
        if (!isMobilePhone) {
        /** 请输入正确的手机号*/
            return;
        }
    } else if (!isAge) {
        /** 请输入正确的年龄 */
        return;
    } else if (!isName) {
        /** 请输入正确的名字 */
        return;
    } else {
        ReceiveViewController *receiveVC = [[ReceiveViewController alloc] init];
        receiveVC.delegate = (id)self;
        [self.navigationController pushViewController:receiveVC animated:YES];
    }
}

#pragma mark DataProtocol

- (NSString *)sendName{
    return _nameTextField.text;
}

- (NSString *)sendAge{
    return _ageTextField.text;
}

- (NSString *)sendPhone{
    return _phoneTextField.text;
}

@end
