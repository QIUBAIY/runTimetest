//
//  UIButton+ClickBlock.m
//  runTimeTest
//
//  Created by apple on 2017/6/23.
//  Copyright © 2017年 YY. All rights reserved.
//

#import "UIButton+ClickBlock.h"
#import <objc/runtime.h>
static const void *associatedKey = "associatedKey";
@implementation UIButton(ClickBlock)

-(void)setWhenClickBlock:(whenClickBlock)whenClickBlock{
    objc_setAssociatedObject(self, associatedKey, whenClickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self removeTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    if (whenClickBlock) {
        [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(whenClickBlock)whenClickBlock{
    return objc_getAssociatedObject(self, associatedKey);
}

-(void)buttonClick{
    if (self.whenClickBlock) {
        self.whenClickBlock();
    }
}

@end
