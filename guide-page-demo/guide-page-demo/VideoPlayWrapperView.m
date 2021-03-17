//
//  VideoPlayWrapperView.m
//  guide-page-demo
//
//  Created by 王潇 on 2021/3/17.
//

#import "VideoPlayWrapperView.h"
#import "VideoPlayView.h"
@import AVFoundation;

@interface VideoPlayWrapperView()

@property (nonatomic, strong) VideoPlayView *videoView;

@end

@implementation VideoPlayWrapperView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tapGesture];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture
{
    if (self.didClickBlock) {
        self.didClickBlock();
    }
}

+ (CGSize)getVideoFrameSizeByFileName:(NSString *)fileName{
    return [VideoPlayView getVideoFrameSizeByFileName:fileName];
}

- (void)setPlayerItemByFileName:(NSString *)name {
    UIImage *firstFrame = [self captureFirstFrameOfVideo:name];
    self.image = firstFrame;
    self.videoView.alpha = 0;
    [self.videoView setPlayerItemByFileName:name];
    CGFloat waitingSeconds = 0.2;
    if([UIScreen mainScreen].bounds.size.height <= 480) {
        waitingSeconds = 1.0;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(waitingSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.videoView.alpha = 1;
    });
}

- (void)play {
    [self.videoView play];
}

- (void)pause {
    [self.videoView pause];
}

- (void)setPlayerItemsByFileNameArray:(NSArray *)names {
    [self.videoView setPlayerItemsByFileNameArray: names];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.videoView.frame = self.bounds;
}

- (VideoPlayView *)videoView {
    if (!_videoView) {
        _videoView = [VideoPlayView new];
        [self addSubview: _videoView];
    }
    return _videoView;
}

- (void)setPlayFinisheBlock:(dispatch_block_t)playFinisheBlock {
    self.videoView.playFinishedBlock = playFinisheBlock;
}

#pragma mark -- private method
- (UIImage *)captureFirstFrameOfVideo:(NSString *)fileName{
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    if (!urlStr) {
        NSLog(@"没有找到视频文件:%@",fileName);
        return nil;
    }
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    AVAsset *asset = [AVAsset assetWithURL:url];
    AVAssetImageGenerator *imageGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    if (imageGen) {
        imageGen.appliesPreferredTrackTransform = YES;
        CMTime actualTime;
        CGImageRef cgImage = [imageGen copyCGImageAtTime:CMTimeMakeWithSeconds(0, 30) actualTime:&actualTime error:NULL];
        if (cgImage) {
            UIImage *image = [UIImage imageWithCGImage:cgImage];
            CGImageRelease(cgImage);
            return image;
        }
    }
    return nil;
}

@end
