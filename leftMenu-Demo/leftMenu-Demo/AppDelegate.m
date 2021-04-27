//
//  AppDelegate.m
//  leftMenu-Demo
//
//  Created by 王潇 on 2021/4/26.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MainViewController.h"
#import "LeftViewController.h"

@interface AppDelegate ()

@end

#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    MainViewController * mainHomeVC = [MainViewController drawerViewControllerWithLeftViewController:[[LeftViewController alloc] init] mainViewController:[[MainViewController alloc] init]];
    mainHomeVC.leftViewWidth = SCREEN_WIDTH*0.75;
    self.window.rootViewController = mainHomeVC;
    return YES;
}


@end
