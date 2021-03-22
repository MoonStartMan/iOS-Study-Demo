//
//  InputTextView.m
//  loading-demo
//
//  Created by 王潇 on 2021/3/22.
//

#import "InputTextView.h"
#import <Masonry/Masonry.h>

@implementation InputTextView

- (instancetype)init {
    self = [super init];
    if (self) {
        /// label
        self.textLabel = [[UILabel alloc] init];
        [self addSubview:self.textLabel];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(0);
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
            make.height.mas_equalTo(14);
        }];
        self.textLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightBold];
        self.textLabel.textColor = [UIColor whiteColor];
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        
        /// textField
        self.textField = [[UITextField alloc] init];
        [self addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.textLabel.mas_right).with.offset(10);
            make.right.equalTo(self.mas_right).with.offset(-10);
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(100, 30));
        }];
        self.textField.layer.borderWidth = 2;
        self.textField.layer.borderColor = [UIColor whiteColor].CGColor;
        self.textField.layer.cornerRadius = 10;
        self.textField.layer.masksToBounds = YES;
        self.textField.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        self.textField.textColor = [UIColor whiteColor];
        self.textField.leftView = leftView;
    }
    return self;
}

@end
