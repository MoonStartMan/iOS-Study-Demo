//
//  VideoPlayWrapperView.h
//  guide-page-demo
//
//  Created by 王潇 on 2021/3/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayWrapperView : UIImageView

@property (nonatomic, strong) dispatch_block_t playFinisheBlock;
@property (nonatomic, copy, nullable) dispatch_block_t didClickBlock;

+ (CGSize)getVideoFrameSizeByFileName:(NSString *)fileName;
- (void)setPlayerItemByFileName:(NSString *)name;
- (void)play;
- (void)pause;
- (void)setPlayerItemsByFileNameArray:(NSArray *)names;

@end

NS_ASSUME_NONNULL_END
