//
//  MyAFNetworkingDownloadFile.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/27.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "MyAFNetworkingDownloadFile.h"
#import "AFNetworking.h"

@implementation MyAFNetworkingDownloadFile
{
    NSProgress *_progress;

}

-(id)initWithDownloadFileURL:(NSString *)urlStr{
    if (self = [super init]) {
        
    //1 准备NSURL对象
    //    NSString *urlStr = @"http://10.6.157.153/share/01.zip";
        NSURL *url = [NSURL URLWithString:urlStr];

    //2 创建请求对象
        NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //3 创建AFURLSessionManager对象
        AFURLSessionManager *manger = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration  defaultSessionConfiguration]];

    //第二个参数是进度对象指针的地址，为了返回进度
    NSProgress *progress = nil;

    //4.创建下载任务
    NSURLSessionDownloadTask *task = [manger  downloadTaskWithRequest:request progress:&progress destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        //返回的是最终将文件保存的路径
        NSString *desPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.mp4",self.fileName];
        NSURL *url = [NSURL fileURLWithPath:desPath];
        return  url;
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"%@ %@",filePath.path,error.localizedDescription);
    }];
    //5 启动任务
    [task resume];

    //得到progress对象，需要用成员变量保存起来
    //用成员变量指向，如何做了一个强引用，保证刚刚创建的progress对象不会在当前函数结束时消失
    _progress = progress;

    //设置观察者，观察进度，
    //让self作为观察者来观察_progress的属性@“fractionCompleted”(表示完成的进度)
    [_progress  addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object==_progress&&[keyPath isEqualToString:@"fractionCompleted"]) {
        //回到主线程，更新进度条的显示
        dispatch_async(dispatch_get_main_queue(), ^{
            
//            [self.myProgressView setProgress:_progress.fractionCompleted animated:YES];
        });
    }
}
@end
