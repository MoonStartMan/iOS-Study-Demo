//
//  NextViewController.m
//  Project
//
//  Created by 王潇 on 2020/11/10.
//

#import "NextViewController.h"
#import "Defaultinstance.h"

@interface NextViewController ()

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIButton *btn;

@end

@implementation NextViewController

- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
        _textField.textColor = [UIColor whiteColor];
        _textField.backgroundColor = [UIColor blackColor];
        self.view.backgroundColor = [UIColor whiteColor];
        
        //  属性传值-接收并显示
//        _textField.text = self.str;
        
        //  单例传值--接收并显示
//        _textField.text = [Defaultinstance sharedInstance].str;
        
        //  NSUserDefaults传值 -- 从文件中读取并显示
//        _textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"NSUserDefaults"];
    }
    return _textField;
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 200, 40)];
        _btn.backgroundColor = [UIColor redColor];
        [_btn setTitle:@"跳转回页面1" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:20];
        
        [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

//  点击事件-回到页面1
- (void)btnClick {
    NextViewController *nextVC = [[NextViewController alloc] init];
    
    //  属性传值
//    nextVC.str = @"属性传值";
    
    //  单例传值-反向传递
//    [Defaultinstance sharedInstance].str = self.textField.text;
    
    //  NSUserDefaults传值-反向传值
//    [[NSUserDefaults standardUserDefaults] setObject:self.textField.text forKey:@"NSUserDefaults-re"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //  代理传值--反向传值
//    [self.delegate passValue:self.textField.text];
    
    //  block传值--反向传值
//    self.block(self.textField.text);
    
    //  通知传值--发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notify" object:nil userInfo:@{@"not":self.textField.text}];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.textField];
    [self.view addSubview:self.btn];
}

@end
