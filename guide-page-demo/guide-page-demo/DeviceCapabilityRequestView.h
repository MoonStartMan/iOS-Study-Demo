//
//  DeviceCapabilityRequestView.h
//  guide-page-demo
//
//  Created by 王潇 on 2021/3/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceCapabilityRequestView : UIView

- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

/// 点击继续回调
@property (nonatomic, copy) void(^continueClicked)();

@end

NS_ASSUME_NONNULL_END
