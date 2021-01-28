//
//  CollectionViewController4.m
//  UICollectionView-Demo
//
//  Created by 王潇 on 2021/1/27.
//

#import "CollectionViewController4.h"
#import "FlowLayout4.h"

@interface CollectionViewController4 ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView* layoutCollectionView;
@property (nonatomic, assign) NSInteger i;

@end

@implementation CollectionViewController4


- (instancetype) initWithCollectionViewLayout:(FlowLayout4 *)layout {
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.title = @"DEMO4";
        self.i = 100;
        self.layoutCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 400, 400) collectionViewLayout:layout];
        self.layoutCollectionView.hidden = YES;
        self.layoutCollectionView.delegate = self;
        self.layoutCollectionView.dataSource = self;
        [self.layoutCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellId"];
        [self.view addSubview:self.layoutCollectionView];
        self.layoutCollectionView.center = self.view.center;
        
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(chageContentOffset) userInfo:nil repeats:YES];
    }
    return self;
}

-(void)chageContentOffset{
    self.i = self.i + 100;
    self.layoutCollectionView.contentOffset = CGPointMake(0 , self.i);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell  = [self.layoutCollectionView dequeueReusableCellWithReuseIdentifier:@"CellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 80)];
    label.text = [NSString stringWithFormat:@"我是第%ld行",(long)indexPath.row];
    [cell.contentView addSubview:label];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //小于半屏 则放到最后一屏多半屏
    if (scrollView.contentOffset.y < 200) {
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y+10*400);
        //大于最后一屏多一屏 放回第一屏
    }else if(scrollView.contentOffset.y > 11 * 400){
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y-10*400);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
