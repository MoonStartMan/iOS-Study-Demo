//
//  KeyCommandView.m
//  UIResponder-Demo
//
//  Created by 王潇 on 2021/3/3.
//

#import "KeyCommandView.h"

@implementation KeyCommandView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //  设置成为第一响应者
        [self becomeFirstResponder];
    }
    return self;
}

/** 允许对象成为第一响应者 */
- (BOOL)canBecomeFirstResponder {
    return YES;
}

/** 返回快捷命令数组 */
- (NSArray<UIKeyCommand *>*)keyCommands {
    return @[
        [UIKeyCommand keyCommandWithInput:UIKeyInputEscape modifierFlags:UIKeyModifierShift action:@selector(pressedShiftAndEscapeKey:) discoverabilityTitle:@"自定义[shift+ESC]快捷键"],
    [UIKeyCommand keyCommandWithInput:@"a" modifierFlags:UIKeyModifierShift action:@selector(pressedShiftAndAKey:) discoverabilityTitle:@"自定义[Shift+A]快捷键"]
    ];
}


/** Shift+Esc快捷命令响应 */
-(void)pressedShiftAndEscapeKey:(UIKeyCommand *)keyCommand {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:keyCommand.discoverabilityTitle message:[NSString stringWithFormat:@"按下快捷辅键:[%@]", keyCommand.input] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}
 
/** Shift+A快捷命令响应 */
-(void)pressedShiftAndAKey:(UIKeyCommand *)keyCommand {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:keyCommand.discoverabilityTitle message:[NSString stringWithFormat:@"按下快捷辅键:[%@]", keyCommand.input] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

@end
