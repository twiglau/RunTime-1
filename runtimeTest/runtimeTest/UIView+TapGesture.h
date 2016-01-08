//
//  UIView+TapGesture.h
//  runtimeTest
//
//  Created by ltchina on 16/1/7.
//  Copyright (c) 2016年 ltchina. All rights reserved.
//
/********************/
/*关联对象类似于成员变量，不过是在运行时添加的，我们不能在分类中添加成员变量。
 */
/*******************/
#import <UIKit/UIKit.h>
static char kDTActionHandlerTapGestureKey;
@interface UIView (TapGesture)
- (void)setTapActionWithBlock:(void(^)(void))block;
@end
