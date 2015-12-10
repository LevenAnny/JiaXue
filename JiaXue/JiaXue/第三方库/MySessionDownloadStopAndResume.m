//
//  MySessionDownloadStopAndResume.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/27.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "MySessionDownloadStopAndResume.h"
#import "XJFMDBManager.h"
#import "DownloadList.h"

@interface MySessionDownloadStopAndResume()<NSURLSessionDataDelegate>

@property (strong, nonatomic)NSURLSession *session;
@property (strong, nonatomic)NSURLSessionDownloadTask *downLoadTask;
//保存暂停时已经下载的部分数据
@property (strong, nonatomic)NSData *resumeData;

@end

@implementation MySessionDownloadStopAndResume

//重写getter方法
-(NSURLSession *)session
{
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    }
    return _session;
}

-(id)initWithMySessionDownloadFile:(NSString *)urlStr{
    if ([super init]) {
        
        //1.构造NSURL
        urlStr  = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlStr];
        //2 创建请求对象
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        //3.创建NSURLSession对象
        //懒加载..
        //4.创建下载文件的任务
        self.downLoadTask = [self.session  downloadTaskWithRequest:request];
        //5 启动任务
        [self.downLoadTask resume];
    }
    return self;
}

-(void)continueDownLoad{

    //接着上次的开始下载
    self.downLoadTask = [self.session downloadTaskWithResumeData:self.resumeData];
    [self.downLoadTask resume];
    self.resumeData = nil;
    
    self.isStop = NO;

}

-(void)pauseDownload{
    
    [self.downLoadTask  cancelByProducingResumeData:^(NSData *resumeData) {
        self.resumeData = resumeData;
    }];

    self.isStop = YES;
}

#pragma  mark - NSURLSessionDownloadDelegate
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    //将临时文件保存到指定的目录中
    NSString *descParth = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/Movie/%@.mp4",self.detailModel.title];
    NSLog(@"%@",descParth);
    [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:descParth error:nil];
    
    //当下载成功后
    //创建数据库 把该视频所对应的相关信息存储起来
    XJFMDBManager *manager = [XJFMDBManager shareXJFMDBManager];
    manager.model = self.detailModel;
    [manager createTable];
    [manager insertData];
    
    //每次下载成功以后，就把当前请求对象从单例的数组中移除
    DownloadList *list = [DownloadList shareDownloadList];
    [list.downloadfileRequest  removeObject:self];
    [list.downloadArray  removeObject:self.detailModel];
    
}
//下载过程中不断回调该方法
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    //1.计算当前的下载进度
    double progress = totalBytesWritten*1.0/totalBytesExpectedToWrite;
    //2.回到主线程，更新进度条的显示
    dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(currentDownloadProgress:andDownload:)]||self.delegate) {
            [self.delegate currentDownloadProgress:progress andDownload:self];
        }
    });
    
}


@end
