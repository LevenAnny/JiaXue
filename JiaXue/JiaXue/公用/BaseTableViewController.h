//
//  BaseTableViewController.h
//  JiaXue
//
//  Created by xiang_jj on 15/11/30.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface BaseTableViewController : UITableViewController

@property(nonatomic,strong)NSArray *dataArray;
//
@property(nonatomic,copy)NSString *coureseStr;

@property(nonatomic,copy)NSString *titleStr;

@property(nonatomic,copy)NSString *idStr;
@end
