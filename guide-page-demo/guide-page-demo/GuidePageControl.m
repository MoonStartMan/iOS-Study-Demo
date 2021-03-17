//
//  GuidePageControl.m
//  guide-page-demo
//
//  Created by 王潇 on 2021/3/15.
//

#import "GuidePageControl.h"
#import "UIView+VLAdditions.h"

#define Cell_Width 9
#define Cell_Height 9
#define Expanded_Cell_Width 18
#define Cell_Pad 9

@interface GuidePageControl()

/// 当前cellindex
@property (nonatomic) NSInteger currentPageIndex;

@property (nonatomic, nonnull) NSMutableArray<UIView *> *cells;

@end

@implementation GuidePageControl

- (instancetype)initWithCellCount:(NSInteger)cellCout {
    self = [super initWithFrame:CGRectMake(0, 0,(Cell_Width + Cell_Pad) * (cellCout - 1) + Expanded_Cell_Width, Cell_Height)];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        NSMutableArray *allCells = [[NSMutableArray alloc] initWithCapacity:cellCout];
        CGFloat left = 0;
        for (NSInteger i = 0; i < cellCout; i++) {
            UIView *cell = [self createCell:(i == _currentPageIndex)];
            cell.left = left;
            [self addSubview: cell];
            [allCells addObject: cell];
            left += cell.width + Cell_Pad;
        }
        _cells = allCells;
    }
    return self;
}

- (UIView *)createCell:(BOOL)isCurrent {
    UIView *v = [UIView new];
    v.backgroundColor = [UIColor colorWithRed:35/255.0 green:38/255.0 blue:63/255.0 alpha:1.0];
    v.clipsToBounds = YES;
    v.layer.cornerRadius = Cell_Height / 2.0;
    v.height = Cell_Height;
    v.width = isCurrent ? Expanded_Cell_Width : Cell_Width;
    if (isCurrent) {
        CAGradientLayer *gLayer = [CAGradientLayer layer];
        gLayer.frame = CGRectMake(0, 0, v.width, v.height);
        gLayer.colors = @[(__bridge id)[UIColor colorWithRed:113/255.0 green:130/255.0 blue:255/255.0 alpha:1.0].CGColor,
                          (__bridge id)[UIColor colorWithRed:61/255.0 green:75/255.0 blue:255/255.0 alpha:1.0].CGColor];
        gLayer.locations = @[@(0), @(1)];
        gLayer.startPoint = CGPointMake(1, 0.5);
        gLayer.startPoint = CGPointMake(0, 0.5);
        [v.layer addSublayer: gLayer];
    }
    return v;
}

#pragma mark - public
- (void)setCurrentPageIndex:(NSInteger)index animated:(BOOL)animated {
    if (index >= self.cells.count) {
        index = self.cells.count - 1;
    }
    
    if (index < 0) {
        index = 0;
    }
    
    if (self.cells.count < 2 || index == self.currentPageIndex) {
        return;
    }
    
    NSInteger fromIndex = self.currentPageIndex;
    if (fromIndex == index) {
        for (NSInteger i = 0, j = self.cells.count; i < j; i++) {
            if (self.cells[i].width != Cell_Width && i != index) {
                fromIndex = i;
            }
        }
    }
    
    UIView *cellPre = self.cells[fromIndex];    //  左边的cell
    UIView *cellNext = self.cells[index];   //  右边的cell
    CGFloat cellPreToX = 0;
    CGFloat cellNextToX = 0;
    if (fromIndex < index) {
        cellPreToX = index * (Cell_Width + Cell_Pad);
        cellNextToX = fromIndex * (Cell_Width + Cell_Pad);
    } else {
        cellPreToX = index * (Cell_Width + Cell_Pad);
        cellNextToX = fromIndex * (Cell_Width + Cell_Pad) + (Expanded_Cell_Width - Cell_Width);
    }
    
    if(animated) {
        [self.cells exchangeObjectAtIndex:fromIndex withObjectAtIndex:index];
        [UIView animateWithDuration:0.25 animations:^{
            [self bringSubviewToFront: cellPre];
            cellPre.x = cellPreToX;
            cellNext.x = cellNextToX;
        }];
    } else {
        [self bringSubviewToFront:cellPre];
        cellPre.x = cellPreToX;
        cellNext.x = cellNextToX;
        [self.cells exchangeObjectAtIndex:fromIndex withObjectAtIndex:index];
    }
    self.currentPageIndex = index;
}

- (void)scrollToPageIndex:(NSInteger)index ratio:(CGFloat)ratio {
    if (ratio < 0) {
        ratio = 0;
    }
    
    if (ratio > 1) {
        ratio = 1;
    }
    
    if (index >= self.cells.count) {
        index = self.cells.count - 1;
    }
    
    if (index < 0) {
        index = 0;
    }
    
    if (self.cells.count < 2) {
        return;
    }
    
    NSInteger fromIndex = self.currentPageIndex;
    if (fromIndex == index) {
        for (NSInteger i = 0 , j = self.cells.count; i < j; i++) {
            if (self.cells[i].width != Cell_Width && i != index) {
                fromIndex = i;
            }
        }
    }
    
    UIView *cellPre = self.cells[fromIndex];    //  当前选中的cell
    UIView *cellNext = self.cells[index];   //  即将被选中的cell
    [self bringSubviewToFront:cellPre];
    
    CGFloat preCellTranslateX = (Cell_Pad + Cell_Width) * ratio;
    CGFloat nextCellTranslate = (Cell_Pad + Expanded_Cell_Width) * ratio;
    if (fromIndex < index) {
        cellPre.x = fromIndex * (Cell_Pad + Cell_Width) + preCellTranslateX;
        cellNext.x = index * (Cell_Pad + Cell_Width) + (Expanded_Cell_Width - Cell_Width) - nextCellTranslate;
    } else {
        cellPre.x = fromIndex * (Cell_Pad + Cell_Width) - preCellTranslateX;
        cellNext.x = index * (Cell_Pad + Cell_Width) + nextCellTranslate;
    }
    
    if (ratio >= 1) {
        [self.cells exchangeObjectAtIndex:fromIndex withObjectAtIndex:index];
        self.currentPageIndex = index;
    }
}

@end
