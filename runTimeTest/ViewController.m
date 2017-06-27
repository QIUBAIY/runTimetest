//
//  ViewController.m
//  runTimeTest
//
//  Created by apple on 2017/6/16.
//  Copyright © 2017年 YY. All rights reserved.
//
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#import <objc/message.h>
#import "ViewController.h"
#import "testClass.h"
#import "UIButton+ClickBlock.h"
#import "cat.h"
#import "ViewController+login.h"
#import "myModel.h"
@interface ViewController ()

@end

@implementation ViewController{
    NSDictionary *_dictionary;

}
 - (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    _dictionary = @{
                   @"sex":@"man",
                   @"name":@"yaya",
                   @"age":@24,
                   @"height":@180.5,
                   @"weight":@65,
                   @"son":@{
                           @"name":@"yaya",
                           @"age":@24,
                           @"height":@180.5,
                           @"weight":@65
                           }
                  };
    
    
    
    

     [self modelTest];
//     [self exchangetest];
//     [self categoryTest];
//     [self msgSendTest];
  
    
    
    
    
    

}
-(void)modelTest{
    MyModel *model = [MyModel modelWithDictionary:_dictionary];
    NSLog(@"name is %@",model.name);
    NSLog(@"son name is %@",model.son.name);
    
    NSDictionary *dict = [model dictionaryWithModel];
    NSLog(@"dict is %@",dict);
}
-(void)exchangetest{
    //替换方法，动态加载方法
    ViewController * VC=[ViewController new];
    [[cat new]performSelector:@selector(miaow:) withObject:@"喵～"];
  
  
}
-(void)categoryTest{
    //用对象关联在Category内加属性
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = self.view.bounds;
    [self.view addSubview:button];
    __weak UIButton * weakbutton=button;
    button.whenClickBlock = ^{
        //随机改变颜色
        weakbutton.backgroundColor=randomColor;
    };
}
-(void)msgSendTest{
    //objc_msgSend调用
    testClass *objct = [[testClass alloc] init];
    
    ((void (*) (id, SEL)) objc_msgSend) (objct, sel_registerName("showAge"));
    
    ((void (*) (id, SEL, NSString *)) objc_msgSend) (objct, sel_registerName("showName:"), @"Dave Ping");
    
    ((void (*) (id, SEL, float, float)) objc_msgSend) (objct, sel_registerName("showSizeWithWidth:andHeight:"), 110.5f, 200.0f);
    
    float f = ((float (*) (id, SEL)) objc_msgSend_fpret) (objct, sel_registerName("getHeight"));
    NSLog(@"height is %.2f",f);
    
    NSString *info = ((NSString* (*) (id, SEL)) objc_msgSend) (objct, sel_registerName("getInfo"));
    NSLog(@"%@",info);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

@end
