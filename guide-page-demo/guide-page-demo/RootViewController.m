//
//  ViewController.m
//  guide-page-demo
//
//  Created by 王潇 on 2021/3/15.
//

#import "RootViewController.h"
#import "TextUIView.h"
#import "GuidePageControl.h"
#import "TextViewModel.h"
#import "DeviceCapabilityRequestView.h"
#import <Masonry/Masonry.h>
#import "GuideVideoUICollectionViewFlowLayout.h"
#import "GuideVideoCell.h"
#import "UIView+VLAdditions.h"

#define HaveShowedUserGuideKey @"HaveShowedUserGuideKey"

#define VideoCollectionViewReuseIdentifier @"VideoCollectionViewCell"

#define MinDistance 30.0

@interface RootViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
/// 内容视图
@property (nonatomic, strong) UIView* contentContainerView;
/// 背景色
@property (nonatomic) UIImageView *bgView;
/// 视频
@property (nonatomic) UICollectionView *collectionView;
/// 视频下方的描述文字
@property (nonatomic) GuideExplainTextView *textExplainView;
/// 滚动条
@property (nonatomic) GuidePageControl *guidePageControl;
/// mix logo
@property (nonatomic) UIImageView *logoView;
/// 立即体验
@property (nonatomic) UIButton *tryAtOnceButton;

/// config
@property (nonatomic, copy) NSArray<NSString *> *videoFileName;
@property (nonatomic, copy) NSArray<TextViewModel *> *textExplainViewConfigs;
@property (nonatomic) CGFloat startDragOffsetX;
@property (nonatomic) CGFloat endDragOffsetX;

@property (nonatomic, strong) DeviceCapabilityRequestView *capbilityRequestView;

@end

@implementation RootViewController

#pragma mark - lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupConfigs];
    [self setupViews];
}

- (void)setupConfigs {
    self.videoFileName = @[@"magic_sky.mp4",
                           @"advance_editing.mp4",
                           @"poster.mp4"];
    NSMutableArray *textExplainViewConfigs = [[NSMutableArray alloc] init];
    NSArray<NSString *> *titleImageNames = @[@"user_guide_sky",
                                             @"user_guide_advance_edit",
                                             @"user_guide_poster"];
    NSArray<NSString *> *titles = @[@"魔法天空滤镜",
                                       @"高级编辑",
                                       @"照片海报"];
    NSArray<NSString *> *subTitles = @[@"云霞、飞鸟、明月、极光…多款魔法天空让照片变身奇幻世界",
                                   @"曲线、HSL色相/饱和度、色彩平衡、色彩分离…使用高级编辑工具进一步优化照片",
                                   @"文字、贴纸、边框、背景、图形一键应用 用照片讲述生动故事"];
    for (NSInteger i = 0, j = titles.count; i < j; i++) {
        TextViewModel *model = [[TextViewModel alloc] init];
        model.title = titles[i];
        if (subTitles.count > i) {
            model.subTitle = subTitles[i];
        }
        
        if (titleImageNames.count > i) {
            model.titleImageName = titleImageNames[i];
        }
        
        [textExplainViewConfigs addObject:model];
    }
    self.textExplainViewConfigs = textExplainViewConfigs;
}

