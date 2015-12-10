//
//  MyCollectViewController.m
//  JiaXue
//
//  Created by xiang_jj on 15/12/1.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "MyCollectViewController.h"
#import "MyCollectList.h"

@interface MyCollectViewController ()

@end

@implementation MyCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataArray = [[[MyCollectList shareMyCollecList] collecList] mutableCopy];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

//当点击editButtonItem时候，默认调用该方法
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{

    self.tableView.editing = !self.tableView.editing;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryDetailModel *model = self.dataArray[indexPath.row];
    
    [self.dataArray removeObject:model];
    
   [[[MyCollectList shareMyCollecList] collecList] removeObject:model];

    [tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
