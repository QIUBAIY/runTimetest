//
//  UIButton+ClickBlock.h
//  runTimeTest
//
//  Created by apple on 2017/6/23.
//  Copyright © 2017年 YY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^whenClickBlock)(void);
@interface UIButton(ClickBlock)
@property (nonatomic,copy) whenClickBlock whenClickBlock;
@end
