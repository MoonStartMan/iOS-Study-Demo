//
//  IrregularCollectionViewController.m
//  
//
//  Created by 王潇 on 2021/1/26.
//

#import "IrregularCollectionViewController.h"
#import "IrregularFlowLayout.h"

#import <Masonry/Masonry.h>

@interface IrregularCollectionViewController ()

@property (nonatomic, strong) UICollectionView* IrregularCollectionView;

@end

@implementation IrregularCollectionViewController

- (instancetype)initWithCollectionViewLayout:(IrregularFlowLayout *)layout {
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemCount = 100;
        layout.itemSize = CGSizeMake(100, 100);
        
        self.IrregularCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        self.IrregularCollectionView.delegate = self;
        self.IrregularCollectionView.dataSource = self;
        [self.IrregularCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellId"];
    }
    return self;
}

#pragma mark - collection dataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.IrregularCollectionView dequeueReusableCellWithReuseIdentifier:@"CellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    for (UIView *view in [cell.contentView subviews]) {
        [view removeFromSuperview];
    }
    UILabel *cellLabel = [[UILabel alloc] init];
    [cell.contentView addSubview:cellLabel];
    [cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(cell.mas_centerX).with.offset(0);
        make.centerY.equalTo(cell.mas_centerY).with.offset(0);
    }];
    
    cellLabel.font = [UIFont systemFontOfSize:20.0f];
    cellLabel.textColor = [UIColor whiteColor];
    cellLabel.text = [NSString stringWithFormat:@"%ld",1 + indexPath.row];
    return cell;
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%ld",indexPath.item);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
