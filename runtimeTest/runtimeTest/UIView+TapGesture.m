//
//  UIView+TapGesture.m
//  runtimeTest
//
//  Created by ltchina on 16/1/7.
//  Copyright (c) 2016年 ltchina. All rights reserved.
//

#import "UIView+TapGesture.h"
#import <objc/runtime.h>
@implementation UIView (TapGesture)
/*
 动态地将一个Tap手势操作连接到任何UIView中，并且根据需要指定点击后的实际操作。这时候
 就可以将一个手势对象及操作的block对象关联到我们的UIView对象中。这项任务分两部分。首先，如果需要，要创建一个手势识别对象并将它及block做为关联对象。
 */
- (void)setTapActionWithBlock:(void(^)(void))block{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
    }
    //注意：block对象的关联内存管理策略
    objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
        
        if (action) {
            action();
        }
    }
}
@end
