//
//  BoFangModel.m
//  J_APP
//
//  Created by 孙密 on 15/11/5.
//  Copyright (c) 2015年 孙密. All rights reserved.
//

#import "BoFangModel.h"

@implementation BoFangModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(BoFangModel *)boFangModelWithRequestData:(NSData *)data{


    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSDictionary *subDict = dict[@"url"];
    BoFangModel *model = [[BoFangModel alloc] init];
    [model setValuesForKeysWithDictionary:subDict];
    return model;

}
@end
