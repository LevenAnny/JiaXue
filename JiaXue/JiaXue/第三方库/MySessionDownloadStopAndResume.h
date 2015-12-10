//
//  MySessionDownloadStopAndResume.h
//  JiaXue
//
//  Created by xiang_jj on 15/11/27.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryDetailModel.h"

@class MySessionDownloadStopAndResume;

@protocol MySessionDownloadStopAndResumeDelegate <NSObject>
//当下载进度发送变化的时候 告诉代理对象
-(void)currentDownloadProgress:(double)progress andDownload:(MySessionDownloadStopAndResume *)sessinDownload;
@end

@interface MySessionDownloadStopAndResume : NSObject

@property(nonatomic,assign)id<MySessionDownloadStopAndResumeDelegate> delegate;
@property(nonatomic,strong)CategoryDetailModel *detailModel;
@property(nonatomic,assign)double  progress;//当前进度
@property(nonatomic,assign)BOOL    isStop;//为了判断btn是都该显示“暂停”还是“继续”
-(id)initWithMySessionDownloadFile:(NSString *)urlStr;//开始下载

-(void)continueDownLoad;//接着下载

-(void)pauseDownload;//暂停下载


@end
