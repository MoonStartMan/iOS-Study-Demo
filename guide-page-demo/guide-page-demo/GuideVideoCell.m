//
//  GuideVideoCell.m
//  guide-page-demo
//
//  Created by 王潇 on 2021/3/17.
//

#import "GuideVideoCell.h"
#import <Masonry/Masonry.h>

@implementation GuideVideoCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 10.f;
        self.layer.masksToBounds = YES;
        self.videoView = [[VideoPlayWrapperView alloc] init];
        [self.contentView addSubview:self.videoView];
        [self.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        return self;
    }
    return nil;
}

@end
