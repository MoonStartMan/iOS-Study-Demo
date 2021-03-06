//
//  AppDelegate.m
//  Protocol-Demo
//
//  Created by 王潇 on 2021/3/4.
//

#import "AppDelegate.h"
#import "SendViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    SendViewController *sendVC = [[SendViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:sendVC];
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    sendVC = nil;
    nav = nil;
    return YES;
}

@end
