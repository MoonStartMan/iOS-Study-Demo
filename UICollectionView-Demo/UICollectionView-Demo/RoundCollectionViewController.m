//
//  RoundCollectionViewController.m
//  UICollectionView-Demo
//
//  Created by 王潇 on 2021/1/26.
//

#import "RoundCollectionViewController.h"
#import "RoundUIcollectionViewFlowLayout.h"

@interface RoundCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView* roundCollectionView;

@end

@implementation RoundCollectionViewController

- (instancetype) initWithCollectionViewLayout:(RoundUIcollectionViewFlowLayout *)layout {
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.title = @"DEMO3";
        self.view.backgroundColor = [UIColor whiteColor];
        self.roundCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        self.roundCollectionView.delegate = self;
        self.roundCollectionView.dataSource = self;
        [self.roundCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellId"];
        [self.view addSubview:self.roundCollectionView];
    }
    return self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [self.roundCollectionView dequeueReusableCellWithReuseIdentifier:@"CellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 25;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
