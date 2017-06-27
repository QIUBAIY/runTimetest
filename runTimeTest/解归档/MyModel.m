//
//  myModel.m
//  runTimeTest
//
//  Created by apple on 2017/6/26.
//  Copyright © 2017年 YY. All rights reserved.
//

#import "MyModel.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation MyModel
- (id) initWithCoder: (NSCoder *)aDecoder{
    if (self=[super init]) {
        unsigned int outcount=0;
        Ivar * vars=class_copyIvarList([self class], &outcount);
        for (int i=0; i<outcount; i++) {
            
            Ivar var=vars[i];
            const char * name=ivar_getName(var);
            NSString * key=[NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
           //释放vars
           free(vars);
    }
    return self;
}
- (void) encodeWithCoder: (NSCoder *)aCoder{
    unsigned int outcount=0;
    Ivar * vars=class_copyIvarList([self class],&outcount );
    for (int i=0 ; i<outcount; i++) {
        Ivar var=vars[i];
        const char * name=ivar_getName(var);
        NSString * key=[NSString stringWithUTF8String:name];
        id value=[self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(vars);
    
}
@end
