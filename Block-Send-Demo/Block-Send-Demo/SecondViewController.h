//
//  SecondView.h
//  Block-Send-Demo
//
//  Created by 王潇 on 2021/6/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecondViewController : UIViewController

//  给Block重新定义一个名字cewrewgr
typedef void(^ReturnTextBlock)(NSString *text);

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *returnBtn;

@property (nonatomic, copy) ReturnTextBlock returnTextBlock;

@end

NS_ASSUME_NONNULL_END
