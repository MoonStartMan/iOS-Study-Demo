//
//  ReceiveViewController.h
//  Protocol-Demo
//
//  Created by 王潇 on 2021/3/4.
//

#import <UIKit/UIKit.h>
#import "dataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReceiveViewController : UIViewController

@property (nonatomic, strong) id <dataProtocol> delegate;

@end


NS_ASSUME_NONNULL_END
