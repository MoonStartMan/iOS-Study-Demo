//
//  DrawerViewControllerViewController.h
//  leftMenu-Demo
//
//  Created by 王潇 on 2021/4/26.
//

#import <UIKit/UIKit.h>

extern NSString * DRAWER_SHOW_LEFT;
extern NSString * DRAWER_DISMISS;

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wunused-function"

static void showLeft(BOOL animated) {
    [[NSNotificationCenter defaultCenter]postNotificationName:DRAWER_SHOW_LEFT object:nil userInfo:@{@"animated":@(animated)}];
};

static void dismiss(BOOL animated) {
    [[NSNotificationCenter defaultCenter]postNotificationName:DRAWER_DISMISS object:nil userInfo:@{@"animated":@(animated)}];
};
#pragma clang diagnostic pop

@interface DrawerViewController : UIViewController

typedef NS_ENUM(NSInteger,DrawerType) {
    /** 默认,平行 */
    DrawerTypePlane,
};

@property(nonatomic,strong)UIViewController * leftVC;
@property(nonatomic,strong)UIViewController * mainVC;

/**
 *  默认DrawerTypePlane
 */
@property(nonatomic,assign)DrawerType drawerType;

/**
 *  默认屏幕宽度的0.75
 */
@property(nonatomic,assign)CGFloat leftViewWidth;
/**
 *  默认YES
 */
@property(nonatomic,assign)BOOL canPan;

/**
 *  动画时间,默认0.5s
 */
@property(nonatomic,assign)CGFloat duration;
/**
 *  左右抽屉
 *
 *  @param leftVC  左vc
 *  @param mainVC  中间vc
 *
 *  @return DrawerViewController对象
 */
+ (instancetype)drawerViewControllerWithLeftViewController:(UIViewController *)leftVC mainViewController:(UIViewController *)mainVC;
/**
 *  左抽屉
 *
 *  @param leftVC 左vc
 *  @param mainVC 中间vc
 *
 *  @return WZXDrawerViewController对象
 */
+ (DrawerViewController *)drawerViewControllerWithMainViewController:(UIViewController *)mainVC;

- (instancetype)initWithLeftViewController:(UIViewController *)leftVC mainViewController:(UIViewController *)mainVC;

@end
