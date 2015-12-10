//
//  CategoryDetainModel.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/25.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "CategoryDetailModel.h"

@implementation CategoryDetailModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"_id"]) {
        self.myID = value;
    }

}

@end
