//
//  GoodsTableViewController.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/24.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "GoodsTableViewController.h"
#import "MyAFNetWorkingRequest.h"
#import "BoFangViewController.h"
#import "GoodHeaderView.h"
#import "CategoryDetailModel.h"
#import "GoodModelManager.h"

@interface GoodsTableViewController ()<GoodHeaderViewDelegate>

@property(nonatomic, strong)MyAFNetWorkingRequest *request;

@property(nonatomic,strong)GoodHeaderView *headView;

@end

@implementation GoodsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //modele的courses属性
    self.coureseStr = @"courses";
    //modele的title属性
    self.titleStr = @"title";
    //modele的columnId属性
    self.idStr = @"columnId";
    
    //头部视图
    self.headView = [[GoodHeaderView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 120)];
    self.headView.delegate = self;
    self.tableView.tableHeaderView = self.headView;
    
    //请求数据
    [self requestData];
    
}

-(void)requestData{

    self.request = [[MyAFNetWorkingRequest alloc] initWithRequest:@"http://course.jaxus.cn/api/boutique?channel=appstore&platform=2&version=2" andBlock:^(NSData *requestData) {
        //头部视图展示的数据源
        self.headView.bannerArray =  [GoodModelManager  arrayWithBannerModel:requestData];
        //数据源
        self.dataArray  =  [GoodModelManager arrayWithGoodsSextionModel:requestData];
        
        [self.tableView reloadData];
        

    }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushBoFangViewController:(id)model{


    //播放页面
    BoFangViewController *bf = [[BoFangViewController alloc] init];
    
    CategoryDetailModel *detailModel = [[CategoryDetailModel alloc] init];

    
    if ([model isKindOfClass:[GoodsModel class]]) {
        GoodsModel *goodsModel = (GoodsModel *)model;
        
        detailModel.myID = goodsModel._id;
        detailModel.iconUrl = goodsModel.iconUrl;
    }
    
    if ([model isKindOfClass:[BannersModel class]]) {
        BannersModel *banaModel = (BannersModel *)model;
     
        detailModel.myID = banaModel.courseId;
        detailModel.iconUrl = banaModel.imageUrl;
    }
    

    bf.detailModel = detailModel;
    [self.navigationController pushViewController:bf animated:YES];

}


//每一行被点击 进入播放页面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsSectionModel *secModel = self.dataArray[indexPath.section];
    GoodsModel *goodsModel  = secModel.courses[indexPath.row];
    
    [self pushBoFangViewController:goodsModel];

}


#pragma mark ---GoodHeaderViewDelegate
//点击广告栏上的图片跳转到对应的播放页面
-(void)didSelectedImageView:(BannersModel *)model
{

    [self pushBoFangViewController:model];

}

@end


















