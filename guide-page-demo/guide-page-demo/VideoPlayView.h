//
//  VideoPlayView.h
//  guide-page-demo
//
//  Created by 王潇 on 2021/3/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayView : UIView

@property (nonatomic, strong) dispatch_block_t playFinishedBlock;

+ (CGSize)getVideoFrameSizeByFileName:(NSString *)fileName;

- (void)setPlayerItemByFileName:(NSString *)name;

- (void)play;

- (void)pause;

/**
    循环播放多个视频
 
    @param names 视频名称
 */

- (void)setPlayerItemsByFileNameArray:(NSArray *)names;

@end

NS_ASSUME_NONNULL_END
