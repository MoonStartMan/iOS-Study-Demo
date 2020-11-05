//
//  BulletManager.h
//  barrage
//
//  Created by 王潇 on 2020/10/31.
//

#import <Foundation/Foundation.h>

@class BulletView;
NS_ASSUME_NONNULL_BEGIN

@interface BulletManager : NSObject

@property (nonatomic, copy) void(^generateViewBlock)(BulletView *view);

//  弹幕开始执行
- (void)start;

//  弹幕停止执行
- (void)stop;

@end

NS_ASSUME_NONNULL_END
