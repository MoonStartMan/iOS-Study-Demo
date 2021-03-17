//
//  VideoPlayView.m
//  guide-page-demo
//
//  Created by 王潇 on 2021/3/17.
//

#import "VideoPlayView.h"
#import "CATransaction+Extension.h"
@import AVFoundation;

@interface VideoPlayView()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@property (nonatomic, strong) NSArray *videoPlayItemsArray;

@end

@implementation VideoPlayView

- (void)layoutSubviews
{
    [super layoutSubviews];
    [CATransaction performWithoutAnimation:^{
        self.playerLayer.frame = self.bounds;
    }];
}

- (void)addNotification
{
    //  给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

- (void)playbackFinished:(NSNotification *)notification
{
    if (self.playFinishedBlock) {
        self.playFinishedBlock();
    } else {
        if (self.videoPlayItemsArray.count > 1) {
            [self removeNotification];
            NSInteger index = [self.videoPlayItemsArray indexOfObject:self.playerItem];
            if (index == self.videoPlayItemsArray.count - 1) {
                index = 0;
            } else {
                index ++;
            }
            self.playerItem = self.videoPlayItemsArray[index];
            [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
            [self addNotification];
        }
        [self.player seekToTime:CMTimeMake(0, 1)];
        [self.player play];
    }
}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc
{
    [self removeNotification];
}

#pragma mark - Public method

- (void)setPlayerItemByFileName:(NSString *)name
{
    [self removeNotification];
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    if (!urlStr) {
        NSLog(@"没有找到视频文件: %@", name);
        return;
    }
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    self.playerItem = [AVPlayerItem playerItemWithURL:url];
    
    if (!self.player) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.playerLayer) {
                    [self.playerLayer removeFromSuperlayer];
                }
                self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
                self.playerLayer.frame = self.bounds;
                self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
                [self.layer addSublayer:self.playerLayer];
                [self.player seekToTime:CMTimeMake(0, 1)];
                [self addNotification];
            });
        });
    } else {
        [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
        [self.player seekToTime:CMTimeMake(0, 1)];
        [self addNotification];
    }
}

- (void)setPlayerItemsByFileNameArray:(NSArray *)names
{
    [self removeNotification];
    NSMutableArray *itemsArray = [NSMutableArray array];
    for (NSString *fileName in names) {
        NSString *urlStr = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        if (!urlStr) {
            NSLog(@"没有找到视频文件: %@", fileName);
            return;
        }
        NSURL *url = [NSURL fileURLWithPath:urlStr];
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
        [itemsArray addObject:item];
    }
    self.videoPlayItemsArray = itemsArray;
    
    self.playerItem = [itemsArray firstObject];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    if (self.playerLayer) {
        [self.playerLayer removeFromSuperlayer];
    }
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = self.bounds;
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.layer addSublayer:self.playerLayer];
    [self addNotification];
}

- (void)play
{
    [self.player play];
}

- (void)pause
{
    [self.player pause];
}

+ (CGSize)getVideoFrameSizeByFileName:(NSString *)fileName
{
    CGSize size = CGSizeZero;
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    if (!urlStr) {
        NSLog(@"没有找到视频文件: %@.mov", fileName);
        return size;
    }
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    AVAsset *asset = [AVAsset assetWithURL:url];
    NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    if (tracks.count > 0) {
        AVAssetTrack *videoTrack = [tracks firstObject];
        size = videoTrack.naturalSize;
    }
    return size;
}

@end
