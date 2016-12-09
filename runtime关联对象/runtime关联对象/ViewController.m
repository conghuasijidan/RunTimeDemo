//
//  ViewController.m
//  runtime关联对象
//
//  Created by 叶文凯 on 16/11/7.
//  Copyright © 2016年 葱花思鸡蛋. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+yk_Runtime.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSArray *arr = [Person yk_propertyArray];
//    NSLog(@"%@",arr);
//    
//    NSArray *arr1 = [Person yk_ivarArray];
//    NSLog(@"%@",arr1);
//    Person *person = [Person modelWithDict:@{@"name":@"zhangSan",@"title":@"haha"}];
//    NSLog(@"%@,%@",person.name,person.title);
    NSArray *arr = @[@{@"name":@"zhangSan",@"title":@"haha"},@{@"name":@"zhangSan",@"title":@"haha"}];
    NSArray<Person *>*modelList = [Person modelWithDictArray:arr];
    for (Person *p in modelList) {
        NSLog(@"%@--%@",p.name,p.title);
    }
    
}


@end
