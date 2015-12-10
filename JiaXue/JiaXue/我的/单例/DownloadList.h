//
//  DownloadList.h
//  JiaXue
//
//  Created by xiang_jj on 15/11/27.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DownloadList : NSObject

@property(nonatomic,strong)NSMutableArray *downloadArray;
@property(nonatomic,strong)NSMutableArray *downloadfileRequest;


+(DownloadList *)shareDownloadList;


@end
