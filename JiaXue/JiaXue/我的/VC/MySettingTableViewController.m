//
//  MySettingTableViewController.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/26.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "MySettingTableViewController.h"
#import "LoginViewController.h"
#import "MyDownloadTableViewController.h"
#import "MyCollectViewController.h"
@interface MySettingTableViewController ()

@end

@implementation MySettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    switch (indexPath.section) {
        case 0:{
            LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            [self.navigationController pushViewController:loginVC animated:YES];
            break;
            }
        case 1:{
            MyDownloadTableViewController *downloadVC = [[MyDownloadTableViewController alloc] initWithStyle:UITableViewStylePlain];
            [self.navigationController pushViewController:downloadVC animated:YES];
            
            break;
            }
        case 2:{
            MyCollectViewController *collectVC = [[MyCollectViewController alloc] init];
            [self.navigationController pushViewController:collectVC animated:YES];
            
            break;
            }
        case 3:
            
            break;
        case 4:
            
            break;
        default:
            break;
    }
    
}

@end







