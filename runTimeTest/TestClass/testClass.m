//
//  testClass.m
//  runTimeTest
//
//  Created by apple on 2017/6/16.
//  Copyright © 2017年 YY. All rights reserved.
//

#import "testClass.h"
#import <objc/message.h> 
@implementation testClass
-(instancetype)init{
    if (self = [super init]) {
        [self runTimeTestAction];
    }
    return self;
}

-(void)runTimeTestAction{
    NSLog(@"runTime");
}
-(void)showAge{
    NSLog(@"123");
}

-(void)showName:(NSString *)aName{
    NSLog(@"name: %@",aName);
}

-(void)showSizeWithWidth:(float)aWidth andHeight:(float)aHeight{
    NSLog(@"size: %.2f * %.2f",aWidth, aHeight);
}

-(float)getHeight{
    return 1.2345f;
}

-(NSString *)getInfo{
    return @"Hi, nice to meet you.";
}

@end
