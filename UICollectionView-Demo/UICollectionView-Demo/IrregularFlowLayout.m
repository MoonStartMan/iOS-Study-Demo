//
//  IrregularFlowLayout.m
//  UICollectionView-Demo
//
//  Created by 王潇 on 2021/1/26.
//

#import "IrregularFlowLayout.h"

@interface IrregularFlowLayout()

@property (nonatomic, strong) NSMutableArray* attributeArray;

@end

@implementation IrregularFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    _attributeArray = [[NSMutableArray alloc] init];
    CGFloat kWidth = ([UIScreen mainScreen].bounds.size.width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing) / 2;
    
    CGFloat kHeight[2] = {self.sectionInset.top, self.sectionInset.bottom};
    
    for (int i = 0; i < _itemCount; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:index];

        CGFloat rHeight = arc4random()%150+40;
        NSInteger rWidth = 0;
        
        if (kHeight[0] < kHeight[1]) {
            kHeight[0] = kHeight[0] + rHeight + self.minimumLineSpacing;
            rWidth = 0;
        } else {
            kHeight[1] = kHeight[1] + rHeight + self.minimumLineSpacing;
            rWidth = 1;
        }
        
        attributes.frame = CGRectMake(self.sectionInset.left + (self.minimumInteritemSpacing + kWidth) * rWidth, kHeight[rWidth] - rHeight - self.minimumLineSpacing, kWidth, rHeight);
        
        [_attributeArray addObject:attributes];
    }
    
    if (kHeight[0] > kHeight[1]) {
        self.itemSize = CGSizeMake(kWidth, (kHeight[0] - self.sectionInset.top)*2/_itemCount - self.minimumLineSpacing);
    } else {
        self.itemSize = CGSizeMake(kWidth, (kHeight[1] - self.sectionInset.top)*2/_itemCount - self.minimumLineSpacing);
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _attributeArray[indexPath.item];
}

@end
