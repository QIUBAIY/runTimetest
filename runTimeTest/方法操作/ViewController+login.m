//
//  ViewController+login.m
//  runTimeTest
//
//  Created by apple on 2017/6/26.
//  Copyright © 2017年 YY. All rights reserved.
//

#import "ViewController+login.h"
#import <objc/runtime.h>

@implementation UIViewController (login)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class=[self class];
        SEL originalSelector = @selector(viewDidAppear:);
        SEL swizzledSelector = @selector(swizzledViewDidAppear:);
        swizzleMethod(class, originalSelector, swizzledSelector);
       
    });
    
    
}
void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
     // Method : 包含了一个方法的  方法名 + 实现 + 参数个数及类型 + 返回值个数及类型 等信息
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    //IMP：方法的地址
    IMP swizzledImp = method_getImplementation(swizzledMethod);
    char *swizzledTypes = (char *)method_getTypeEncoding(swizzledMethod);
    IMP originalImp = method_getImplementation(originalMethod);
    char *originalTypes = (char *)method_getTypeEncoding(originalMethod);
    BOOL success = class_addMethod(class, originalSelector, swizzledImp, swizzledTypes);
    //避免UIViewController父类实现swizzledViewDidAppear影响
    if (success) {
        //替换
        class_replaceMethod(class, swizzledSelector, originalImp, originalTypes);
    }else {
        // 失败，表明已经有这个方法，直接交换
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}



- (void)swizzledViewDidAppear:(BOOL)animation {
    [self swizzledViewDidAppear:animation];
    NSLog(@"YLZ：%@ viewDidAppear", NSStringFromClass([self class]));
}
@end
