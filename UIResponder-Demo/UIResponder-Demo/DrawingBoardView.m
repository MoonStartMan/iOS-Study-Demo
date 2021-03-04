//
//  DrawingBoardView.m
//  UIResponder-Demo
//
//  Created by 王潇 on 2021/3/3.
//

#import "DrawingBoardView.h"
#import <Masonry/Masonry.h>

/** 画板View */
@interface DrawingBoardView()

@property (nonatomic, strong) LineModel *currentLine;
@property (nonatomic, strong) NSMutableArray<LineModel *> *touchArray;

@end

@implementation DrawingBoardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
        self.backgroundColor = [UIColor whiteColor];
        self.touchArray = [NSMutableArray array];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //  获得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //  设置样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    //  设置宽度
    CGContextSetLineWidth(context, 5.0);
    //  设置颜色
    CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed: arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0] CGColor]);
    
    for (LineModel *line in self.touchArray) {
        //  开始绘制
        CGContextBeginPath(context);
        //  移动画笔到起点
        CGContextMoveToPoint(context, line.begin.x, line.begin.y);
        //  添加下一点
        CGContextAddLineToPoint(context, line.end.x, line.end.y);
        //  绘制完成
        CGContextStrokePath(context);
    }
}

/** 划线开始 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //  标记开始撤销分组
    [self.undoManager beginUndoGrouping];
    
    for (UITouch *touch in touches) {
        //  记录起始点
        CGPoint locTouch = [touch locationInView:self];
        _currentLine = [[LineModel alloc] init];
        _currentLine.begin = locTouch;
        _currentLine.end = locTouch;
    }
}

/** 划线移动 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        //  添加线条
        CGPoint locTouch = [touch locationInView: self];
        _currentLine.end = locTouch;
        [self addLine: _currentLine];
        //  当前线条
        _currentLine = [[LineModel alloc] init];
        _currentLine.begin = locTouch;
        _currentLine.end = locTouch;
    }
}

/** 划线结束 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //  结束标记撤销分组
    [self.undoManager endUndoGrouping];
}

/** 添加划线 */
- (void)addLine: (LineModel *)line {
    //  添加划线并重绘画板
    [self.touchArray addObject:line];
    [self setNeedsDisplay];
    //  注册撤销方法
    [[self.undoManager prepareWithInvocationTarget:self] removeLine:line];
}

/** 移除划线 */
- (void)removeLine: (LineModel *)line {
    if ([self.touchArray containsObject:line]) {
        //  移除划线并重绘画板
        [self.touchArray removeObject:line];
        [self setNeedsDisplay];
        //  注册撤销方法
        [[self.undoManager prepareWithInvocationTarget:self] addLine:line];
    }
}

/** 撤销按钮点击响应 */
- (void)undoButtonAction: (id)sender {
    if ([self.undoManager canUndo]) {
        [self.undoManager undo];
    }
}

/** 重做按钮点击响应 */
- (void)redoButtonAction: (id)sender {
    if ([self.undoManager canRedo]) {
        [self.undoManager redo];
    }
}

/** 初始化子控件 */
- (void)initSubView {
    //  撤销按钮
    UIButton *undoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [undoButton setTitle:@"uodo撤销" forState:UIControlStateNormal];
    [undoButton sizeToFit];
    [undoButton addTarget:self action:@selector(undoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:undoButton];
    [undoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.top.equalTo(self.mas_top).with.offset(44);
        make.size.mas_equalTo(CGSizeMake(80, 50));
    }];
    undoButton.layer.cornerRadius = 10;
    undoButton.backgroundColor = [UIColor blackColor];
    [undoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //  重做按钮
    UIButton *redoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [redoButton setTitle:@"redo重做" forState:UIControlStateNormal];
    [redoButton sizeToFit];
    [redoButton addTarget:self action:@selector(redoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: redoButton];
    [redoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-20);
        make.top.equalTo(undoButton.mas_top).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(80, 50));
    }];
    redoButton.layer.cornerRadius = 10;
    redoButton.backgroundColor = [UIColor blackColor];
    [redoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

@end

@implementation LineModel

@end
