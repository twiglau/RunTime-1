//
//  Person.m
//  runtimeTest
//
//  Created by ltchina on 15/12/31.
//  Copyright (c) 2015年 ltchina. All rights reserved.
//
#import <objc/objc.h>
#import <objc/message.h>
#import "Person.h"
/*
 *开发使用场景：如果一个类方法非常多，加载类到内存的时候也比较耗费资源，需要给每个方法生成映射表，可以使用动态给某个类，添加方法解决。
 *经典面试题：有没有使用performSelector，其实主要想问你有没有动态添加过方法。
 *简单使用
 */
@implementation Person
//void(*)()
//默认方法都有两个隐式参数
void eat(id self,SEL sel ){
    NSLog(@"%@ %@",self,NSStringFromSelector(sel));
}

//当一个对象调用未实现的方法，会调用这个方法处理，并且会把对应的方法列表传过来
//刚好可以用来判断，未实现的方法是不是我们想要动态添加的方法
+(BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(eat)) {
        //动态添加eat方法
        
        //第一个参数：给哪个类添加方法
        //第二个参数：添加方法的方法编号
        //第三个参数: 添加方法的函数实现（函数地址）
        //第四个参数: 函数的类型，（返回值+参数类型）v:void @:对象->self :表示SEL->_cmd
        class_addMethod(self, @selector(eat), eat, "v@:");
    }
    return [super resolveInstanceMethod:sel];
}
@end
