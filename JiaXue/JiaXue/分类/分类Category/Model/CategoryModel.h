//
//  CategoryModel.h
//  JiaXue
//
//  Created by xiang_jj on 15/11/24.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryListModel.h"
@interface CategoryModel : NSObject

@property(nonatomic,copy)NSString *myID;
@property(nonatomic,copy)NSString *iconUrl;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSArray  *subcategories;

@end
