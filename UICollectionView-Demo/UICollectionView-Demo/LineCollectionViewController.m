//
//  LineCollectionViewController.m
//  UICollectionView-Demo
//
//  Created by 王潇 on 2021/1/21.
//

#import "LineCollectionViewController.h"
#import <Masonry/Masonry.h>

@interface LineCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *lineCollectionView;

@end

@implementation LineCollectionViewController

//-(void)viewDidLoad {
//    [super viewDidLoad];
    //  设置流水布局
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //  UICollectionViewFlowLayout流水布局的内部成员属性有以下:
    
    /**
        @property(nonatomic) CGFloat minimumLineSpacing;
        @property(nonatomic) CGFloat minimumInteritemSpacing;
        @property(nonatomic) CGSize itemSize;
        @property(nonatomic) CGSize estimatedItemSize NS_AVAILABLE_IOS(8_0);    // defaults to CGSizeZero - setting a non-zero size enables cells that self-size via -preferredLayoutAttributesFittingAttributes:
        @property(nonatomic) UICollectionViewScrollDirection scrollDirection;   //  default is UICollectionViewScrollDirectionVertical
        @property(nonatomic) CGSize headerReferenceSize;
        @property(nonatomic) CGSize footerReferenceSize;
        @property(nonatomic) UIEdgeInsets sectionInset;
     */
    
//    //  定义大小
//    layout.itemSize = CGSizeMake(100, 100);
//    //  设置最小行间距
//    layout.minimumLineSpacing = 2;
//    //  设置垂直间距
//    layout.minimumInteritemSpacing = 2;
//    //  设置滚动方向(默认垂直滚动)
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//
//    UICollectionView *myCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
//
//    myCollectionView.backgroundColor = [UIColor grayColor];
//    myCollectionView.dataSource = self;
//    myCollectionView.delegate = self;
//    [self.view addSubview:myCollectionView];
//    //  注册cell
//    [myCollectionView registerClass:[LineCollectionViewCell class] forCellWithReuseIdentifier: NSStringFromClass([LineCollectionViewCell class])];
//}

- (instancetype) initWithCollectionViewLayout:(UICollectionViewFlowLayout *)layout {
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat width = self.view.frame.size.width/4 - 15;
        layout.itemSize = CGSizeMake(width, 100);
        layout.minimumInteritemSpacing = (self.view.frame.size.width - width*4 - 30) / 4;
        layout.minimumLineSpacing = 10;
        self.lineCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        self.lineCollectionView.delegate = self;
        self.lineCollectionView.dataSource = self;
        [self.lineCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellId"];
        [self.view addSubview: self.lineCollectionView];
    }
    return self;
}

#pragma mack - collection delegate

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 15, 0, 15);
}

- (UICollectionViewCell *)collectionView: (UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.lineCollectionView dequeueReusableCellWithReuseIdentifier:@"CellId" forIndexPath:indexPath];
    for (UIView *view in [cell.contentView subviews]) {
        [view removeFromSuperview];
    }
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    UILabel* cellLabel = [[UILabel alloc] init];
    [cell.contentView addSubview: cellLabel];
    [cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(cell.mas_centerX).with.offset(0);
        make.centerY.equalTo(cell.mas_centerY).with.offset(0);
    }];
    
    cellLabel.font = [UIFont systemFontOfSize:20.0f];
    cellLabel.textColor = [UIColor whiteColor];
    cellLabel.text = [NSString stringWithFormat:@"%ld",1 + indexPath.row];
    return cell;
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
