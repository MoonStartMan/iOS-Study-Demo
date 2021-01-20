//
//  ViewController.m
//  macro-demo
//
//  Created by 王潇 on 2021/1/19.
//

#import "ViewController.h"

#define ADD(x, y) x + y
#define SIZE 10
#define YM_Swap(_a_, _b_) {__typeof__(_a_) _t_ = _a_; (_a_) = (_b_); (_b_) = (_t_); }
//#define YM_TEST(_a_, _b_) _a_ = 100; _b_ = 200;
#define YM_TEST(_a_, _b_) ({_a_ = 200; _b_ = 300;})
#define MINA(A, B) __typeof__(A) __a = (A);\
                   __typeof__(B) __b = (B);\
                   __a < __b ? __a : __b;
#define __NSX_PASTE_(A, B) A##B

#define __NSMIN_IMPL__(A,B,L) ({\
__typeof__(A) __NSX_PASTE__(__a,L) = (A);\
__typeof__(B) __NSX_PASTE__(__b,L) = (B);\
(__NSX_PASTE__(__a,L) < __NSX_PASTE__(__b,L)) ? __NSX_PASTE__(__a,L) : __NSX_PASTE__(__b,L);\
})

#define MIN(A,B) __NSMIN_IMPL__(A,B,__COUNTER__)

//int c = MIN(10, 20);
//NSLog(@"c= %d",c);

//  转换后的代码:
//  1.转换
//  __NSMIN_IMPL__(10, 20, __COUNTER__);
//  2.转换
//   __typeof__(10) __NSX_PASTE__(__10, L) = (10);
//   __typeof__(20) __NSX_PASTE__(__20, L) = (20);
//   __(NSX_PASTE__(__10, L) < __NSX_PASTE__(__20, L)) ? __NSX_PASTE__(__10, L) : __NSX_PASTE__(__20, L);
//  3.转换
//   __10##L < __20##L ? __10##L : __20##L;


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int size = SIZE + 10;
    
    NSLog(@"size = %d", size);
    
    int result = ADD(1 , 2);
    
    NSLog(@"result = %d", result);
    
    int left_number = 10;
    int right_number = 100;
    
    YM_Swap(left_number, right_number);
    
    //  { int _t_ = left_number; (left_number) = (right_number); (right_number) = (_t_); };
    
    NSLog(@"left_number = %d, right_number = %d", left_number, right_number);
    
    int totalNumber = SIZE - ADD(2, 3);
    
    //   int totalNumber = 10 - 2 + 3
    NSLog(@"totalNumber = %d", totalNumber);
    
//    int a = 10;
//    int b = 20;
//    int res = YM_TEST(a, b);
//    NSLog(@"res = %d", res);
    
    /// int a = 10;
    /// int b = 20;
    /// int res = a = 100; b = 200;
    
    int a = 10;
    int b = 20;
    int res = YM_TEST(a, b);

    NSLog(@"res = %d", res);
    
    int c = MIN(10, 20);
    NSLog(@"c= %d",c);
    
}

@end
