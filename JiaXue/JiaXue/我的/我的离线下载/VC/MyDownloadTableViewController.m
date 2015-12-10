//
//  MyDownloadTableViewController.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/26.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "MyDownloadTableViewController.h"
#import "MySessionDownloadStopAndResume.h"
#import "DownloadList.h"
#import "MyDownloadTableViewCell.h"
#import "XJFMDBManager.h"

@interface MyDownloadTableViewController ()<MySessionDownloadStopAndResumeDelegate>

@property(nonatomic,strong)NSMutableArray *downloadArray;//存储本地视频资源和正在请求的视频对象
@property(nonatomic,strong)NSMutableArray *dataArray;//存储显示的model

@end

@implementation MyDownloadTableViewController

-(NSMutableArray *)downloadArray
{
    if (!_downloadArray) {
        _downloadArray = [NSMutableArray array];
    }
    return _downloadArray;
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView  registerNib:[UINib nibWithNibName:@"MyDownloadTableViewCell" bundle:nil] forCellReuseIdentifier:@"CelID"];
    
    [self loadData];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

//当点击editButtonItem时候，默认调用该方法
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    
    self.tableView.editing = !self.tableView.editing;
}

-(void)loadData{

    DownloadList *list = [DownloadList shareDownloadList];
    
    //先查看数据可以是否有数据，如果有，表示已经下载了视频
    XJFMDBManager *fmdb = [XJFMDBManager shareXJFMDBManager];

    if (list.downloadArray.count>0){
        //先检查当前是否有正在下载的视频
        [self.dataArray addObjectsFromArray:list.downloadArray];
        [self.downloadArray addObjectsFromArray:list.downloadfileRequest];

        
    }
    if([[fmdb selectData] count]>0){
        //再查看数据库中是否存有数据，那么取出对应Model数据存入数组
        [self.dataArray addObjectsFromArray:[fmdb selectData]];
        [self.downloadArray addObjectsFromArray:[fmdb selectData]];
    }



    for (id obj in self.downloadArray) {
        if ([obj isKindOfClass:[MySessionDownloadStopAndResume  class]]) {
            MySessionDownloadStopAndResume *session = (MySessionDownloadStopAndResume *)obj;
            session.delegate = self;
        }
    }
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    for (id obj in self.downloadArray) {
        if ([obj isKindOfClass:[MySessionDownloadStopAndResume  class]]) {
            MySessionDownloadStopAndResume *session = (MySessionDownloadStopAndResume *)obj;
            session.delegate = nil;
        }
    }
}

#pragma mark - MySessionDownloadStopAndResumeDelegate
-(void)currentDownloadProgress:(double)progress andDownload:(MySessionDownloadStopAndResume *)sessinDownload
{
    //当下载进度发送变化时，对应的tableview的进度条也要更新
    sessinDownload.progress = progress;
    [self.tableView reloadData];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MyDownloadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CelID" forIndexPath:indexPath];
    
    if (self.dataArray.count>0) {
        cell.detailModel = self.dataArray[indexPath.row];
    }

    id obj = self.downloadArray[indexPath.row];
    if ([obj isKindOfClass:[MySessionDownloadStopAndResume class]]) {
        cell.session = obj ;
    }else{
        [cell updateUI];
    }
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryDetailModel *model = self.dataArray[indexPath.row];
 
    //只有下载了才能播放，不支持边下载边播放
    
    XJFMDBManager *fmdb = [XJFMDBManager shareXJFMDBManager];
    //从数据库中查找是否已经下载了该视频，如果下载了，拿到本地视频，开始播放，否则，什么都不干
    for (CategoryDetailModel *fmModel in [fmdb selectData]) {
        //这里通过视频的标题判断该视频是否已经下载到本地
        if ([fmModel.title isEqualToString:model.title]) {
            NSURL *url = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/Movie/%@.mp4",model.title]];
            //实现本地播放
            MPMoviePlayerViewController *mvc = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
            
            [self presentViewController:mvc animated:YES completion:nil];
            
        }
    }
    
}
//删除已经下载的视频/正在下载中的视频
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DownloadList *list = [DownloadList shareDownloadList];

    //取出当前需要删除的视频对应的model
    CategoryDetailModel  *model = self.dataArray[indexPath.row];
    //从当前数据源中移除
    [self.dataArray removeObject:model];
    //如果存在当前下载列表
    if (list.downloadArray.count>0) {
        [list.downloadArray removeObject:model];
    }
    
    //取出当前正在下载的视频对象或者已经下载过的视频信息
    id obj2 = self.downloadArray[indexPath.row];
    
    //判断当前对象是正在下载的请求对象还是已经下载的视频
    if ([obj2 isKindOfClass:[MySessionDownloadStopAndResume class]]) {
        //从当前数据源中移除
        [self.downloadArray removeObject:obj2];
        //并从单例对象的下载列表中移除
        [list.downloadfileRequest removeObject:obj2];
    }else{
        //如果删除的是已经下载的对象
        [self.downloadArray removeObject:obj2];
        //并从数据库移除对应的数据
        [[XJFMDBManager shareXJFMDBManager] deleteData:model.title];
        //从沙盒目录移除对应的视频资源
        [[NSFileManager defaultManager] removeItemAtPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/Movie/%@.mp4",model.title] error:nil];
    }
    

    [self.tableView reloadData];

    
}


@end








