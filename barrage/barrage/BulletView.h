//
//  BulletView.h
//  barrage
//
//  Created by 王潇 on 2020/10/31.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MoveStatus) {
    Start,
    Enter,
    End
};

NS_ASSUME_NONNULL_BEGIN

@interface BulletView : UIView

@property(nonatomic, assign) int trajectory;    //  弹道
@property(nonatomic, copy) void (^moveStatusBlock)();   //  弹幕状态回调

//  初始化弹幕
- (instancetype)initWithComment: (NSString *) comment;

//  开始动画
- (void)startAnimation;

//  结束动画
- (void)stopAnimation;

@end

NS_ASSUME_NONNULL_END
