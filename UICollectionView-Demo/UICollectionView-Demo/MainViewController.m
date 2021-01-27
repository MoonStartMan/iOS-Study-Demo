//
//  MainViewController.m
//  UICollectionView-Demo
//
//  Created by 王潇 on 2021/1/27.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LineCollectionViewController.h"
#import "IrregularFlowLayout.h"
#import "IrregularCollectionViewController.h"
#import "RoundUIcollectionViewFlowLayout.h"
#import "RoundCollectionViewController.h"
#import "FlowLayout4.h"
#import "CollectionViewController4.h"
#import "ClickBtn.h"
#import <Masonry/Masonry.h>


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    ClickBtn *firstBtn = [[ClickBtn alloc] initWithFrame:CGRectZero];
    [self.view addSubview: firstBtn];
    [firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(40);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake((self.view.frame.size.width-10)/2, 40));
    }];
    firstBtn.textLabel.text = @"跳转DEMO1";
    [firstBtn addTarget:self action:@selector(gotoDemo1) forControlEvents:UIControlEventTouchUpInside];
    
    ClickBtn *secondBtn = [[ClickBtn alloc] initWithFrame:CGRectZero];
    [self.view addSubview: secondBtn];
    [secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(40);
        make.right.equalTo(self.view.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake((self.view.frame.size.width-10)/2, 40));
    }];
    secondBtn.textLabel.text = @"跳转DEMO2";
    [secondBtn addTarget:self action:@selector(gotoDemo2) forControlEvents:UIControlEventTouchUpInside];
    
    ClickBtn *thirdBtn = [[ClickBtn alloc] initWithFrame:CGRectZero];
    [self.view addSubview: thirdBtn];
    [thirdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstBtn.mas_bottom).with.offset(20);
        make.left.equalTo(firstBtn.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake((self.view.frame.size.width-10)/2, 40));
    }];
    thirdBtn.textLabel.text = @"跳转DEMO3";
    [thirdBtn addTarget:self action:@selector(gotoDemo3) forControlEvents:UIControlEventTouchUpInside];
    
    ClickBtn *fouthBtn = [[ClickBtn alloc] initWithFrame:CGRectZero];
    [self.view addSubview: fouthBtn];
    [fouthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondBtn.mas_bottom).with.offset(20);
        make.right.equalTo(secondBtn.mas_right).with.offset(0);
        make.size.mas_equalTo(CGSizeMake((self.view.frame.size.width-10)/2, 40));
    }];
    fouthBtn.textLabel.text = @"跳转DEMO4";
    [fouthBtn addTarget:self action:@selector(gotoDemo4) forControlEvents:UIControlEventTouchUpInside];
}

- (void)gotoDemo1 {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    LineCollectionViewController *lineVC = [[LineCollectionViewController alloc] initWithCollectionViewLayout:layout];
    appDelegate.window.rootViewController = lineVC;
}

- (void)gotoDemo2 {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    IrregularFlowLayout *layout = [[IrregularFlowLayout alloc] init];
    IrregularCollectionViewController *IrrVC = [[IrregularCollectionViewController alloc] initWithCollectionViewLayout:layout];
    appDelegate.window.rootViewController = IrrVC;
}

- (void)gotoDemo3 {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    RoundUIcollectionViewFlowLayout *layout = [[RoundUIcollectionViewFlowLayout alloc] init];
    RoundCollectionViewController *RoundVC = [[RoundCollectionViewController alloc] initWithCollectionViewLayout:layout];
    appDelegate.window.rootViewController = RoundVC;
}

- (void)gotoDemo4 {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    FlowLayout4 *layout = [[FlowLayout4 alloc] init];
    CollectionViewController4 *VC4 = [[CollectionViewController4 alloc] initWithCollectionViewLayout:layout];
    appDelegate.window.rootViewController = VC4;
}

@end
