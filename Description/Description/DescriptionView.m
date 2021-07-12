//
//  DescriptionView.m
//  Description
//
//  Created by 王潇 on 2021/7/12.
//

#import "DescriptionView.h"
#import <Masonry/Masonry.h>

//  距离左侧的距离
static CGFloat leftMargin = 20.0f;

@implementation DescriptionView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.model = [[DescriptionModel alloc] init];
        
        self.titleLabel = [[UILabel alloc] init];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(leftMargin);
            make.top.equalTo(self.mas_top).with.offset(0);
            make.height.mas_equalTo(22);
        }];
        self.titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:255/255.0];
        self.titleLabel.font = [UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold];
        self.titleLabel.text = self.model.titleText;
        
        self.styleLabel = [[UILabel alloc] init];
        [self addSubview:self.styleLabel];
        [self.styleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_left).with.offset(0);
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(8);
            make.height.mas_equalTo(17);
        }];
        self.styleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:255/255.0];
        self.styleLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightSemibold];
        self.styleLabel.text = self.model.styleText;
        
        self.circleView = [[UIView alloc] init];
        [self addSubview:self.circleView];
        [self.circleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.styleLabel.mas_right).with.offset(5);
            make.centerY.equalTo(self.styleLabel.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(4, 4));
        }];
        self.circleView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:255/255.0];
        self.circleView.layer.masksToBounds = YES;
        self.circleView.layer.cornerRadius = 2;
        
        self.tonalLabel = [[UILabel alloc] init];
        [self addSubview:self.tonalLabel];
        [self.tonalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.circleView.mas_right).with.offset(5);
            make.top.equalTo(self.styleLabel.mas_top).with.offset(0);
            make.height.mas_equalTo(17);
        }];
        self.tonalLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:255/255.0];
        self.tonalLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightSemibold];
        self.tonalLabel.text = self.model.tonalText;
        
        self.recommendView = [[UIView alloc] init];
        [self addSubview:self.recommendView];
        [self.recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.styleLabel.mas_bottom).with.offset(15);
            make.left.equalTo(self.styleLabel.mas_left).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(64, 25));
        }];
        self.recommendView.backgroundColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:0.3];
        self.recommendView.layer.masksToBounds = YES;
        self.recommendView.layer.cornerRadius = 6;
        self.recommendView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor;
        self.recommendView.layer.shadowOffset = CGSizeMake(0, 2);
        self.recommendView.layer.shadowRadius = 5;
        
        self.recommendLabel = [[UILabel alloc] init];
        [self.recommendView addSubview:self.recommendLabel];
        [self.recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.recommendView.mas_centerX).with.offset(0);
            make.centerY.equalTo(self.recommendView.mas_centerY).with.offset(0);
            make.height.mas_equalTo(15);
        }];
        self.recommendLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightSemibold];
        self.recommendLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:255/255.0];
        self.recommendLabel.text = self.model.recommendText;
        self.recommendLabel.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}

@end


@implementation DescriptionModel

- (instancetype) init {
    self = [super init];
    if (self) {
        self.titleText = @"变色龙 CBPK";
        self.styleText = @"胶片风格";
        self.tonalText = @"紫色色调";
        self.recommendText = @"适合街景";
    }
    return self;
}

@end
