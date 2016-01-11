//
//  PersonModel.h
//  runtimeTest
//
//  Created by ltchina on 16/1/11.
//  Copyright (c) 2016年 ltchina. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CompanyModel;
@interface PersonModel : NSObject
@property(nonatomic,copy) NSString *firstName;
@property (nonatomic,copy) NSString *lastName;
//这个属性在实现文件 里面设置为动态属性、所以并不会生成get和set方法
@property (nonatomic,copy) NSString *name;

//没有实现
- (NSString *)companyName;
- (NSString *)deptName;
@end
