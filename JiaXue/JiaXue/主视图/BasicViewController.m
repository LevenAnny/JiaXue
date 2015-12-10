//
//  ViewController.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/24.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];

    
    self.title =@"最爱佳学";
   
    //设置标题的颜色
    if (iOS6) {
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor redColor]}];
    }else if (iOS7){
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    }
    
    [self creatbtn];
    [self creatBactItem];
    
}

#pragma mark - 导航栏按钮
- (void)creatbtn{
    
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"saomiao"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItem:)];
     [rightItem setTintColor:[UIColor redColor]];
    self.navigationItem.rightBarButtonItem =rightItem;
}

- (void)creatBactItem{
    
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"guanyu"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItem:)];
    [leftItem setTintColor:[UIColor redColor]];
    self.navigationItem.leftBarButtonItem =leftItem;

}

#pragma mark -点击左边按钮

- (void)leftItem:(UIBarButtonItem *)item{

    
    
}

#pragma mark -点击右边按钮

- (void)rightItem:(UIBarButtonItem *)item{
  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
