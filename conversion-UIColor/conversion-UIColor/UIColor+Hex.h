//
//  UIColor+Hex.h
//  conversion-UIColor
//
//  Created by 王潇 on 2020/12/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)

//  透明度固定为1，以0X开头的十六进制转换成的颜色
+ (UIColor *)colorWithHex: (long)hexColor;
//  0X开头的十六进制转换成的颜色，透明度可调整
+ (UIColor *)colorWithHex: (long)hexColor alpha:(float)opacity;
//  颜色转换三：iOS十六进制的颜色(以#开头)转换成UIColor
+ (UIColor *)colorWithHexString: (NSString *)color;

@end

NS_ASSUME_NONNULL_END
