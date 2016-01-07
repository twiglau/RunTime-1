//
//  main.m
//  runtimeTest
//
//  Created by ltchina on 15/12/31.
//  Copyright (c) 2015年 ltchina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MyClass.h"

#import <objc/runtime.h>

void ReportFunction(id self,SEL _cmd){
    NSLog(@"This object is %p.",self);
    NSLog(@"Class is %@,and super is %@.",[self class],[self superclass]);
    Class currentClass = [self class];
    
    for (int i = 1; i<5; ++i) {
        NSLog(@"Following the isa pointer %d times gives %p",i,currentClass);
    }
    NSLog(@"NSObject's class is %p",[NSObject class]);
    NSLog(@"NSObject's meta class is %p",object_getClass([NSObject class]));
}
int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        MyClass *myClass = [[MyClass alloc] init];
        
        unsigned int outCount = 0;
        Class cls = myClass.class;
        // 类名
        
        NSLog(@"class name: %s", class_getName(cls));NSLog(@"==========================================================");
        
        
        
        // 父类
        
        NSLog(@"super class name: %s", class_getName(class_getSuperclass(cls)));
        
    NSLog(@"==========================================================");
        
        
        
        // 是否是元类
        
        NSLog(@"MyClass is %@ a meta-class", (class_isMetaClass(cls) ? @"" : @"not"));
        
    NSLog(@"==========================================================");
        
        
        
        Class meta_class = objc_getMetaClass(class_getName(cls));
        
        NSLog(@"%s's meta-class is %s", class_getName(cls), class_getName(meta_class));
        
    NSLog(@"==========================================================");
        // 变量实例大小
        
        NSLog(@"instance size: %zu", class_getInstanceSize(cls));
        
    NSLog(@"==========================================================");
        
        // 成员变量
        
        Ivar *ivars = class_copyIvarList(cls, &outCount);
        
        for (int i = 0; i < outCount; i++) {
            
            Ivar ivar = ivars[i];
            
            NSLog(@"instance variable's name: %s at index: %d", ivar_getName(ivar), i);
            
        }
        
        free(ivars);
        
        Ivar string = class_getInstanceVariable(cls, "_string");
        
        if (string != NULL) {
            
            NSLog(@"instace variable %s", ivar_getName(string));
            
        }
    NSLog(@"==========================================================");
        
        // 属性操作
        
        objc_property_t * properties = class_copyPropertyList(cls, &outCount);
        
        for (int i = 0; i < outCount; i++) {
            
            objc_property_t property = properties[i];
            
            NSLog(@"property's name: %s", property_getName(property));
            
        }
        
        free(properties);
        objc_property_t array = class_getProperty(cls, "array");
        
        if (array != NULL) {
            
            NSLog(@"property %s", property_getName(array));
            
        }
    NSLog(@"==========================================================");
        
        // 方法操作
        
        Method *methods = class_copyMethodList(cls, &outCount);
        
        for (int i = 0; i < outCount; i++) {
            
            Method method = methods[i];
            
            NSLog(@"method's signature: %s", method_getName(method));
            
        }
        free(methods);
        Method method1 = class_getInstanceMethod(cls, @selector(method1));
        
        if (method1 != NULL) {
            
            NSLog(@"method %s", method_getName(method1));
            
        }
        
        Method classMethod = class_getClassMethod(cls, @selector(classMethod1));
        
        if (classMethod != NULL) {
            
            NSLog(@"class method : %s", method_getName(classMethod));
            
        }
        NSLog(@"MyClass is%@ responsd to selector: method3WithArg1:arg2:", class_respondsToSelector(cls, @selector(method3WithArg1:arg2:)) ? @"" : @" not");
        IMP imp = class_getMethodImplementation(cls, @selector(method1));
        
        imp();
    NSLog(@"==========================================================");
        
        // 协议
        
        Protocol * __unsafe_unretained * protocols = class_copyProtocolList(cls, &outCount);
        
        Protocol * protocol;
        
        for (int i = 0; i < outCount; i++) {
            
            protocol = protocols[i];
            
            NSLog(@"protocol name: %s", protocol_getName(protocol));
            
        }
    NSLog(@"MyClass is%@ responsed to protocol %s", class_conformsToProtocol(cls, protocol) ? @"" : @" not", protocol_getName(protocol));
NSLog(@"==========================================================");
        
        id theObject = class_createInstance([NSString class], sizeof(unsigned));
        id str1 = [theObject init];
        NSLog(@"%@",[str1 class]);
NSLog(@"==========================================================");
        id str2 = [[NSString alloc] initWithString:@"test"];
        NSLog(@"%@",[str2 class]);
        /*
         *可以看到，使用class_createInstance函数获取的是NSString实例，而不是类簇中的默认占位符类__NSCFConstantString。
         */
        
        
        /******************************************/
        /*What is Meta Class?*/
        
        /******************************/
        Class newClass = objc_allocateClassPair([NSError class], "RuntimeErrorSubclass", 0);
        class_addMethod(newClass, @selector(report), (IMP)ReportFunction, "v@:");
        objc_registerClassPair(newClass);
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
