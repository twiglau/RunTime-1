//
//  ViewController.m
//  runtimeTest
//
//  Created by ltchina on 15/12/31.
//  Copyright (c) 2015年 ltchina. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+IMP_C.h"
#import "UIImage+rename.h"
#import <objc/runtime.h>
#import "Person.h"
#import "NSObject+addProperty.h"
#import "UIView+TapGesture.h"
#import "MyClass.h"
static char kDTActionHandlerTapGestureKey;
@interface ViewController ()
@property (retain, nonatomic) IBOutlet UIImageView *testImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**1.交换*************/
    [self exchange_Method];
    
    /**2.动态添加方法**********/
    [self addDymantic_Method];
    
    /**3.动态创建类**/
    [self createDymantic_Class];
    
    /**4.创建关联对象*/
    [self createAssociate_Object];
}

- (void)createAssociate_Object{
    [self.view setTapActionWithBlock:^{
        NSLog(@"定制点击效果，，，如何？");
    }];
}
- (void)exchange_Method{
    // 需求：给imageNamed方法提供功能，每次加载图片就判断下图片是否加载成功。
    // 步骤一：先搞个分类，定义一个能加载图片并且能打印的方法+ (instancetype)imageWithName:(NSString *)name;
    // 步骤二：交换imageNamed和imageWithName的实现，就能调用imageWithName，间接调用imageWithName的实现。
    UIImage *image = [UIImage imageNamed:@"123"];
    [self.testImageView setImage:image];
}
- (void)addDymantic_Method{
    Person *p = [[Person alloc] init];
    // 默认person，没有实现eat方法，可以通过performSelector调用，但是会报错。
    // 动态添加方法就不会报错
    [p performSelector:@selector(eat)];
    // 给系统NSObject类动态添加属性name
    
    NSObject *objc = [[NSObject alloc] init];
    objc.name = @"啊啦啊啦，可用不？";
    NSLog(@"%@",objc.name);
}
- (void)createDymantic_Class{
    Class cls = objc_allocateClassPair([MyClass class], "MySubClass", 0);
    class_addMethod(cls, @selector(submethod1), (IMP)imp_submethod1, "v@:");
    //分为两种:如果类中不存在name的指定的方法，则类似于class_addMethod函数一样会添加方法；如果类中已存在name指定的方法，则类似于method_setImplemention一样替代原方法的实现。。。
    class_replaceMethod(cls, @selector(method1), (IMP)imp_submethod1, "v@:");
    class_addIvar(cls, "_ivar1", sizeof(NSString *), log(sizeof(NSString *)), "i");
    objc_property_attribute_t type = {"T","@\"NSSting\""};
    objc_property_attribute_t ownership = {"C","" };
    objc_property_attribute_t  backingivar = {"V", "_ivar1"};
    objc_property_attribute_t attrs[] = {type,ownership,backingivar};
    
    class_addProperty(cls, "property2", attrs, 3);
    objc_registerClassPair(cls);
    
    id instance = [[cls alloc] init];
    [instance performSelector:@selector(method1)];
    [instance performSelector:@selector(submethod1)];
}

void imp_submethod1(id self,SEL _cmd){
    NSLog(@"%p-----@@@@@@-------",_cmd);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_testImageView release];
    [super dealloc];
}
@end
