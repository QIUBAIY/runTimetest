//
//  NSobject+Model.m
//  runTimeTest
//
//  Created by apple on 2017/6/27.
//  Copyright © 2017年 YY. All rights reserved.
//

#import "NSobject+Model.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation NSObject (Model)
//字典->模型
+(id)modelWithDictionary:(NSDictionary *)dictionary{
    id model=[self new];
    for (NSString * key in dictionary.allKeys) {
        id value=dictionary[key];
        //根据KEY取出当前属性
        objc_property_t property=class_getProperty(self, key.UTF8String);
        //判断当前属性
        unsigned int outCount=0;
//        typedef struct {
//            const char *name;           /**< The name of the attribute */
//            const char *value;          /**< The value of the attribute (usually empty) */
//        } objc_property_attribute_t;
        objc_property_attribute_t * attributeList=property_copyAttributeList(property, &outCount);
        objc_property_attribute_t attribute=attributeList[0];
        NSString * typeString=[NSString stringWithUTF8String:attribute.value];
         /*判断当前属性是不是Model*/
        if ([typeString isEqualToString:@"@\"MyModel\""]) {
            value=[self modelWithDictionary:value];
        }
         //生成setter方法，并用objc_msgSend调用
           NSString *methodName = [NSString stringWithFormat:@"set%@%@:",[key substringToIndex:1].uppercaseString,[key substringFromIndex:1]];
        SEL setter = sel_registerName(methodName.UTF8String);
        if ([model respondsToSelector:setter]) {
            ((void (*) (id,SEL,id)) objc_msgSend) (model,setter,value);
        }
        free(attributeList);
    }
    return model;
}
//模型->字典
-(NSDictionary *)dictionaryWithModel{
    unsigned int outCount=0;
    objc_property_t * propertyList=class_copyPropertyList([self class], &outCount);
    NSMutableDictionary * dictionary=[NSMutableDictionary dictionary];
    for (int i=0; i<outCount; i++) {
        objc_property_t property=propertyList[i];
        const char *propertyNmae=property_getName(property);
        SEL getter=sel_registerName(propertyNmae);
        if ([self respondsToSelector:getter]) {
            id value=((id(*) (id,SEL)) objc_msgSend)(self,getter);
            /*判断当前属性是不是Model*/
            if ([value isKindOfClass:[self class]] && value) {
                value = [value dictionaryWithModel];
            }
            /**********************/
            if (value) {
                NSString *key = [NSString stringWithUTF8String:propertyNmae];
                [dictionary  setObject:value forKey:key];
            }
        }
    }
    free(propertyList);
    return dictionary;
}
@end
