//
//  NSObject+yk_Runtime.m
//  runtime关联对象
//
//  Created by 叶文凯 on 16/11/7.
//  Copyright © 2016年 葱花思鸡蛋. All rights reserved.
//

#import "NSObject+yk_Runtime.h"
#import <objc/runtime.h>
@implementation NSObject (yk_Runtime)
// 字典数组转模型
+ (NSArray *)modelWithDictArray:(NSArray *)array
{
    if (array.count == 0) {
        NSLog(@"数组为空！");
        return nil;
    }
    NSAssert([array[0] isKindOfClass:[NSDictionary class]], @"数组内容必须为字典");
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        // 创建模型对象
        id instance = [self modelWithDict:dict];
        [arr addObject:instance];
    }
    return arr.copy;
}
// 字典转模型
+(instancetype)modelWithDict:(NSDictionary *)dict
{
    id instance = [[self alloc] init];
    //获取属性列表 不能每次都用调用获取属性列表的方法 效率太低
    NSArray *prolist = [self yk_propertyArray];
    //遍历字典
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        // 判断字典属性是否在属性列表中
        if ([prolist containsObject:key]) {
            [instance setValue:obj forKey:key];
        }
    }];
    return instance;
}

const void * kAssociateObjectKey = @"kAssociateObjectKey";
+ (NSArray *)yk_propertyArray
{
    //关联属性
    NSArray *prolist = objc_getAssociatedObject(self, kAssociateObjectKey);
    if (prolist != nil) {
        return prolist;
    }
    unsigned int count ;
    objc_property_t *protertylist =  class_copyPropertyList([self class], &count);
    //临时可变数组
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSInteger i = 0; i<count; i++) {
      //取出属性
      objc_property_t proterty =  protertylist[i];
      //获取属性名
      const char *name = property_getName(proterty);
      NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        [arrM addObject:nameStr];
    }
    // 设置关联属性
    objc_setAssociatedObject(self, kAssociateObjectKey, arrM.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //释放内存
    free(protertylist);
    return arrM.copy;
}
// 获取成员变量
+(NSArray *)yk_ivarArray
{
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i<count; i++) {
        // 取出成员变量
        Ivar ivar = ivarList[i];
        // 获取成员变量名
        const char *name = ivar_getName(ivar);
        // 将C语言字符串转化为OC字符串
        NSString *ivarStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        NSLog(@"ivar = %@",ivarStr);
        [arr addObject:ivarStr];
    }
    free(ivarList);
//    NSLog(@"%zd",count);
    return arr.copy;
}
//获取方法名
+ (NSArray *)yk_methodList{
    unsigned int count;
    Method *list = class_copyMethodList([self class], &count);
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i<count; i++) {
        // 获取方法结构体
         Method m = list[i];
        // 获取方法名
         SEL selector = method_getName(m);
         // 转化为字符串
        NSString *name = NSStringFromSelector(selector);
        [arr addObject:name];
    }
    free(list);
    return arr.copy;
}
// 获取协议名
+ (NSArray *)yk_protocolList{
    unsigned int count;
    // 返回值需要标记
    __unsafe_unretained  Protocol ** proList = class_copyProtocolList([self class], &count);
    NSMutableArray *arr = [NSMutableArray array];
    //遍历求协议名
    for (NSInteger i = 0; i<count; i++) {
      Protocol *pro = proList[i];
      const char *name = protocol_getName(pro);
      NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
      [arr addObject:nameStr];
    }
    free(proList);
    return arr.copy;
}

@end
