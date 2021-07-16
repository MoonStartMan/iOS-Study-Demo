//
//  LoadingView.h
//  Loading-Demo
//
//  Created by 王潇 on 2021/7/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoadingView : UIView

//  当前照片索引
@property (nonatomic, assign) CGFloat currentIndex;
//  处理照片总数量
@property (nonatomic, assign) CGFloat totalPhotoCount;
//  进度
@property(nonatomic, assign) CGFloat progress;
//  更新圆环进度
- (void)updateProgress;

@end

NS_ASSUME_NONNULL_END
