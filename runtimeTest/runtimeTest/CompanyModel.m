//
//  CompanyModel.m
//  runtimeTest
//
//  Created by ltchina on 16/1/11.
//  Copyright (c) 2016年 ltchina. All rights reserved.
//

#import "CompanyModel.h"

@implementation CompanyModel
- (NSString *)companyName{
    return @"Test Company";
}

- (NSString *)deptName:(BOOL)isWithCompanyName{
    if (isWithCompanyName) {
        return @"Test the development of company";
    }else{
        return @"Development";
    }
}
@end
