//
//  ViewController.m
//  Description
//
//  Created by 王潇 on 2021/7/12.
//

#import "ViewController.h"
#import "DescriptionView.h"

#import <Masonry/Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) DescriptionView* descriptView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.descriptView = [[DescriptionView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.descriptView];
    [self.descriptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(294.5);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 200));
    }];
    
    // Do any additional setup after loading the view.
}


@end
