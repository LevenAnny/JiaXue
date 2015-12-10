//
//  ListTableViewController.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/24.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "ListTableViewController.h"
#import "BoFangViewController.h"
#import "MyAFNetWorkingRequest.h"
#import "ListModel.h"
#import "GoodsModel.h"
#import "CategoryDetailModel.h"

@interface ListTableViewController ()

@property(nonatomic,strong)MyAFNetWorkingRequest *request;


@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.coureseStr = @"courses";
    self.titleStr = @"title";
    self.idStr = @"_id";
    
    
    [self loadRequestData];
    
}

-(void)loadRequestData{
    
    self.request = [[MyAFNetWorkingRequest alloc] initWithRequest:URL_LIST andBlock:^(NSData *requestData) {
        self.dataArray = [ListModel arrayWithListModel:requestData];
        [self.tableView reloadData];
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BoFangViewController *bf  = [[BoFangViewController alloc] init];
    
    ListModel *listModel = self.dataArray[indexPath.section];
    GoodsModel *goodsModel  = listModel.courses[indexPath.row];
    
    CategoryDetailModel *detailModel = [[CategoryDetailModel alloc] init];
    detailModel.myID = goodsModel._id;
    detailModel.iconUrl = goodsModel.iconUrl;
    detailModel.title = goodsModel.title;
    bf.detailModel = detailModel;
    
    [self.navigationController pushViewController:bf animated:YES];
    
    
}


@end


