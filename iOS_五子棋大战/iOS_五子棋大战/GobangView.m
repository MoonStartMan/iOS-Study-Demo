//
//  GobangView.m
//  iOS_五子棋大战
//
//  Created by 王潇 on 2020/11/12.
//

#import "GobangView.h"

@implementation GobangView

const NSInteger kBoardSize = 19;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        for(int i = 0; i<kBoardSize + 2; i++) {
            UIView *horizentalLine = [[UIView alloc] initWithFrame:CGRectMake(0, i * frame.size.height / (kBoardSize + 1), frame.size.width, 0.5)];
            horizentalLine.backgroundColor = [UIColor blackColor];
            [self addSubview:horizentalLine];
        }
        
        for (int i = 0; i < kBoardSize + 2; i ++) {
            UIView * verticalLine = [[UIView alloc] initWithFrame:CGRectMake(i * frame.size.width / (kBoardSize + 1), 0, 0.5, frame.size.height)];
            verticalLine.backgroundColor = [UIColor blackColor];
            [self addSubview:verticalLine];
        }
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    NSUInteger h, v;
    
    for(int i=0; i<= kBoardSize + 1; i ++) {
        
        if(i * self.frame.size.width / (kBoardSize + 1) <= point.x && point.x < (i + 1) * self.frame.size.width / (kBoardSize + 1)) {
            if (i == 0) {
                h = 0;
                return;
            }
            if (i == kBoardSize) {
                h = kBoardSize - 1;
                return;
            }
            if (fabs(i * self.frame.size.width / (kBoardSize +1) - point.x) >= fabs((i + 1) * self.frame.size.width / (kBoardSize + 1))) {
                h = i;
                break;
            } else {
                h = i - 1;
                break;
            }
        }
    }
    
    for(NSInteger i=0; i<= kBoardSize; i ++) {
        
        if(i * self.frame.size.width / (kBoardSize + 1) <= point.y && point.y < (i + 1) * self.frame.size.width / (kBoardSize + 1)) {
            if (i == 0) {
                v = 0;
                return;
            }
            if (i == kBoardSize) {
                v = kBoardSize - 1;
                return;
            }
            if (fabs(i * self.frame.size.width / (kBoardSize +1) - point.y) >= fabs((i + 1) * self.frame.size.width / (kBoardSize + 1) - point.y)) {
                v = i;
                break;
            } else {
                v = i - 1;
                break;
            }
        }
    }
    
    UIImageView *piece = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7.5, 7.5)];
    piece.image = [UIImage imageNamed:@"black"];
    [self addSubview:piece];
    piece.center = CGPointMake((h + 1) * self.frame.size.width / (kBoardSize + 1), (v + 1) * self.frame.size.width / (kBoardSize + 1));
}

@end
