//
//  CollectionViewController5.m
//  UICollectionView-Demo
//
//  Created by 王潇 on 2021/1/28.
//

#import "CollectionViewController5.h"
#import "FlowLayout5.h"

@interface CollectionViewController5 ()

@property (nonatomic, strong) UICollectionView* collectionView5;

@end

@implementation CollectionViewController5

- (instancetype) initWithCollectionViewLayout:(FlowLayout5 *)layout {
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.title = @"DEMO5";
        self.collectionView5 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 300, 300) collectionViewLayout:layout];
        self.collectionView5.delegate = self;
        self.collectionView5.dataSource = self;
        [self.collectionView5 registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellId"];
        self.collectionView5.hidden = YES;
        [self.view addSubview:self.collectionView5];
        self.collectionView5.center = self.view.center;
        self.collectionView5.backgroundColor = [UIColor whiteColor];
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeContentOffset) userInfo:nil repeats:YES];
    }
    return self;
}

- (void) changeContentOffset{
    self.collectionView5.contentOffset = CGPointMake(arc4random()%(11*300), arc4random()%(10*300));
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell  = [self.collectionView5 dequeueReusableCellWithReuseIdentifier:@"CellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
