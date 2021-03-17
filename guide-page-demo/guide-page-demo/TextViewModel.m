//
//  TextViewModel.m
//  guide-page-demo
//
//  Created by 王潇 on 2021/3/15.
//

#import "TextViewModel.h"
#import "UIView+VLAdditions.h"

#define ViewWidth ([UIScreen mainScreen].bounds.size.width)

@interface GuideExplainTextView()

@property (nonatomic, copy) NSArray<TextViewModel *> *configs;

@property (nonatomic) NSMutableArray<UIView *> *titleViews;

@property (nonatomic) NSMutableArray<UIView *> *subTitleViews;
/// 当前cellindex
@property (nonatomic) NSInteger currentPageIndex;

@end

@implementation GuideExplainTextView

- (instancetype)initWithConfigs:(NSArray<TextViewModel *> *)configs {
    if (self = [super initWithFrame:CGRectZero]) {
        self.clipsToBounds = YES;
        _configs = configs;
        _titleViews = [[NSMutableArray alloc] init];
        _subTitleViews = [[NSMutableArray alloc] init];
        CGFloat viewHeight = 0;
        CGFloat centerX = ViewWidth / 2.0;
        for (TextViewModel *cfg in configs) {
            UIView *titleView;
            UIImage *img = [UIImage imageNamed:cfg.titleImageName];
            UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
            imgView.size = CGSizeMake(21/img.size.height * img.size.width, 21);
            imgView.centerX = centerX;
            [self addSubview: imgView];
            [_titleViews addObject: imgView];
            titleView = imgView;
            
            UILabel *subTitleLabel = [self getSubTitleLabel: cfg];
            subTitleLabel.centerX = centerX;
            subTitleLabel.top = titleView.bottom + floor((10) / 667.0 * [UIScreen mainScreen].bounds.size.height);
            [self addSubview:subTitleLabel];
            [_subTitleViews addObject:subTitleLabel];
            
            viewHeight = MAX(viewHeight, subTitleLabel.bottom);
            centerX += ViewWidth;
        }
        self.size = CGSizeMake(ViewWidth, viewHeight);
        return self;
    }
    return nil;
}

- (UILabel *)getSubTitleLabel: (TextViewModel *)model {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:model.subTitle ?: @""];
    UIFont *font = [UIFont systemFontOfSize:14];
    if (font) {
        [attrStr addAttributes:@{NSFontAttributeName: font} range:NSMakeRange(0, attrStr.length)];
    }
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    style.maximumLineHeight = 25;
    style.minimumLineHeight = 19;
    [attrStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attrStr.length)];
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.attributedText = attrStr;
    lbl.textColor = [UIColor colorWithRed:245/255.0 green:247/255.0 blue:250/255.0 alpha:1.0];
    
    CGSize s = [attrStr boundingRectWithSize:CGSizeMake((ViewWidth - 37.0 *2), MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                     context:nil].size;
    lbl.size = CGSizeMake(ceil(s.width), ceil(s.height));
    return lbl;
}

#pragma mark - public

- (void)setCurrentPageIndex:(NSInteger)index animated:(BOOL)animated {
    if (index >= self.titleViews.count) {
        index = self.titleViews.count - 1;
    }
    
    if (index < 0) {
        index = 0;
    }
    
    if (self.titleViews.count < 2 || index == self.currentPageIndex) {
        return;
    }
    
    for (NSInteger i = 0, j = self.titleViews.count; i < j; i++) {
        UIView *titleView = self.titleViews[i];
        UIView *subTitleView = i < self.subTitleViews.count ? self.subTitleViews[i] : nil;
        CGFloat centerX = ViewWidth / 2 + (i - index) * ViewWidth;
        [UIView animateWithDuration:0.5 animations:^{
            titleView.centerX = centerX;
        }];
        [UIView animateWithDuration:0.3 delay:0.2 options:0 animations:^{
            subTitleView.centerX = centerX;
        } completion:nil];
    }
}

- (void)scrollToPageIndex:(NSInteger)index ratio:(CGFloat)ratio {
    if (ratio < 0) {
        ratio = 0;
    }
    
    if (ratio > 1) {
        ratio = 1;
    }
    
    if (index >= self.titleViews.count) {
        index = self.titleViews.count - 1;
    }
    
    if (index < 0) {
        index = 0;
    }
    
    if (self.titleViews.count < 2) {
        return;
    }
    
    for (NSInteger i = 0, j = self.titleViews.count; i < j; i++) {
        UIView *titleView = self.titleViews[i];
        UIView *subTitleView = i < self.subTitleViews.count ? self.subTitleViews[i] : nil;
        
        CGFloat centerX = ViewWidth / 2 + (i - self.currentPageIndex) * ViewWidth;
        CGFloat titleLabelTranslateX = ratio * ViewWidth;
        CGFloat subTitleLabelTranslateX = 0;
        /// titleView先动
        if (ratio > 0.4) {
            subTitleLabelTranslateX = (ratio - 0.4) / 0.6 * ViewWidth;
        }
        
        if (index > self.currentPageIndex) {
            titleView.centerX = centerX + titleLabelTranslateX;
            subTitleView.centerX = centerX + subTitleLabelTranslateX;
        } else {
            titleView.centerX = centerX - titleLabelTranslateX;
            subTitleView.centerX = centerX - subTitleLabelTranslateX;
        }
    }
    
    if (ratio >= 1) {
        self.currentPageIndex = index;
    }
}

@end


@implementation TextViewModel

@end
