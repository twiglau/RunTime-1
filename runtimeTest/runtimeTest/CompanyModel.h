//
//  CompanyModel.h
//  runtimeTest
//
//  Created by ltchina on 16/1/11.
//  Copyright (c) 2016年 ltchina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyModel : NSObject
- (NSString *)companyName;
- (NSString *)deptName:(BOOL)isWithCompanyName;
@end
