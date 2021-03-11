//
//  ViewController.m
//  NSNotificationCenter-Demo
//
//  Created by 王潇 on 2021/3/11.
//

#import "ViewController.h"
#import "ShowViewController.h"
#import <Masonry/Masonry.h>

@interface ViewController ()

//  显示传值的内容
@property (strong, nonatomic) UILabel *textString;
//  跳转Button
@property (strong, nonatomic) UIButton *clickBtn;
//  跳转
- (void)notificationClick: (UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发送通知页面";
    
    self.textString = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview: self.textString];
    [self.textString mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(124);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 40*2, 300));
    }];
    
    self.textString.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightBold];
    self.textString.textColor = [UIColor blackColor];
    self.textString.textAlignment = NSTextAlignmentCenter;
    self.textString.backgroundColor = [UIColor orangeColor];
    self.textString.layer.cornerRadius = 10;
    self.textString.layer.masksToBounds = YES;
    
    self.clickBtn = [[UIButton alloc] init];
    [self.view addSubview: self.clickBtn];
    [self.clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textString.mas_bottom).with.offset(60);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(200, 80));
    }];
    [self.clickBtn setTitle:@"开始通知的逆向传值" forState:UIControlStateNormal];
    [self.clickBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.clickBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightBold];
    self.clickBtn.layer.cornerRadius = 10.0f;
    self.clickBtn.layer.masksToBounds = YES;
    self.clickBtn.backgroundColor = [UIColor blackColor];
    [self.clickBtn addTarget:self action:@selector(notificationClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //  注册通知----第一部
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showLabelText:) name:@"labelTextNotification" object: nil];
}

//  实现通知监听----第二部
- (void)showLabelText:(NSNotification *)notification
{
    //  第三,实现通知中心内部的方法,并实现传值
    id text = notification.object;
    //  赋值到文本上面
    self.textString.text = text;
}

//  释放通知----第四部
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"labelTextNotification" object:nil];
}

#pragma mark - //   点击通知跳转

- (void)notificationClick:(UIButton *)sender {
    ShowViewController *ShowVC = [[ShowViewController alloc] init];
    [self.navigationController pushViewController:ShowVC animated:YES];
}



@end
