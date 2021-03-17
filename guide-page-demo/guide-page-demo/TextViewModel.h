//
//  TextViewModel.h
//  guide-page-demo
//
//  Created by 王潇 on 2021/3/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextViewModel : NSObject

@property (nonatomic, copy) NSString *titleImageName;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subTitle;

@end

/// 新用户引导下方描述文字，带动画
@interface GuideExplainTextView: UIView

- (instancetype)initWithConfigs:(NSArray<TextViewModel *> *)configs;

/// 设置当前currentPageIndex
- (void)setCurrentPageIndex: (NSInteger)index animated:(BOOL)animated;

/// ratio取值[0-1],用于跟手效果,不会改变currentPageIndex的值
- (void)scrollToPageIndex:(NSInteger)index ratio:(CGFloat)ratio;

/// 当前cellindex
@property (nonatomic, readonly) NSInteger currentPageIndex;

@end

NS_ASSUME_NONNULL_END
