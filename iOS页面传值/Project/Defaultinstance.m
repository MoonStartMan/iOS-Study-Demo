//
//  Defaultinstance.m
//  Project
//
//  Created by 王潇 on 2020/11/11.
//

#import "Defaultinstance.h"

@implementation Defaultinstance

//  通过类方法创建单例对象
+(instancetype)sharedInstance {
    static Defaultinstance* sharedVC = nil;
    if (sharedVC == nil) {
        sharedVC = [[Defaultinstance alloc] init];
    }
    return sharedVC;
}

@end
