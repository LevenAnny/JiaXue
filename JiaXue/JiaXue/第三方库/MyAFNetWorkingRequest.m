//
//  MyAFNetWorkingRequest.m
//  01-爱限免-框架
//
//  Created by zhaokai on 15/6/23.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import "MyAFNetWorkingRequest.h"
#import "AFNetworking.h"

@implementation MyAFNetWorkingRequest
-(id)initWithRequest:(NSString *)urlString andBlock:(AFBlock)block{
    if (self = [super init]) {
        if (_tempBlock != nil) {
            _tempBlock = nil;
        }
        _tempBlock = block;
        
        [self httpRequestWith:urlString];
    }
    
    return self;
}

-(void)httpRequestWith:(NSString *)urlString{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        _tempBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];

}
@end
