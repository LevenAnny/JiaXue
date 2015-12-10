//
//  CategoryDetailTableViewController.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/25.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "CategoryDetailTableViewController.h"
#import "CategoryDetailTableViewCell.h"
#import "BoFangViewController.h"
#import "Header.h"

@interface CategoryDetailTableViewController ()

@property(nonatomic,strong)MyAFNetWorkingRequest *request;


@end

@implementation CategoryDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView  registerNib:[UINib nibWithNibName:@"CategoryDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"CellID"];
    
}

-(void)loadRequestDataWithUrlStr:(NSString *)urlStr{
    
    self.request = [[MyAFNetWorkingRequest alloc] initWithRequest:urlStr andBlock:^(NSData *requestData) {
       
       self.dataArray = [[CategoryModelManager  arrayWithRequestDataForCategoryDetailModel:requestData] mutableCopy];
        
        [self.tableView reloadData];

    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
    
    CategoryDetailModel *detaiModel = self.dataArray[indexPath.row];
    cell.detailModel = detaiModel;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BoFangViewController *bfVC = [[BoFangViewController alloc] init];
    CategoryDetailModel *detaiModel = self.dataArray[indexPath.row];
    bfVC.detailModel = detaiModel;
    [self.navigationController pushViewController:bfVC animated:YES];

}

@end




