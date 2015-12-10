//
//  CategoryDetailTableViewCell.h
//  JiaXue
//
//  Created by xiang_jj on 15/11/25.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryDetailModel.h"


@interface CategoryDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *myTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (strong, nonatomic) CategoryDetailModel *detailModel;

@end
