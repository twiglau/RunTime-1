//
//  NSObject+addProperty.m
//  runtimeTest
//
//  Created by ltchina on 15/12/31.
//  Copyright (c) 2015年 ltchina. All rights reserved.
//
/*
4.给分类添加属性
原理：给一个类声明属性，其实本质就是给这个类添加关联，并不是直接把这个值的内存空间添加到类存空间。
 */
#import <objc/objc.h>
#import <objc/message.h>
#import "NSObject+addProperty.h"
//定义关联的key
static const char *key = "name";
@implementation NSObject (addProperty)

- (NSString *)name{
    //根据关联的key，获取关联的值.
    return objc_getAssociatedObject(self, key);
}

- (void)setName:(NSString *)name{
    //第一个参数:给哪个对象添加关联
    //第二个参数:关联的key,通过这个key获取
    //第三个参数:关联的value
    //第四个参数:关联的策略
    objc_setAssociatedObject(self, key, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
