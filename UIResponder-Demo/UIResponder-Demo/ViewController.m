//
//  ViewController.m
//  UIResponder-Demo
//
//  Created by 王潇 on 2021/3/2.
//

#import "ViewController.h"
#import "FirstResponderView.h"
#import "AudioView.h"
#import "MenuLabel.h"
#import "DrawingBoardView.h"
#import "KeyCommandView.h"
#import "CustomInputView.h"

#import <Masonry/Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    FirstResponderView *firstResponderView = [[FirstResponderView alloc] initWithFrame:CGRectZero];
//    [self.view addSubview: firstResponderView];
//    [firstResponderView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).with.offset(0);
//        make.top.equalTo(self.view.mas_top).with.offset(0);
//        make.size.mas_equalTo([UIScreen mainScreen].bounds.size);
//    }];
//
//    AudioView *audioView = [[AudioView alloc] initWithFrame:CGRectZero];
//    [self.view addSubview: audioView];
//    [audioView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).with.offset(44);
//        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
//        make.size.mas_equalTo(CGSizeMake(100, 40));
//    }];
    
//    MenuLabel *label = [[MenuLabel alloc] initWithFrame:CGRectZero];
//    [self.view addSubview: label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).with.offset(44);
//        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
//        make.size.mas_equalTo(CGSizeMake(200, 60));
//    }];
//    label.text = @"点击复制";
//    label.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightBold];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor whiteColor];
//    label.backgroundColor = [UIColor blackColor];
//    label.layer.cornerRadius = 10;
//    label.layer.masksToBounds = YES;
    
    DrawingBoardView *drawingBoardView = [[DrawingBoardView alloc] initWithFrame:CGRectZero];
    [self.view addSubview: drawingBoardView];
    [drawingBoardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.size.mas_equalTo([UIScreen mainScreen].bounds.size);
    }];
    
//    KeyCommandView *commandView = [[KeyCommandView alloc] initWithFrame: CGRectZero];
//    [self.view addSubview: commandView];
//    [commandView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).with.offset(44);
//        make.size.mas_equalTo([UIScreen mainScreen].bounds.size);
//    }];
    
//    CustomInputView *inputView = [[CustomInputView alloc] initWithFrame: CGRectZero];
//    [self.view addSubview: inputView];
//    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).with.offset(100);
//        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
//        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 60));
//    }];
}

- (UIViewController *)getControllerFromView: (UIView *)view {
    //  遍历响应者链。返回第一个找到视图控制器
    UIResponder *responder = view;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    //  如果没有找到对象返回nil
    return nil;
}



@end
