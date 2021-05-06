//
//  DrawerViewControllerViewController.m
//  leftMenu-Demo
//
//  Created by 王潇 on 2021/4/26.
//

#import "DrawerViewController.h"

NSString * DRAWER_SHOW_LEFT  = @"DRAWER_SHOW_LEFT";
NSString * DRAWER_DISMISS    = @"DRAWER_DISMISS";

typedef NS_ENUM(NSInteger, DrawerShowState) {
    DrawerShowStateNone  = 0,
    DrawerShowStateLeft  = 1,
    DrawerShowStateRight = 2,
};

@interface DrawerViewController ()

@property (nonatomic, strong) UIView *coverView;

@end

@implementation DrawerViewController {
    DrawerShowState _showState;
    UIScreenEdgePanGestureRecognizer * _left;
    UIPanGestureRecognizer * _none;
}

+ (DrawerViewController *)drawerViewControllerWithLeftViewController:(UIViewController *)leftVC mainViewController:(UIViewController *)mainVC {
    DrawerViewController * drawerVC = [[DrawerViewController alloc]initWithLeftViewController:leftVC mainViewController:mainVC];
    return drawerVC;
}

+ (DrawerViewController *)drawerViewControllerWithMainViewController:(UIViewController *)mainVC {
    return [DrawerViewController drawerViewControllerWithMainViewController:mainVC];
}


- (instancetype)initWithLeftViewController:(UIViewController *)leftVC mainViewController:(UIViewController *)mainVC {
    if (self = [super init]) {
        _leftVC  = leftVC;
        _mainVC  = mainVC;
        [self setUp];
    }
    return self;
}

- (void)setUp {
    _left = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(mainPanAction:)];
    _none = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(mainPanActionleft:)];
    _left.edges = UIRectEdgeLeft;
    _drawerType     = DrawerTypePlane;
    _leftViewWidth  = [UIScreen mainScreen].bounds.size.width * 0.75;
    _canPan         = YES;
    _duration       = 0.4;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismiss:) name:DRAWER_DISMISS object:nil];
    
    [self addMainViewController];
    
    self.coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.coverView.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.4];
    [self.view addSubview:self.coverView];
    self.coverView.hidden = YES;
    self.coverView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewClick)];
    [self.coverView addGestureRecognizer:singleTap];
    
    
    if (self.leftVC)  {
        [self addLeftViewController];
        [self leftViewControllerAddPan];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showLeft:) name:DRAWER_SHOW_LEFT object:nil];
    }
}

#pragma mark -- add

- (void)addMainViewController {
    [self addChildViewController:_mainVC];
    _mainVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:_mainVC.view];
    [_mainVC didMoveToParentViewController:self];
    
    [self mainViewControllerAddPan];
}

- (void)addLeftViewController {
    [self addChildViewController:_leftVC];
    
    if (_drawerType == DrawerTypePlane) {
        _leftVC.view.frame = CGRectMake(-_leftViewWidth, 0, _leftViewWidth, self.view.frame.size.height);
    }
    
    [self.view addSubview:_leftVC.view];
    [_leftVC didMoveToParentViewController:self];
}

#pragma mark -- show & dismiss

- (void)showLeftViewController:(BOOL)animated {
    if (_drawerType == DrawerTypePlane) {
        CGFloat realDuration = _duration * ABS(_leftVC.view.frame.origin.x / -_leftViewWidth);
        [UIView animateWithDuration:animated?realDuration:0 animations:^{
            CGRect leftFrame    = self->_leftVC.view.frame;
            leftFrame.origin.x  = 0;
            self->_leftVC.view.frame  = leftFrame;
        } completion:^(BOOL finished) {
            self.coverView.hidden = NO;
        }];
    }
    
    _showState = DrawerShowStateLeft;
    NSUInteger i = _mainVC.childViewControllers.count;
    for (int j = 0; j<i; j++) {
        _mainVC.childViewControllers[j].view.userInteractionEnabled = NO;
    }
    [self mainViewControllerAddPan];
}

- (void)_hideViewController:(BOOL)animated {
    if (_drawerType == DrawerTypePlane) {
        CGFloat realDuration = _duration * ABS((_leftViewWidth + _leftVC.view.frame.origin.x) / _leftViewWidth);
        [UIView animateWithDuration:animated?realDuration:0 animations:^{
            CGRect leftFrame    = self->_leftVC.view.frame;
            leftFrame.origin.x  = -self->_leftViewWidth;
            self->_leftVC.view.frame  = leftFrame;
        } completion:^(BOOL finished) {
            self.coverView.hidden = YES;
        }];
    }
    NSUInteger i = _mainVC.childViewControllers.count;
    for (int j = 0; j<i; j++) {
        _mainVC.childViewControllers[j].view.userInteractionEnabled = YES;
    }
    _showState = DrawerShowStateNone;
    [self mainViewControllerAddPan];
}

