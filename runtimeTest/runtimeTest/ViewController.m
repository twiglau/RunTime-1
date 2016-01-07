//
//  ViewController.m
//  runtimeTest
//
//  Created by ltchina on 15/12/31.
//  Copyright (c) 2015年 ltchina. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+rename.h"
#import "Person.h"
#import "NSObject+addProperty.h"
@interface ViewController ()
@property (retain, nonatomic) IBOutlet UIImageView *testImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**1.交换*************/
    // 需求：给imageNamed方法提供功能，每次加载图片就判断下图片是否加载成功。
    // 步骤一：先搞个分类，定义一个能加载图片并且能打印的方法+ (instancetype)imageWithName:(NSString *)name;
    // 步骤二：交换imageNamed和imageWithName的实现，就能调用imageWithName，间接调用imageWithName的实现。
    UIImage *image = [UIImage imageNamed:@"123"];
    [self.testImageView setImage:image];
    
    /**2.动态添加方法**********/
    Person *p = [[Person alloc] init];
    
    // 默认person，没有实现eat方法，可以通过performSelector调用，但是会报错。
    // 动态添加方法就不会报错
    [p performSelector:@selector(eat)];
    
    
    
    // 给系统NSObject类动态添加属性name
    
    NSObject *objc = [[NSObject alloc] init];
    objc.name = @"啊啦啊啦，可用不？";
    NSLog(@"%@",objc.name);
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
