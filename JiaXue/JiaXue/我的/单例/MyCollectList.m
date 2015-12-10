//
//  MyCollectList.m
//  JiaXue
//
//  Created by xiang_jj on 15/12/1.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "MyCollectList.h"

@implementation MyCollectList

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.collecList = [NSMutableArray array];
        
        NSUserDefaults *de = [NSUserDefaults standardUserDefaults];
        NSArray *arr =  [de objectForKey:@"收藏列表"];
        
        for (NSDictionary *dict in arr) {
            CategoryDetailModel *model = [[CategoryDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.collecList addObject:model];
        }
        
        
    }
    return self;
}

+(id)shareMyCollecList{
    
    static MyCollectList *collect = nil;
    
    if (collect==nil) {
        collect = [[MyCollectList alloc] init];
    }

    return collect;
}
@end
