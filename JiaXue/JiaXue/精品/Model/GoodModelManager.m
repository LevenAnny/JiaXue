//
//  GoodModelManager.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/30.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "GoodModelManager.h"

@implementation GoodModelManager

+(NSArray *)arrayWithBannerModel:(NSData *)data
{

    NSMutableArray *bannerArra = [NSMutableArray array];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray  *itemsArray  = dict[@"items"];
    NSDictionary *subDict1 = itemsArray[0] ;
    NSArray *banners = subDict1[@"banners"];
    for (NSDictionary *subDict in banners) {
        BannersModel *model = [[BannersModel alloc] init];
        [model setValuesForKeysWithDictionary:subDict];
        [bannerArra addObject:model];
    }
    
    return bannerArra;
}


+(NSArray *)arrayWithGoodsSextionModel:(NSData *)data
{
    NSMutableArray *goodsArr = [NSMutableArray array];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray  *itemsArray  = dict[@"items"];

    for (int i = 2; i<itemsArray.count; i++) {
        NSDictionary *subDict = itemsArray[i];
        GoodsSectionModel *goodsSecmodel = [[GoodsSectionModel alloc] init];
        [goodsSecmodel setValuesForKeysWithDictionary:subDict];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *courses in goodsSecmodel.courses) {
            GoodsModel *goodsModel = [[GoodsModel alloc] init];
            [goodsModel setValuesForKeysWithDictionary:courses];
            [arr addObject:goodsModel];
        }
        
        goodsSecmodel.courses = arr;
        
        [goodsArr addObject:goodsSecmodel];
    }
    
    return goodsArr;
}


@end






