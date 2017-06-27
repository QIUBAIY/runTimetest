//
//  NSobject+Model.h
//  runTimeTest
//
//  Created by apple on 2017/6/27.
//  Copyright © 2017年 YY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Model)
+(id)modelWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary *)dictionaryWithModel;
@end
