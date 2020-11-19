//
//  KWPoint.h
//  iOS_五子棋大战
//
//  Created by 王潇 on 2020/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KWPoint : NSObject

@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;

- (instancetype)initPointWith: (NSInteger)x y:(NSInteger)y;

@end

NS_ASSUME_NONNULL_END
