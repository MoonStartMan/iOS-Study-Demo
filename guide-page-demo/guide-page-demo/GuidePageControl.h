//
//  GuidePageControl.h
//  guide-page-demo
//
//  Created by 王潇 on 2021/3/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GuidePageControl : UIView

- (instancetype)initWithCellCount:(NSInteger)cellCout;

/// 设置当前currentPageIndex
- (void)setCurrentPageIndex:(NSInteger)index animated:(BOOL)animated;

/// radio取值[0-1]，用于跟手效果，不会改变currentPageIndex值
- (void)scrollToPageIndex:(NSInteger)index ratio:(CGFloat)ratio;

/// 当前cellindex
@property (nonatomic, readonly) NSInteger currentPageIndex;

@end

NS_ASSUME_NONNULL_END
