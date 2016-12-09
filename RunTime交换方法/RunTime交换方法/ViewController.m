//
//  ViewController.m
//  RunTime交换方法
//
//  Created by 叶文凯 on 16/11/17.
//  Copyright © 2016年 葱花思鸡蛋. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+EXC.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iamgeView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.iamgeView.image = [UIImage imageNamed:@"001.jpg"];
    self.iamgeView.imageName = @"1";
    
    
    [self.imgView1 yk_setImage:[UIImage imageNamed:@"001.jpg"]];
    self.imgView1.imageName = @"2";
    
    NSLog(@"iamgeView.name = %@ ,imgView1.imageName = %@",self.iamgeView.imageName,self.imgView1.imageName);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
