//
//  CollectionViewCell.m
//  carousel-Demo
//
//  Created by 王潇 on 2021/6/5.
//

#import "CollectionViewCell.h"
#import <Masonry/Masonry.h>

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

@end
