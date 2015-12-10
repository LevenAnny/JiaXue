//
//  CategoryModelManager.h
//  JiaXue
//
//  Created by xiang_jj on 15/11/24.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryModel.h"
#import "CategoryListModel.h"
#import "CategoryDetailModel.h"

@interface CategoryModelManager : NSObject

+(NSArray *)arrayWithRequestData:(NSData *)data;

+(NSArray *)arrayWithRequestDataForCategoryDetailModel:(NSData *)data;

@end
