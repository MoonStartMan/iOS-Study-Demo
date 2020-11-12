//
//  Defaultinstance.h
//  Project
//
//  Created by 王潇 on 2020/11/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Defaultinstance : NSObject

+(instancetype)sharedInstance;

@property (nonatomic, strong) NSString *str;

@end

NS_ASSUME_NONNULL_END
