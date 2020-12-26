//
//  ViewController.m
//  Masonry-Demo
//
//  Created by 王潇 on 2020/12/24.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat padding = 10;
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    UIView *yellowView = [[UIView alloc] init];
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    
    /**等高********/
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view).insets(UIEdgeInsetsMake(padding, padding, 0, padding));
        make.bottom.equalTo(blueView.mas_top).offset(-padding);
    }];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, padding, 0, padding));
        make.bottom.equalTo(yellowView.mas_top).offset(-padding);
    }];
    
    /**
     下面设置make.height的数组是关键，通过这个数组可以设置这三个视图高度相等。其他例如宽度之类的，也是类似的方式。
     */
    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, padding, padding, padding));
        make.height.equalTo(@[blueView, redView]);
    }];
    
    /**等宽*******/
//    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(padding, padding, padding, 0));
//        make.right.equalTo(blueView.mas_left).offset(-padding);
//    }];
//    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(padding, 0, padding, 0));
//        make.right.equalTo(yellowView.mas_left).offset(-padding);
//    }];
//    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.right.equalTo(self.view).insets(UIEdgeInsetsMake(padding, 0, padding, padding));
//        make.width.equalTo(@[redView, blueView]);
//    }];
}


@end
