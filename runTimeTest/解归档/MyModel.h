//
//  myModel.h
//  runTimeTest
//
//  Created by apple on 2017/6/26.
//  Copyright © 2017年 YY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSobject+Model.h"
@interface MyModel : NSObject<NSCoding>
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, copy) NSNumber *height;
@property (nonatomic, copy) NSNumber *weight;
@property (nonatomic, strong) MyModel *son;
@end