- (void)setupViews {
    self.contentContainerView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview: self.contentContainerView];
    [self.contentContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didRecognizedGesture)];
    
    [self.contentContainerView addGestureRecognizer: gesture];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self locateToIndex:0];
    });
    
    self.bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_guide_bg_X"]];
    self.bgView.contentMode = UIViewContentModeScaleAspectFill;
    self.bgView.clipsToBounds = YES;
    [self.contentContainerView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[GuideVideoUICollectionViewFlowLayout alloc] init]];
    self.collectionView.backgroundColor = UIColor.clearColor;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[GuideVideoCell class] forCellWithReuseIdentifier:VideoCollectionViewReuseIdentifier];
    [self.contentContainerView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(240);
        make.top.mas_equalTo(140.0);
    }];
    
    self.textExplainView = [[GuideExplainTextView alloc] initWithConfigs:self.textExplainViewConfigs];
    [self.contentContainerView addSubview:self.textExplainView];
    [self.textExplainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.collectionView.mas_bottom).offset(39);
        make.size.mas_equalTo(self.textExplainView.size);
        make.centerX.mas_equalTo(0);
    }];
    
    self.guidePageControl = [[GuidePageControl alloc] initWithCellCount:3];
    [self.contentContainerView addSubview:self.guidePageControl];
    [self.guidePageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.guidePageControl.size);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.textExplainView.mas_bottom).offset(40);
    }];
    
    CGFloat bottom = 40;
    if (@available(iOS 11, *)) {
        bottom += self.view.window.safeAreaInsets.bottom;
    }
    self.logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_guide_logo"]];
    [self.contentContainerView addSubview:self.logoView];
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-bottom);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    self.tryAtOnceButton = [[UIButton alloc] init];
    self.tryAtOnceButton.alpha = 0;
    self.tryAtOnceButton.titleLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightMedium];
    [self.tryAtOnceButton setTintColor:[UIColor colorWithRed:245/255.0 green:247/255.0 blue:250/255.0 alpha:1.0]];
    [self.tryAtOnceButton setTitle:@"继续" forState:UIControlStateNormal];
    CAGradientLayer *glayer = [CAGradientLayer layer];
    glayer.frame = CGRectMake(0, 0, 164, 48);
    glayer.cornerRadius = 6;
    glayer.startPoint = CGPointMake(1, 0.5);
    glayer.endPoint = CGPointMake(0, 0.5);
    glayer.locations = @[@(0), @(1)];
    glayer.colors = @[(__bridge id)[UIColor colorWithRed:113/255.0 green:130/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:61/255.0 green:75/255.0 blue:255/255.0 alpha:1.0].CGColor];
    [self.tryAtOnceButton.layer insertSublayer:glayer atIndex:0];
    [self.contentContainerView addSubview:self.tryAtOnceButton];
    [self.tryAtOnceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(glayer.frame.size);
        make.bottom.mas_equalTo(-bottom);
    }];
    [self.tryAtOnceButton addTarget:self action:@selector(didTapTryAtOnceButton:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - actions
- (void)didTapTryAtOnceButton:(UIButton *)btn {
    
}

- (void)didRecognizedGesture:(UIPanGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateEnded:
        {
            CGPoint point = [gesture translationInView:self.view];
            NSInteger curIndex = self.guidePageControl.currentPageIndex;
            if (point.x <= -MinDistance) {
                curIndex += 1;
            } else if (point.x >= MinDistance) {
                curIndex -= 1;
            }
            if (curIndex < 0 || curIndex > self.videoFileName.count - 1) {
                return;
            }
            [self locateToIndex:curIndex];
        }
            break;
        default:
            break;
    }
}

#pragma mark - private method

- (NSInteger)computeCurrentIndex {
    GuideVideoUICollectionViewFlowLayout *layout = (GuideVideoUICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGFloat unitWidth = layout.itemSize.width * 1.5 + layout.minimumLineSpacing - self.collectionView.width/2;
    NSInteger curIdx = (self.collectionView.contentOffset.x - layout.sectionInset.left)/unitWidth;
    CGFloat remainX = (self.collectionView.contentOffset.x - layout.sectionInset.left) - unitWidth * curIdx;
    BOOL isScrollToRight = self.endDragOffsetX > self.startDragOffsetX;
    if ((isScrollToRight && remainX > MinDistance) || (!isScrollToRight && (unitWidth - remainX) < MinDistance)) {
        curIdx += 1;
    }
    return MAX(0, MIN(self.videoFileName.count - 1, curIdx));
}

- (void)locateToIndex:(NSInteger)index {
    NSInteger oldIndex = self.guidePageControl.currentPageIndex;
    if (index == self.videoFileName.count - 1) {
        [UIView animateWithDuration:0.15 animations:^{
            self.logoView.alpha = 0;
        }];
        [UIView animateKeyframesWithDuration:0.15 delay:0.15 options:0 animations:^{
            self.tryAtOnceButton.alpha = 1;
        } completion:nil];
    } else if (oldIndex == self.videoFileName.count - 1) {
        [UIView animateWithDuration:0.15 animations:^{
            self.tryAtOnceButton.alpha = 0;
        }];
        [UIView animateWithDuration:0.15 delay:0.15 options:0 animations:^{
            self.logoView.alpha = 1;
        } completion:nil];
    }
    
    GuideVideoUICollectionViewFlowLayout *layout = (GuideVideoUICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGFloat centerX = layout.sectionInset.left + layout.itemSize.width * index + layout.itemSize.width  / 2;
    centerX += index * layout.minimumLineSpacing;
    CGFloat offsetX = centerX - layout.collectionView.width / 2;
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    [self.textExplainView setCurrentPageIndex:index animated:YES];
    [self.guidePageControl setCurrentPageIndex:index animated:YES];
    
    for (GuideVideoCell *cell in self.collectionView.visibleCells) {
        [cell.videoView pause];
    }
    GuideVideoCell *cell = (GuideVideoCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [cell.videoView play];
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.videoFileName.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GuideVideoCell *cell = (GuideVideoCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:VideoCollectionViewReuseIdentifier forIndexPath:indexPath];
    if (indexPath.row < self.videoFileName.count) {
        [cell.videoView setPlayerItemByFileName:self.videoFileName[indexPath.row]];
    }
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.startDragOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView setContentOffset:self.collectionView.contentOffset animated:NO];
            [self locateToIndex:[self computeCurrentIndex]];
        });
    } else {
        [self locateToIndex:[self computeCurrentIndex]];
    }
    self.endDragOffsetX = scrollView.contentOffset.x;
}

#pragma mark - public

+ (BOOL)shouldShowUserGuide {
    return ![[NSUserDefaults standardUserDefaults] boolForKey:HaveShowedUserGuideKey];
}

+ (void)setUserGuideShowed:(BOOL)showed {
    [[NSUserDefaults standardUserDefaults] setBool:showed forKey:HaveShowedUserGuideKey];
}

#pragma mark - Lazy

@end
