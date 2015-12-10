//
//  ViewController.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/24.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "RootViewController.h"
#import "MySettingTableViewController.h"
#import "CategoryTableViewController.h"
#import "GoodsTableViewController.h"
#import "ListTableViewController.h"
#import "XJViewController.h"

@interface RootViewController ()<UIScrollViewDelegate>
{
    BOOL isApear;
}

@end

@implementation RootViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //在沙盒建一个文件夹，用于等待存储所有的视频资源
    NSFileManager *fm  = [NSFileManager defaultManager];
    [fm createDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie"] withIntermediateDirectories:YES attributes:nil error:nil];
    
    
    MySettingTableViewController  *setVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MySetVC"];
    setVC.view.frame = CGRectMake(0, 0, screen_Width, screen_Height);
    [self.view addSubview:setVC.view];
    [self addChildViewController:setVC];

    
    NSArray *array = @[@"CategoryTableViewController",@"GoodsTableViewController",@"ListTableViewController"];
    NSMutableArray *vcs = [NSMutableArray array];
    for (int i = 0; i<3; i++) {
        Class class = NSClassFromString(array[i]);
        UIViewController *obj = [[class  alloc] init];
        [vcs addObject:obj];
    }
    
    XJViewController *xjj = [[XJViewController alloc] initWithBtnArray: @[@"分类",@"精品",@"排行"] andWithVCS:vcs andCurrentPage:3];

    xjj.view.frame = self.view.bounds;
    [self.view addSubview:xjj.view];
    [self addChildViewController:xjj];
    
}

- (void)leftItem:(UIBarButtonItem *)item{
    XJViewController *xj = self.childViewControllers[1];

    if (isApear == NO) {
        
        isApear = YES;
        [UIView animateWithDuration:1 animations:^{
            CGRect frame = xj.view.frame;
            frame.origin.x = screen_Width;
            xj.view.frame = frame;
            
        }];
    }else{
    
        [UIView animateWithDuration:1 animations:^{
            xj.view.frame = self.view.bounds;
        }];
        
        isApear = NO;
    }
    
}


@end















