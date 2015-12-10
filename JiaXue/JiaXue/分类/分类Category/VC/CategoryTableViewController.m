//
//  CategoryTableViewController.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/24.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "SectionHeaderView.h"
#import "CategoryDetailViewController.h"
#import "CategoryTableViewCell.h"
#import "MyAFNetWorkingRequest.h"
#import "CategoryModelManager.h"
#import "Header.h"


@interface CategoryTableViewController ()<CategoryTableViewCellDelegate>

@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)MyAFNetWorkingRequest *request;

@end

@implementation CategoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[CategoryTableViewCell class] forCellReuseIdentifier:@"CellID"];
    
    [self loadRequestData:1];
    
    

}

-(void)loadRequestData:(NSInteger)page{
    
    
   self.request = [[MyAFNetWorkingRequest alloc] initWithRequest:[NSString stringWithFormat:URL_CATEGORY,page] andBlock:^(NSData *requestData) {
       
       self.dataArray = [CategoryModelManager arrayWithRequestData:requestData];
    
       [self.tableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

        return  1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CategoryModel *model = self.dataArray[indexPath.section];
    cell.model = model;
    
    return cell;
}

//section的头部视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CategoryModel *model = _dataArray[section];
    
    SectionHeaderView *headView = [[SectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 30.0f)  andName:model.name];
    
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
}


#pragma mark --CategoryTableViewCellDelegate
-(void)didSelectorItem:(CategoryModel *)model andIndexPath:(NSInteger)index
{
    CategoryDetailViewController *dvc = [[CategoryDetailViewController alloc] init];
    dvc.model = model;
    dvc.index = index;//label下划线希望显示在哪个btn下
    [self.navigationController pushViewController:dvc animated:YES];

}

@end



