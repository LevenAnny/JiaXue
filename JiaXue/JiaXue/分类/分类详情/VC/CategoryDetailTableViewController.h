//
//  CategoryDetailTableViewController.h
//  JiaXue
//
//  Created by xiang_jj on 15/11/25.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModelManager.h"
#import "MyAFNetWorkingRequest.h"

@interface CategoryDetailTableViewController : UITableViewController


@property(nonatomic,strong)NSMutableArray *dataArray;

-(void)loadRequestDataWithUrlStr:(NSString *)urlStr;
@end
