//
//  CategoryModelManager.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/24.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "CategoryModelManager.h"


@implementation CategoryModelManager
+(NSArray *)arrayWithRequestData:(NSData *)data{
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSArray *array = dict[@"subcategories"];
    
    for (NSDictionary *dict in array) {
        CategoryModel *model = [[CategoryModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        
        
        NSMutableArray *subArray = [NSMutableArray array];
        for (NSDictionary *subDict in dict[@"subcategories"]) {
            CategoryListModel *listModel = [[CategoryListModel alloc] init];
            [listModel setValuesForKeysWithDictionary:subDict];
            [subArray addObject:listModel];
        }
        
        model.subcategories = subArray;
        
        [dataArray addObject:model];
    }
         return dataArray;
}


+(NSArray *)arrayWithRequestDataForCategoryDetailModel:(NSData *)data
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    for (NSDictionary *subDict in dict[@"courses"]) {
        
        CategoryDetailModel *model = [[CategoryDetailModel alloc] init];
        [model setValuesForKeysWithDictionary:subDict];
        [dataArray addObject:model];
        
    }
    return dataArray;
}
@end








