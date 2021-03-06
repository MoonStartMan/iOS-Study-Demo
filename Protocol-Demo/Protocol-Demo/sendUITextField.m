//
//  sendUITextField.m
//  Protocol-Demo
//
//  Created by 王潇 on 2021/3/4.
//

#import "sendUITextField.h"

@implementation sendUITextField

- (instancetype)initWithTextFiledName:(NSString *)name {
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 10;
        self.layer.borderWidth = 2;
        self.clipsToBounds = YES;
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:name attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:12.0f weight:UIFontWeightBold]}];
        self.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
        self.attributedPlaceholder = attrString;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.frame.size.height)];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = leftView;
        self.textColor = [UIColor blackColor];
    }
    return self;
}

@end
