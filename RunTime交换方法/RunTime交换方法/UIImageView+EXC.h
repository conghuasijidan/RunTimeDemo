//
//  UIImageView+EXC.h
//  RunTime交换方法
//
//  Created by 叶文凯 on 16/11/17.
//  Copyright © 2016年 葱花思鸡蛋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (EXC)
@property(copy,nonatomic)NSString *imageName;
-(void)yk_setImage:(UIImage *)image;
@end
