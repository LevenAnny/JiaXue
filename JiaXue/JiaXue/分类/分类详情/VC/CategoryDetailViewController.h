//
//  CategoryDetailViewController.h
//  JiaXue
//
//  Created by xiang_jj on 15/11/25.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"

@interface CategoryDetailViewController : UIViewController

@property(nonatomic,strong)CategoryModel *model;
@property(nonatomic,assign)NSInteger index;

@end
