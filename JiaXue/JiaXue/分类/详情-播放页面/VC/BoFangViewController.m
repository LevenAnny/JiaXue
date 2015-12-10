//
//  MyDownloadTableViewController.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/26.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.


#import <MediaPlayer/MediaPlayer.h>
#import "BoFangViewController.h"
#import "MyAFNetWorkingRequest.h"
//#import "B1TableViewCell.h"
#import "BoFangTableViewCell.h"
#import "BoFang1TableViewCell.h"
#import "BoFang2TableViewCell.h"
#import "UIButton+WebCache.h"
#import "BoFangModel.h"
#import "WaiBoModel.h"
#import "DownloadList.h"
#import "MyCollectList.h"
#import "MySessionDownloadStopAndResume.h"
#import "XJFMDBManager.h"


@interface BoFangViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *_playButton;
    
    NSMutableArray *_dataArray;
    
    UITableView *_indexTableView;
    
    NSMutableArray *_midArray;
    
    NSMutableArray *_moDataArray;
    //播放视频
    MPMoviePlayerController *_moviePlayer;
    
    //视频地址的模型
    BoFangModel *_mModel;
}

@property(nonatomic, strong)MyAFNetWorkingRequest *request;

@property(nonatomic, strong) WaiBoModel *waiBoModel;
@property(nonatomic, strong) BoFangModel *boFangModel;

@property(nonatomic, strong)UILabel *playLabel;//显示是否有视频资源

@end

@implementation BoFangViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //    [[NSNotificationCenter defaultCenter]postNotificationName:@"hiddenTabBar" object:nil];
}

#pragma mark -通知取消nva_bar

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil];
    
    if (_moviePlayer) {
        [_moviePlayer stop];
        _moviePlayer = nil;
    }
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self createPlayMovieButton];
    
    [self creatHeadTitleView];
    
    [self createTableView];
    
    [self creatPropmtTitleLabel];//添加提示label
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -loadData

- (void)loadData{
    
    __weak  BoFangViewController *mySelf = self;
    self.request = [[MyAFNetWorkingRequest  alloc] initWithRequest:[NSString stringWithFormat:URL_CATEGORY_DETAIL_BOFANG,self.detailModel.myID] andBlock:^(NSData *requestData) {
        
        mySelf.waiBoModel =  [WaiBoModel  waiboModelWithRequestData:requestData];
        
        [_indexTableView  reloadData];
        
        [mySelf loadDataMovieURL];
        
    }];
    
}


#pragma mark  - 请求视频的播放地址
- (void)loadDataMovieURL{
    
    NSString *urlStr = nil;
    if (self.waiBoModel.videoId) {
        urlStr = [NSString stringWithFormat:URL_BOFANG,self.waiBoModel.videoId];
    }else if (self.waiBoModel.singleVideoId){
        urlStr = [NSString stringWithFormat:URL_BOFANG,self.waiBoModel.singleVideoId];
        
    }else{
        urlStr = [NSString stringWithFormat:URL_BOFANG,self.waiBoModel.videoId];
    }
    
    self.request = [[MyAFNetWorkingRequest alloc] initWithRequest:urlStr andBlock:^(NSData *requestData) {
        
        self.boFangModel = [BoFangModel  boFangModelWithRequestData:requestData];
        
    }];
}


#pragma mark - 创建播放按钮

- (void)createPlayMovieButton{
    
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _playButton.frame = CGRectMake(0, 0, screen_Width, (screen_Height-64)*0.4);
    [_playButton sd_setBackgroundImageWithURL:[NSURL URLWithString:self.detailModel.iconUrl] forState:UIControlStateNormal];
    _playButton.highlighted = NO;
    [_playButton setImage:[UIImage imageNamed:@"video_play"] forState:UIControlStateNormal];
    [_playButton addTarget:self action:@selector(playBttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playButton];
    
}


#pragma mark -创建hv

- (void)creatHeadTitleView{
    
    UIView *headView =[[UIView alloc]init];
    headView.frame =CGRectMake(0, (screen_Height-64)*0.4, screen_Width, 30);
    headView.backgroundColor =[UIColor yellowColor];
    
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
    label.text =@"详情简介";
    label.textColor =[UIColor redColor];
    label.font =[UIFont systemFontOfSize:16.0f];
    [headView addSubview:label];
    [self.view addSubview:headView];
    
    NSArray *array = @[@"分享",@"收藏",@"下载"];
    for (int i = 0; i<array.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((120+i*60), 5, 60, 20);
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        if (i == 2) {
            if([self isDownloadMovie]){
                [btn setTitle:@"已下载" forState:UIControlStateNormal];
            }
        }
        [headView addSubview:btn];
    }
    
}
//判断是否下载了该视频
-(BOOL)isDownloadMovie{
    //如果有下载资源
    //先去沙盒查看是否已经下载过
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *array = [fm contentsOfDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie"] error:nil];
    for (NSString *fileName in array) {
        if ([fileName isEqualToString:[NSString stringWithFormat:@"%@.mp4",self.detailModel.title]]) {
            return YES;
        }
    }
    return NO;
}


//动画效果提示
-(void)playLabelAnimation:(NSString *)text{
    
    [UIView animateWithDuration:1 animations:^{
        self.playLabel.text = text;
        self.playLabel.alpha =1;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            self.playLabel.alpha =0;
        }];
    }];
    
}

