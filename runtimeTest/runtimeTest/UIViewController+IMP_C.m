//
//  UIViewController+IMP.m
//  runtimeTest
//
//  Created by ltchina on 16/1/8.
//  Copyright (c) 2016年 ltchina. All rights reserved.
//

#import "UIViewController+IMP_C.h"
#import <objc/runtime.h>

typedef void (*_VIMP)(id,SEL,...);//返回类型为空
typedef id (*_IMP)(id,SEL,...);//有返回类型
@implementation UIViewController (IMP_C)
//====================第一种实现================
//+(void)load{
//    //保证交换方法只执行一次
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        //获取到这个类的viewDidLoad方法，其为一个objc_method结构体指针
//        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
//        //获取新建方法
//        Method viewDidLoaded = class_getInstanceMethod(self, @selector(viewDidLoaded));
//        //交换实现
//        method_exchangeImplementations(viewDidLoad, viewDidLoaded);
//        
//    });
//}
//
//- (void)viewDidLoaded{
//    [self viewDidLoaded];
//    NSLog(@"%@ did load",self);
//}
//========================第二种实现===============================
+(void)load{
    //保证交换方法只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //获取类的viewDidLoad方法，他的类型是一个objc_method结构体指针
        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
        //获取方法实现，实现的viewDidLoad方法是返回为void的类型，需要用_VIMP
        _VIMP viewDidLoad_IMP = (_VIMP)method_getImplementation(viewDidLoad);
        //重新设置实现
        method_setImplementation(viewDidLoad, imp_implementationWithBlock(^(id target,SEL action){
            viewDidLoad_IMP(target,@selector(viewDidLoad));
            NSLog(@"%@ did load",target);
        }));
    });
}

@end
