//
//  AppDelegate.m
//  UICollectionView-Demo
//
//  Created by 王潇 on 2021/1/21.
//

#import "AppDelegate.h"
#import "RoundCollectionViewController.h"
#import "RoundUIcollectionViewFlowLayout.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    RoundUIcollectionViewFlowLayout *layout = [[RoundUIcollectionViewFlowLayout alloc] init];
    RoundCollectionViewController *VC = [[RoundCollectionViewController alloc] initWithCollectionViewLayout:layout];
    self.window.rootViewController = VC;
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    return YES;
}

@end