-(void)downloadMovie{
    
    
    
    //先判断是否有下载资源，如果没有下载资源
    if (self.waiBoModel.singleVideoId==nil&&self.waiBoModel.videoId == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"暂无视频资源" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        return;
        
    }else{
        //如果有下载资源
        //先去沙盒查看是否已经下载过
        if ([self isDownloadMovie]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"您已经下载了该视频" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            return;
        }
        
        DownloadList *downloadList = [DownloadList shareDownloadList];
        
        for (CategoryDetailModel *model in downloadList.downloadArray) {
            if (model == self.detailModel) {
                [self playLabelAnimation:@"请不要重复下载"];
                return ;
            }
        }
        
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *sureAction  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            [self playLabelAnimation:@"已添加至离线缓存表"];
            
            DownloadList *downloadList = [DownloadList shareDownloadList];
            
            //把当前视频加入到下载列表
            [downloadList.downloadArray addObject:self.detailModel];
            
            //通知下载类开始下载
            MySessionDownloadStopAndResume *downLoadFile = [[MySessionDownloadStopAndResume alloc] initWithMySessionDownloadFile:self.boFangModel.quality_10];
            
            downLoadFile.detailModel = self.detailModel;
            [downloadList.downloadfileRequest addObject:downLoadFile];
            
        }];
        
        UIAlertController *alertVC = [UIAlertController  alertControllerWithTitle:@"下载" message:@"您确定要下载该视频吗" preferredStyle:UIAlertControllerStyleAlert] ;
        [alertVC addAction:cancelAction];
        [alertVC addAction:sureAction];
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }
    
    
}

-(void)collectMovie{
    
    
    MyCollectList *list = [MyCollectList shareMyCollecList];
    for (CategoryDetailModel *deModel in list.collecList) {
        if (deModel == self.detailModel) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"已经被收藏" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
    [list.collecList  addObject:self.detailModel];
    [self playLabelAnimation:@"已添加到缓存列表"];
    
}

#pragma mark --分享，收藏，下载
-(void)btnClick:(UIButton *)btn{
    //分享按钮被点击
    if (btn.tag == 100) {
        
        
        
    }else if(btn.tag == 101){//收藏按钮被点击
        
      
        [self collectMovie];
    }
    else{//下载按钮被点击
      
        
        [self downloadMovie];
    }
}

#pragma mark -创建tv

- (void)createTableView{
    
    _indexTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, (screen_Height-64)*0.4+30, screen_Width, (screen_Height-64)*0.6-30) style:UITableViewStylePlain];
    _indexTableView.dataSource =self;
    _indexTableView.delegate =self;
    [self.view addSubview:_indexTableView];
}

#pragma mark -创建提示标签

-(void)creatPropmtTitleLabel{
    self.playLabel =[[UILabel alloc]initWithFrame:CGRectMake(20,screen_Height*0.4, screen_Width-40, 30)];
    self.playLabel.backgroundColor =[UIColor grayColor];
    self.playLabel.textAlignment =NSTextAlignmentCenter;
    self.playLabel.textColor =[UIColor whiteColor];
    self.playLabel.font =[UIFont systemFontOfSize:18.0f];
    self.playLabel.alpha = 0;
    [self.view addSubview:self.playLabel];
}


#pragma mark - 播放按钮点击事件

- (void)playBttonClick:(UIButton *)b{
    
    
    if (self.waiBoModel.singleVideoId==nil&&self.waiBoModel.videoId == nil) {
        
        [self playLabelAnimation:@"暂无视频数据"];
    }
    
    else{
        
        if ([self isDownloadMovie]) {
            //播放本地
            _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/Movie/%@.mp4",self.waiBoModel.title]]];
        }
        else{
            _moviePlayer = [[MPMoviePlayerController alloc]init];
            [_moviePlayer setContentURL:[NSURL URLWithString:self.boFangModel.quality_10]];
        }
        _moviePlayer.view.frame = CGRectMake(0, 0, screen_Width, (screen_Height-64)*0.4);
        _moviePlayer.repeatMode = MPMovieRepeatModeNone;
        _moviePlayer.shouldAutoplay = NO;
        [_moviePlayer play];
        [self.view addSubview:_moviePlayer.view];
    }
}


#pragma mark - 全屏转换
- (void)movieWillFull{
    
    //    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    
}

- (void)movieWillExitFull{
    
    //    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
}


#pragma mark UITableView 的代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 67.0f;
    }
    if (indexPath.section ==1) {
        return 150.0f;
    }
    if (indexPath.section ==2) {
        return 80.0f;
    }
    return 200.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        NSString *cell1 =@"cell1";
        BoFangTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cell1];
        if (!cell) {
            cell =[[[NSBundle mainBundle]loadNibNamed:@"BoFangTableViewCell" owner:self options:nil]lastObject];
        }
        cell.label1.text =self.detailModel.title;
        cell.label2.text =[NSString stringWithFormat:@"%@次播放",self.waiBoModel.videoView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section ==1) {
        NSString *cell2 =@"cell2";
        BoFang1TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cell2];
        if (!cell) {
            cell =[[[NSBundle mainBundle]loadNibNamed:@"BoFang1TableViewCell" owner:self options:nil]lastObject];
        }
        cell.label.text =self.waiBoModel.overview;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        NSString *cell3 =@"cell3";
        BoFang2TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cell3];
        if (!cell) {
            cell =[[[NSBundle mainBundle]loadNibNamed:@"BoFang2TableViewCell" owner:self options:nil]lastObject];
        }
        cell.label2.text =self.waiBoModel.goal;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
}



- (void)dealloc{
    
    if (_moviePlayer) {
        [_moviePlayer stop];
        _moviePlayer = nil;
    }
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
