//
//  MyAFNetWorkingRequest.h
//  01-爱限免-框架
//
//  Created by zhaokai on 15/6/23.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AFBlock)(NSData *requestData);

@interface MyAFNetWorkingRequest : NSObject
@property (nonatomic,copy) AFBlock tempBlock;

-(id)initWithRequest:(NSString *)urlString andBlock:(AFBlock)block;
@end
