//
//  DownloadList.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/27.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "DownloadList.h"

@implementation DownloadList

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.downloadArray = [[NSMutableArray alloc] init];
        self.downloadfileRequest = [[NSMutableArray alloc] init];
    }
    return self;
}

+(DownloadList *)shareDownloadList{

    static DownloadList *list = nil;
    if (list == nil) {
        list = [[DownloadList alloc] init];
    }
    return list;
}



@end




