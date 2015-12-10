//
//  BaseTableViewController.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/30.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "BaseTableViewController.h"
#import "CategoryDetailTableViewController.h"
#import "CategoryDetailTableViewCell.h"
#import "SectionHeaderView.h"
#import "GoodsSectionModel.h"
#import "GoodsModel.h"
#import "ListModel.h"
#import "UIImageView+WebCache.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CategoryDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"CellID"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    SEL sel   = NSSelectorFromString(self.coureseStr);
    id  model = self.dataArray[section];
    NSArray *arr =  [model performSelector:sel];
    return [arr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
    
    SEL sel   = NSSelectorFromString(self.coureseStr);
    id  model = self.dataArray[indexPath.section];
    NSArray *arr =  [model performSelector:sel];
    
    GoodsModel *goodsModel = arr[indexPath.row];

    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:goodsModel.iconUrl]];
    cell.myTitleLabel.text = goodsModel.title;
    cell.descLabel.text = goodsModel.providerName;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    id secModel = self.dataArray[section];
    
    SectionHeaderView *headView = [[SectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 30.0f)  andName:[secModel performSelector:NSSelectorFromString(self.titleStr)]];
    headView.tag = 100+section;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [headView addGestureRecognizer:tap];
    
    return headView;
}

//点击sectionView响应事件
-(void)tapClick:(UITapGestureRecognizer *)tap{
    
    id secModel = self.dataArray[tap.view.tag-100];
    
    //这里跟分类详情也类似，所以直接拿来使用
    CategoryDetailTableViewController *cvc = [[CategoryDetailTableViewController alloc] init];

    [cvc loadRequestDataWithUrlStr:[NSString stringWithFormat:URL_GOODS_RECOMMEND,@"rank",[secModel performSelector:NSSelectorFromString(self.idStr)]]];
    
    [self.navigationController pushViewController:cvc animated:YES];
    
}





@end
