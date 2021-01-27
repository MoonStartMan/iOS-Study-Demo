//
//  RoundUIcollectionViewFlowLayout.m
//  UICollectionView-Demo
//
//  Created by 王潇 on 2021/1/26.
//

#import "RoundUIcollectionViewFlowLayout.h"

@interface RoundUIcollectionViewFlowLayout()

@property (nonatomic, strong) NSMutableArray* attributeArray;

@end

@implementation RoundUIcollectionViewFlowLayout

- (void)prepareLayout {
    _itemCount = (int)[self.collectionView numberOfItemsInSection:0];
    self.attributeArray = [[NSMutableArray alloc] init];
    CGFloat radius = MIN(self.collectionView.frame.size.width, self.collectionView.frame.size.height)/2;
    CGPoint center = CGPointMake(self.collectionView.frame.size.width/2, self.collectionView.frame.size.height/2);
    for (int i = 0; i< _itemCount; i++) {
        UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        attributes.size = CGSizeMake(50, 50);
        CGFloat x = center.x + cosf(2*M_PI/_itemCount*i)*(radius-25);
        CGFloat y = center.y + sinf(2*M_PI/_itemCount*i)*(radius-25);
        attributes.center = CGPointMake(x, y);
        [_attributeArray addObject:attributes];
    }
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return _attributeArray;
}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return _attributeArray[indexPath.item];
//}

- (CGSize)collectionViewContentSize {
    return self.collectionView.frame.size;
}

@end
