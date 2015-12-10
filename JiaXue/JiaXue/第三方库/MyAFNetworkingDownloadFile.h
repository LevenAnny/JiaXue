//
//  MyAFNetworkingDownloadFile.h
//  JiaXue
//
//  Created by xiang_jj on 15/11/27.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAFNetworkingDownloadFile : NSObject


@property(nonatomic,copy)NSString *fileName;
-(id)initWithDownloadFileURL:(NSString *)urlStr ;


@end
