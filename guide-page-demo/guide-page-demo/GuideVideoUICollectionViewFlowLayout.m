//
//  GuideVideoUICollectionViewFlowLayout.m
//  guide-page-demo
//
//  Created by 王潇 on 2021/3/17.
//

#import "GuideVideoUICollectionViewFlowLayout.h"

@implementation GuideVideoUICollectionViewFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(7.5, 29+9.5, 7.5, 29+9.5);
        self.minimumLineSpacing = 29.0;
        self.minimumInteritemSpacing = 0;
        self.itemSize = CGSizeMake(301, 255);
        return self;
    }
    return nil;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [super layoutAttributesForItemAtIndexPath:indexPath];
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
    NSArray<UICollectionViewLayoutAttributes *> *cellAtttrs = [[NSArray alloc] initWithArray:attrs copyItems:YES];
    for (UICollectionViewLayoutAttributes *attr in cellAtttrs) {
        CGFloat distance = fabs(attr.center.x - self.collectionView.contentOffset.x - self.collectionView.frame.size.width/2.0);
        CGFloat totalWidth = (self.itemSize.width + self.minimumLineSpacing);
        distance = MIN(MAX(distance, 0), totalWidth);
        CGFloat ratio = 1 - distance / totalWidth;
        attr.alpha = 0.5 + ratio * 0.5;
        CGFloat scale = 1 + ratio * 0.06;
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return cellAtttrs;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