- (void)showLeft:(NSNotification *)noti {
    if (!_leftVC) {
        return;
    }
    
    BOOL animated = noti.userInfo[@"animated"];
    
    if (_showState == DrawerShowStateLeft) {
        return;
    } else if (_showState == DrawerShowStateRight) {
        [self _hideViewController:animated];
    }
    
    [self showLeftViewController:animated];
    
}

- (void)dismiss:(NSNotification *)noti {
    BOOL animated = noti.userInfo[@"animated"];
    
    if (_showState == DrawerShowStateLeft ||
        _showState == DrawerShowStateRight) {
        [self _hideViewController:animated];
        [self mainViewControllerAddPan];
    }  else {
        return;
    }
}

#pragma mark set get
- (void)setLeftViewWidth:(CGFloat)leftViewWidth {
    _leftViewWidth = leftViewWidth;
    _leftVC.view.frame = CGRectMake(-_leftViewWidth, 0, _leftViewWidth, self.view.frame.size.height);
}

#pragma mark - addPan
- (void)leftViewControllerAddPan {
    [_leftVC.view addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(leftPanAction:)]];
}

- (void)mainViewControllerAddPan {
    if (_showState == DrawerShowStateNone) {
        [_mainVC.view removeGestureRecognizer:_none];
        [_mainVC.view addGestureRecognizer:_left];
    }else if (_showState == DrawerShowStateLeft){
        [_mainVC.view removeGestureRecognizer:_left];
        [_mainVC.view addGestureRecognizer:_none];
    }
    
}

#pragma mark - PanAction
- (void)leftPanAction:(UIPanGestureRecognizer *)sender {
    CGPoint pt = [sender translationInView:sender.view];
    CGRect leftViewFrame = _leftVC.view.frame;
    leftViewFrame.origin.x += pt.x;
    if (leftViewFrame.origin.x <= 0 &&
        leftViewFrame.origin.x >= -_leftViewWidth) {
        _leftVC.view.frame = leftViewFrame;
        [self changeOriginX:_left.view addX:pt.x];
        [self changeAlpha:_coverView setAlpha:((leftViewFrame.size.width/2 + pt.x)/leftViewFrame.size.width)*0.4];
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (leftViewFrame.origin.x > -_leftViewWidth/2.0) {
            [self showLeftViewController:YES];
        } else {
            [self _hideViewController:YES];
        }
    }
    
    [sender setTranslation:CGPointZero inView:sender.view];
}

- (void)mainPanAction:(UIScreenEdgePanGestureRecognizer *)sender {
    CGPoint pt = [sender translationInView:sender.view];
    CGRect mainViewFrame = _mainVC.view.frame;
    mainViewFrame.origin.x += pt.x;
    if (mainViewFrame.origin.x <= _leftViewWidth) {
        
        _mainVC.view.frame = mainViewFrame;
        [self changeOriginX:_leftVC.view addX:pt.x];
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (_mainVC.view.frame.origin.x > _leftViewWidth/2.0){
            [self showLeftViewController:YES];
        } else {
            [self _hideViewController:YES];
        }
    }
    [sender setTranslation:CGPointZero inView:sender.view];
}

- (void)mainPanActionleft:(UIPanGestureRecognizer *)sender {
    CGPoint pt = [sender translationInView:sender.view];
    CGRect mainViewFrame = _mainVC.view.frame;
    mainViewFrame.origin.x += pt.x;
    if (mainViewFrame.origin.x <= _leftViewWidth) {
        _mainVC.view.frame = mainViewFrame;
        [self changeOriginX:_leftVC.view addX:pt.x];
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (_mainVC.view.frame.origin.x > _leftViewWidth/2.0){
            [self showLeftViewController:YES];
        } else {
            [self _hideViewController:YES];
        }
    }

    [sender setTranslation:CGPointZero inView:sender.view];
}

- (void)changeOriginX:(UIView *)changeView addX:(CGFloat)addX {
    CGRect rect      = changeView.frame;
    rect.origin.x   += addX;
    changeView.frame = rect;
}

- (void)changeAlpha: (UIView *)changeview setAlpha:(CGFloat)alpha {
    changeview.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:alpha];
}

- (void)coverViewClick {
    dismiss(YES);
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
