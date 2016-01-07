//
//  MyClass.h
//  runtimeTest
//
//  Created by ltchina on 15/12/31.
//  Copyright (c) 2015年 ltchina. All rights reserved.
//

#import <Foundation/Foundation.h>

//-----------------------------------------------------------

// MyClass.h



@interface MyClass : NSObject <NSCopying, NSCoding>



@property (nonatomic, strong) NSArray *array;



@property (nonatomic, copy) NSString *string;



- (void)method1;



- (void)method2;



+ (void)classMethod1;



@end
