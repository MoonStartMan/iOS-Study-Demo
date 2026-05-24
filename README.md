# iOS-Study-Demo

<p align="center">
  <img src="https://img.shields.io/badge/Objective--C-blue.svg" alt="Objective-C">
  <img src="https://img.shields.io/badge/iOS-9.0+-blue.svg" alt="iOS 9.0+">
  <img src="https://img.shields.io/badge/Xcode-8.0+-brightgreen.svg" alt="Xcode 8.0+">
  <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="MIT License">
</p>

<p align="center">
  <b>iOS 开发学习 Demo 集合 - Objective-C 版本</b>
</p>

## 项目简介

这是一个 iOS 开发者学习过程中编写的各种 Demo 集合，主要使用 Objective-C 语言编写。本项目涵盖了 iOS 开发的多个方面，从基础的 UI 组件使用到高级的动画效果，适合 iOS 初学者和有一定经验的开发者参考学习。

## 功能特性

- 基础 UI 组件使用示例
- 动画效果实现
- 页面传值方法
- 网络请求封装
- 自定义控件开发
- 游戏开发示例
- 多媒体处理

## 技术栈

- **编程语言**: Objective-C
- **UI框架**: UIKit
- **动画框架**: Core Animation
- **开发环境**: Xcode 8.0+
- **最低支持系统**: iOS 9.0+

## Demo 列表

### UI 组件

| Demo名称 | 描述 |
|---------|------|
| UICollectionView-Demo | 集合视图使用示例 |
| ViewProgrammingDemo | 纯代码布局示例 |
| UI-Responder-Demo | 响应者链演示 |
| guide-page-demo | 引导页实现 |
| loading-demo | 加载动画效果 |
| leftMenu-demo | 左侧菜单栏 |
| carousel-Demo | 轮播图实现 |

### 动画效果

| Demo名称 | 描述 |
|---------|------|
| CATransitionDemo | 转场动画 |
| iOS-CoreAnimation | 核心动画 |
| Drag-Progress-Demo | 拖拽圆环进度条 |
| Circle-Loading-Demo | 圆环加载动画 |
| ButtonAnimation | 按钮动画效果 |

### 功能实现

| Demo名称 | 描述 |
|---------|------|
| barrage | 弹幕效果实现 |
| iOS-五子棋大战 | 五子棋游戏 |
| DrageView | 拖拽视图功能 |
| Block-Send-Demo | Block 传值示例 |
| Protocol-Demo | 协议传值示例 |
| NSNotificationCenter-Demo | 通知传值示例 |

### 布局与样式

| Demo名称 | 描述 |
|---------|------|
| Masonry-Demo | Masonry 自动布局 |
| conversion-UIColor | 十六进制颜色转换 |
| layer设置阴影 | 阴影效果设置 |
| macro-demo | C 语言宏定义使用 |

### 页面与导航

| Demo名称 | 描述 |
|---------|------|
| iOS页面传值 | 多种页面传值方式 |
| Result-View | 结果展示页 |
| Description | 描述页展示 |

## 安装和运行

### 环境要求

- macOS 10.12 或更高版本
- Xcode 8.0 或更高版本
- iOS 9.0+ 模拟器或真机

### 安装步骤

1. 克隆仓库

```bash
git clone https://github.com/MoonStartMan/iOS-Study-Demo.git
```

2. 进入项目目录

```bash
cd iOS-Study-Demo
```

3. 打开 Xcode 工程

```bash
open iOS-Study-Demo.xcodeproj
```

4. 选择目标设备，点击运行按钮 (Cmd+R)

## 项目结构

```
iOS-Study-Demo/
├── iOS-Study-Demo.xcodeproj
├── iOS-Study-Demo/
│   ├── AppDelegate.h/m
│   ├── ViewController.h/m
│   ├── Demos/
│   │   ├── UICollectionView-Demo/
│   │   ├── Masonry-Demo/
│   │   ├── iOS-CoreAnimation/
│   │   ├── iOS-五子棋大战/
│   │   └── ...
│   └── Resources/
│       └── Assets.xcassets
└── README.md
```

## 示例代码

### Masonry 自动布局

```objc
#import "Masonry.h"

// 创建视图
UIView *containerView = [[UIView alloc] init];
containerView.backgroundColor = [UIColor lightGrayColor];
[self.view addSubview:containerView];

// 使用 Masonry 设置约束
[containerView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.view);
    make.size.mas_equalTo(CGSizeMake(300, 200));
}];

// 等宽等高示例
UIView *view1 = [[UIView alloc] init];
view1.backgroundColor = [UIColor redColor];
[containerView addSubview:view1];

UIView *view2 = [[UIView alloc] init];
view2.backgroundColor = [UIColor blueColor];
[containerView addSubview:view2];

[view1 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(containerView).offset(10);
    make.width.height.equalTo(view2);
}];

[view2 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(view1.mas_right).offset(10);
    make.top.equalTo(view1);
    make.right.equalTo(containerView).offset(-10);
    make.height.equalTo(view1);
}];
```

### 页面传值 - Block 方式

```objc
// SecondViewController.h
typedef void(^ReturnValueBlock)(NSString *value);

@interface SecondViewController : UIViewController
@property (nonatomic, copy) ReturnValueBlock returnBlock;
@end

// SecondViewController.m
- (void)backButtonClicked {
    if (self.returnBlock) {
        self.returnBlock(@"传递的数据");
    }
    [self.navigationController popViewControllerAnimated:YES];
}

// FirstViewController.m
- (void)goToSecondVC {
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    secondVC.returnBlock = ^(NSString *value) {
        NSLog(@"接收到的值: %@", value);
        self.label.text = value;
    };
    [self.navigationController pushViewController:secondVC animated:YES];
}
```

### Core Animation 动画

```objc
// 基础动画
CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
animation.fromValue = @1.0;
animation.toValue = @1.5;
animation.duration = 0.5;
animation.autoreverses = YES;
[self.myView.layer addAnimation:animation forKey:@"scale"];

// 转场动画
CATransition *transition = [CATransition animation];
transition.type = kCATransitionPush;
transition.subtype = kCATransitionFromRight;
transition.duration = 0.5;
[self.navigationController.view.layer addAnimation:transition forKey:nil];
[self.navigationController pushViewController:newVC animated:NO];
```

### 十六进制颜色转换

```objc
// UIColor+Hex.h
@interface UIColor (Hex)
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHex:(NSInteger)hex;
@end

// UIColor+Hex.m
@implementation UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) return [UIColor clearColor];
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6) return [UIColor clearColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

@end
```

## 学习建议

1. **基础入门**: 先了解 Objective-C 语法和 iOS 开发基础
2. **UIKit 学习**: 掌握常用 UI 组件的使用方法
3. **布局系统**: 学习 Auto Layout 和 Masonry 的使用
4. **页面传值**: 理解多种页面间数据传递方式
5. **动画效果**: 学习 Core Animation 实现各种动画
6. **项目实战**: 通过 Demo 练习巩固所学知识

## 贡献指南

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/new-demo`)
3. 添加 Demo 代码
4. 提交更改 (`git commit -m 'Add: 新 Demo'`)
5. 推送到分支 (`git push origin feature/new-demo`)
6. 打开 Pull Request

## 许可证

本项目采用 MIT 许可证 - 详情请参阅 [LICENSE](LICENSE) 文件

## 联系方式

- GitHub: [@MoonStartMan](https://github.com/MoonStartMan)

---

<p align="center">如果这个项目对您有帮助，请给个 ⭐️ 支持一下！</p>
