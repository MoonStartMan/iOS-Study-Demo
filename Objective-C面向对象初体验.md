# Objective-C面向对象初体验

## 实例化对象

``` Objective-C
//	实例化对象
/*
	[类名 方法名]
	[对象名 方法名]
	alloc - 为对象分配内存空间
	init - 进行初始化操作
*/
```

## 类的成员变量与类的属性

1. 类内使用成员变量、类外使用属性
2. 属性为了让类外可以访问成员变量
3. 属性就是成员变量的外部接口

``` Objective-C

@interface People: NSObject
{
	NSString *_peopleName;
	int _peopleAge;
	int _peopleSex;
}

```

## 声明方法

1. -、+ 方法的类型(-代表对象方法(用对象名来调用)，+代表方法)(加号方法和减号方法可以互相调用当然需要类名和实例化配置，加号方法不能调用成员变量)
2. (int) - 返回值类型
3. :(int)x - : 代表参数, (int)代表参数类型，a代表参数名
4. 函数名(方法名) - 去掉函数 (方法)类型、去掉参数类型、去掉参数名剩下的就是函数(方法)名

## 初始化函数

``` Objective-C
- (instancetype)init;
```

## 自定义初始化方法

``` Objective-C
- (instancetype)initWithPeopleName: (NSString *)peopleName andPeopleAge: (int)peopleAge;
```

## 成员变量访问修饰符的问题

默认 - 受保护
@public: 公有 - 在类内类外都可以使用并且可以被继承
@private: 私有 - 在类内可以使用，类外无法调用并且不可以被继承。
@protected: 受保护 - 在类内可以使用，在类外无法调用并且可以被继承。
@package: 框架权限 - 在框架内相当于受保护，在框架外相当于私有。

## 继承

1. 父类中的私有变量我们是无法继承使用的
2. 如果父类的方法中使用了私有变量，而我们子类继承了父类的这个方法，那私有变量操作以及打印我们是可以看到的，但是我们不可以在子类中直接调用私有变量
3. 如果父类中的方法没有写声明则子类无法继承父类中对应的方法

``` Objective-C
//	父类
@interface MyClass : NSObject
{
	@public
	int _classInt;
  @protected
  int _classInt;
  @private
  NSString *_classStr;
}
@property (nonatomic, strong) NSString *className;

@implementation MyClass
- (void)report
{
    _classInt = 1001;
    _classStr = @"MyClassStr";
    NSLog(@"ClassName - %@", _className);
    NSLog(@"ClassInt - %d", _classInt);
    NSLog(@"ClassStr - %@", _classStr);
}
@end

//	子类
@implementation MySonClass

- (void)show
{
  _classInt = 1002;
  NSLog(@"show - %d", _classInt);
  [self report];
}

@end


```