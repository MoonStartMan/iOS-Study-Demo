//
//  DrawingBoardView.h
//  UIResponder-Demo
//
//  Created by 王潇 on 2021/3/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 画板View */

@interface DrawingBoardView : UIView

@end

/** 划线Model */
@interface LineModel : NSObject

@property (nonatomic) CGPoint begin;
@property (nonatomic) CGPoint end;

@end

NS_ASSUME_NONNULL_END
