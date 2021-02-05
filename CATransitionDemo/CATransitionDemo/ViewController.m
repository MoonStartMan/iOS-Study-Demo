//
//  ViewController.m
//  CATransitionDemo
//
//  Created by 王潇 on 2021/2/4.
//

#import "ViewController.h"
#import "TransitionAnimation.h"

@interface ViewController ()

@property (nonatomic, assign) int subtype;
@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) UIImage *img1;
@property (nonatomic, strong) UIImage *img2;
@property (nonatomic, assign) BOOL isImg1;
@property (nonatomic, assign) NSUInteger index;

@end

@implementation ViewController


-(void)setUIViewBackgound:(UIView *)uiview name:(UIImage *)name {
    
    UIGraphicsBeginImageContext(uiview.frame.size);
    [[UIImage imageNamed:name] drawInRect:uiview.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    uiview.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = @[@(kHYBTransitionFade),
                   @(kHYBTransitionPush),
                   @(kHYBTransitionReveal),
                   @(kHYBTransitionMoveIn),
                   @(kHYBTransitionCube),
                   @(kHYBTransitionSuckEffect),
                   @(kHYBTransitionRippleEffect),
                   @(kHYBTransitionPageCurl),
                   @(kHYBTransitionPageUnCurl),
                   @(kHYBTransitionCameraOpen),
                   @(kHYBTransitionCameraClose),
                   @(kHYBTransitionCurlDown),
                   @(kHYBTransitionCurlUp),
                   @(kHYBTransitionFlipFromLeft),
                   @(kHYBTransitionFlipFromRight),
                   @(kHYBTransitionOglFlip)];
    
    self.img1 = [UIImage imageNamed:@"1.png"];
    self.img2 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"3" ofType:@"jpg"]];
    
    [self setUIViewBackgound:self.view name: @"1.png"];
    
    
    self.isImg1 = YES;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateAnimation) userInfo:nil repeats:YES];
}

- (void)updateAnimation {
  
  if (self.index >= self.array.count) {
    self.index = 0;
  }
  
  HYBTransitionType type = [[self.array objectAtIndex:self.index++] intValue];
  static int s_subtypeValue = 0;
  HYBTransitionSubtype subtype = kHYBTransitionSubtypeFromTop;
  s_subtypeValue++;
  if (s_subtypeValue >= 4) {
    s_subtypeValue = 1;
  }
  
  subtype = (HYBTransitionSubtype)s_subtypeValue;
  
  [TransitionAnimation transitionForView:self.view
                                       type:type
                                    subtype:subtype
                                   duration:1.0];
  
  if (self.isImg1) {
    [self setUIViewBackgound:self.view name: @"1.png"];
  } else {
    [self setUIViewBackgound:self.view name: @"3.jpg"];
  }
  
  self.isImg1 = !self.isImg1;
}


@end
