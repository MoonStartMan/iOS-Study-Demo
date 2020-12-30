//
//  ViewController.m
//  conversion-UIColor
//
//  Created by 王潇 on 2020/12/30.
//

#import "ViewController.h"
#import "UIColor+Hex.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for(int i = 0; i < 5; i++) {
        /*
            case 0、case 1、 case 4:调用方法3，方法3处理以"#和0X开头的16进制字符串"
            case1: 调用方法1，其alpha是固定的，只处理十六进制"0X"开头
            case2: 调用方法2，颜色的alpha可以改变
         */
        
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(100, 100 + 100 * i, 80, 80);
        switch (i) {
            case 0:
                view.backgroundColor = [UIColor colorWithHexString:@"#e5e589"];
                break;
            case 1:
                view.backgroundColor = [UIColor colorWithHexString:@"0Xe5e589"];
                break;
            case 2:
                view.backgroundColor = [UIColor colorWithHex:0Xe5e589];
                break;
            case 3:
                view.backgroundColor = [UIColor colorWithHex:0Xe5e589 alpha:0.5];
                break;
            case 4:
                view.backgroundColor = [UIColor colorWithHexString:@"#784679"];
                break;
            default:
                break;
        }
        [self.view addSubview:view];
    }
}


@end
