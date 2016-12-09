//
//  NSObject+yk_Runtime.h
//  runtime关联对象
//
//  Created by 叶文凯 on 16/11/7.
//  Copyright © 2016年 葱花思鸡蛋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (yk_Runtime)
// 获取属性名
+(NSArray *)yk_propertyArray;
// 获取成员变量名
+(NSArray *)yk_ivarArray;
// 获取方法名
+ (NSArray *)yk_methodList;
// 获取协议名
+ (NSArray *)yk_protocolList;
//字典转模型
+ (instancetype)modelWithDict:(NSDictionary *)dict;
// 数组字典转模型
+ (NSArray *)modelWithDictArray:(NSArray *)array;

@end
