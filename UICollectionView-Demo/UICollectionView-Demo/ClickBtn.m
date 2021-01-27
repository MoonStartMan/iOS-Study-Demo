//
//  ClickBtn.m
//  UICollectionView-Demo
//
//  Created by 王潇 on 2021/1/27.
//

#import "ClickBtn.h"
#import <Masonry/Masonry.h>

@implementation ClickBtn

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.textLabel = [[UILabel alloc] init];
        [self addSubview:self.textLabel];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).with.offset(0);
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
        }];
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.textColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

@end
