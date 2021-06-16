//
//  ViewController.m
//  carousel-Demo
//
//  Created by 王潇 on 2021/6/5.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "CollectionViewCell.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

#define MaxSections 100

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.pageControl];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, kHeight));
    }];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    //  添加定时器 实现轮播功能
    [self addTimer];
}

- (void)addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextPage) userInfo:NULL repeats:YES];
}

//  定时器内容
- (void)nextPage {
    // 获取当前的 indexPath
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPathSet = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:MaxSections / 2];
    
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathSet atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    //  设置下一个滚动的item的indexPath
    NSInteger nextItem = currentIndexPathSet.item + 1;
    NSInteger nextSection = currentIndexPathSet.section;
    if (nextItem == self.dataArray.count) {
        //  当item等于轮播图的总个数的时候
        //  item等于0，分区加1
        //  未达到的时候永远在50分区中
        nextItem = 0;
        nextSection ++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark ScrollView 代理方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //  添加定时器
    [self addTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //  移除定时器
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //  滚动时 动态设置 pageControl.currentPage
    int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5) % self.dataArray.count;
    self.pageControl.currentPage = page;
}


#pragma mark Init
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(kWidth, kHeight);
        layout.minimumLineSpacing = 0.000001f;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        //  设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        //  设置不展示滑动条
        _collectionView.showsHorizontalScrollIndicator = NO;
        //  设置整页滑动
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        //  设置当前collectionView 到哪个位置(indexPath row 0 section 取中间(50个))
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:MaxSections / 2] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.center = CGPointMake(kWidth / 2, kHeight - 100);
        pageControl.numberOfPages = self.dataArray.count;
        pageControl.bounds = CGRectMake(0, 0, 150, 50);
        pageControl.enabled = NO;
        pageControl.pageIndicatorTintColor = [UIColor blueColor];
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [self.view addSubview:pageControl];
        _pageControl = pageControl;
    }
    return _pageControl;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
            @{
                @"image":@"1.jpg",
            },
            @{
                @"image":@"2.jpg",
            },
            @{
                @"image":@"3.jpg",
            },
            @{
                @"image":@"4.jpg",
            },
            @{
                @"image":@"5.jpg",
            },
        ];
    }
    return _dataArray;
}

#pragma mark UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return MaxSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.dataArray[indexPath.row][@"image"]];
    return cell;
}


@end
