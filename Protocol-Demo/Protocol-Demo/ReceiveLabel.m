//
//  ReceiveLabel.m
//  Protocol-Demo
//
//  Created by 王潇 on 2021/3/5.
//

#import "ReceiveLabel.h"

@interface ReceiveLabel()

@property (nonatomic, assign) UIEdgeInsets textInsets;  //  控制字体与控件边界的间隙

@end

@implementation ReceiveLabel

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.textColor = [UIColor redColor];
        self.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightBold];
        self.textInsets = UIEdgeInsetsMake(0.f, 20.0f, 0.f, 0.f);
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}

@end
