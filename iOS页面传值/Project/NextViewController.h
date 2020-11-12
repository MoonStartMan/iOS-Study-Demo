//
//  NextViewController.h
//  Project
//
//  Created by 王潇 on 2020/11/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//  委托方创建一个协议
@protocol passValueDelegate <NSObject>

//  协议定义一个传值的方法
- (void)passValue: (NSString *)str;

@end

@interface NextViewController : UIViewController

//  定一个字符串属性
@property (nonatomic, strong) NSString *str;

//  定义一个持有协议的id指针
@property (weak)id<passValueDelegate>delegate;

//  定义一个block进行页面反向传值
@property (copy) void (^block)(NSString *);

@end

NS_ASSUME_NONNULL_END
