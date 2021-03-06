//
//  dataProtocol.h
//  Protocol-Demo
//
//  Created by 王潇 on 2021/3/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol dataProtocol <NSObject>

@required
- (NSString *)sendName;
- (NSString *)sendAge;

@optional
- (NSString *)sendPhone;

@end

NS_ASSUME_NONNULL_END
