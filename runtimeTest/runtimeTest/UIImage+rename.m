//
//  UIImage+rename.m
//  runtimeTest
//
//  Created by ltchina on 15/12/31.
//  Copyright (c) 2015年 ltchina. All rights reserved.
//
#import <objc/message.h>
#import "UIImage+rename.h"
/*
 *开发使用场景:系统自带的方法功能不够，给系统自带的方法扩展一些功能，并且保持原有的功能。
 *方式一:继承系统的类，重写方法.
 *方式二:使用runtime,交换方法.
 */
@implementation UIImage (rename)
+(void)load{//加载分类到内存的时候调用
    //交换方法
    
    //获取imageWithNmae方法地址
    Method imageWithName = class_getClassMethod(self, @selector(imageWithName:));
    
    //获取imageWithName方法地址
    Method imageName = class_getClassMethod(self, @selector(imageNamed:));
    method_exchangeImplementations(imageWithName, imageName);
}

//不能在分类中重写系统方法imageNamed,因为会把系统的功能给覆盖掉，而且分类中不能调用super.
+ (instancetype)imageWithName:(NSString *)name{
    //这是调用imageWithName,相当于调用imageName
    UIImage *image = [self imageWithName:name];
    
    if (image == nil) {
        NSLog(@"加载到小丸子了吗？");
    }
    return image;
}
@end
