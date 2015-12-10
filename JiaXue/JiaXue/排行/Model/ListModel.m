//
//  ListModel.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/30.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "ListModel.h"
#import "GoodsModel.h"

@implementation ListModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{


}

+(NSArray *)arrayWithListModel:(NSData *)data{

    NSMutableArray *dataArr = [NSMutableArray array];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *array = dict[@"ranks"];
    for (NSDictionary *subDict in array) {
   
        ListModel *model = [[ListModel alloc] init];
        [model setValuesForKeysWithDictionary:subDict];
        
        NSMutableArray *courseArr = [NSMutableArray array];
        for (NSDictionary *courses in subDict[@"courses"]) {
            GoodsModel *goodModel = [[GoodsModel alloc] init];
            [goodModel setValuesForKeysWithDictionary:courses];
            [courseArr addObject:goodModel];
        }
        
        model.courses = courseArr;
        
        [dataArr addObject:model];
    }
    return dataArr;

}

@end
