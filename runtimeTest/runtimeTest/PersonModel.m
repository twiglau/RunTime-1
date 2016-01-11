//
//  PersonModel.m
//  runtimeTest
//
//  Created by ltchina on 16/1/11.
//  Copyright (c) 2016年 ltchina. All rights reserved.
//

#import "PersonModel.h"
#import "CompanyModel.h"
#import <objc/runtime.h>
@interface PersonModel()
//receiver
@property (nonatomic,strong) CompanyModel *companyMdel;
@end
@implementation PersonModel
@dynamic name;
- (id)init{
    self = [super init];
    if (self) {
        _companyMdel = [[CompanyModel alloc] init];
    }
    return self;
}
/*通过这个方法来实现name属性的处理。其他两个转发
 *的处理则放到下一步
 *
 */
+(BOOL)resolveInstanceMethod:(SEL)sel{
    NSString *selStr = NSStringFromSelector(sel);
    if ([selStr isEqualToString:@"name"]) {
        //增加name方法的实现
        class_addMethod(self, sel, (IMP)nameGetter, "@@:");
        return YES;
    }
    if ([selStr isEqualToString:@"setName:"]) {
        class_addMethod(self, sel, (IMP)nameSetter, "v@:@");
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

/*
 *这个方法用于处理name方法的消息转发
 */
void nameSetter(id self,SEL cmd,id value){
    NSString *fullName = value;
    NSArray *nameArray = [fullName componentsSeparatedByString:@" "];
    PersonModel *model = (PersonModel *)self;
    //在转发方法中实现对这两个属性的赋值.
    model.firstName = nameArray[0];
    model.lastName = nameArray[1];
}
/*
 *这个方法用于处理name方法的消息转发
 */
id nameGetter(id self,SEL cmd){
    PersonModel *model = (PersonModel *)self;
    NSMutableString *name = [NSMutableString string];
    if (model.firstName !=nil) {
        [name appendString:model.firstName];
        [name appendString:@" "];
    
    }
    if (model.lastName !=nil) {
        [name appendString:model.lastName];
    }
    return name;
}
/*
 *这里companyName这个方法则转发self.companyModel来处理，其他的下一步
 */
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSString *selStr = NSStringFromSelector(aSelector);
    //companyName,则处理转发
    if ([selStr isEqualToString:@"companyName"]) {
        //返回处理这个转发的对象
        return self.companyMdel;
    }else{
        return [super forwardingTargetForSelector:aSelector];
    }
}

/*是自己新建方法签名，再在forwardInvocation中用你要转发的那个对象调用这个对应的签名
 *这样也实现了消息转发
 *
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *sig = nil;
    NSString *selStr = NSStringFromSelector(aSelector);
    if ([selStr isEqualToString:@"deptName"]) {
        
        //此处返回的sig 是方法forwardInvocation的参数anInvocation中的
        //methodSignture---为你的转发手动生成签名
        sig = [self.companyMdel methodSignatureForSelector:@selector(deptName:)];
    }else{
        sig = [super methodSignatureForSelector:aSelector];
    }
    return sig;
}
/*
 *转发方法打包转发出去
 */
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    NSString *selStr = NSStringFromSelector(anInvocation.selector);
    if ([selStr isEqualToString:@"deptName"]) {
        //设置处理转发的对象
        [anInvocation setTarget:self.companyMdel];
        //设置转发对象要用的方法
        [anInvocation setSelector:@selector(deptName:)];
        BOOL hasCompanyName = YES;
        //第一个和第二个参数 是target 和sel
        [anInvocation setArgument:&hasCompanyName atIndex:2];
        [anInvocation retainArguments];
        [anInvocation invoke];
    }else{
        [super forwardInvocation:anInvocation];
    }
}
@end
