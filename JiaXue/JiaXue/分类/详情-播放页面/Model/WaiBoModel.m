//
//  WaiBoModel.m
//  J_APP
//
//  Created by 孙密 on 15/11/4.
//  Copyright (c) 2015年 孙密. All rights reserved.
//

#import "WaiBoModel.h"

@implementation WaiBoModel
+(WaiBoModel *)waiboModelWithRequestData:(NSData *)data{

    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    WaiBoModel *model =[[WaiBoModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    
    return model;

}
@end
