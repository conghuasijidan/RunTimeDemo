//
//  UIImageView+EXC.m
//  RunTime交换方法
//
//  Created by 叶文凯 on 16/11/17.
//  Copyright © 2016年 葱花思鸡蛋. All rights reserved.
//

#import "UIImageView+EXC.h"
#import <objc/runtime.h>
@implementation UIImageView (EXC)
// 交换方法
+ (void)load
{
   Method  m1 = class_getInstanceMethod([self class], @selector(setImage:));
   Method  m2 = class_getInstanceMethod([self class], @selector(yk_setImage:));
    
    method_exchangeImplementations(m1, m2);
}

-(void)yk_setImage:(UIImage *)image
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    [image drawInRect:self.bounds];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    [self yk_setImage:img];
}
// 给分类添加属性
- (void)setImageName:(NSString *)imageName
{
    //使用关联对象设置值
    objc_setAssociatedObject(self, @"name", imageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)imageName
{
    //获取关联对象设置的值
    NSString *imgName = objc_getAssociatedObject(self, @"name");
    return imgName;
}
@end
