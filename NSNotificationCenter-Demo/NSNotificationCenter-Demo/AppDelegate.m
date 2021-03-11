//
//  AppDelegate.m
//  NSNotificationCenter-Demo
//
//  Created by 王潇 on 2021/3/11.
//

#import "AppDelegate.h"
#import "ShowViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    ShowViewController *VC = [[ShowViewController alloc] init];
    UINavigationController *NaVC = [[UINavigationController alloc] initWithRootViewController:VC];
    self.window.rootViewController = NaVC;
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
