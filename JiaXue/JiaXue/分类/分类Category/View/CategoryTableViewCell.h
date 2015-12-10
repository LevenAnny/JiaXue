//
//  CategoryTableViewCell.h
//  JiaXue
//
//  Created by xiang_jj on 15/11/24.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"

//代理传值
@protocol CategoryTableViewCellDelegate <NSObject>

-(void)didSelectorItem:(CategoryModel *)model andIndexPath:(NSInteger)index;

@end

@interface CategoryTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,assign)id<CategoryTableViewCellDelegate> delegate;
@property(nonatomic,strong)CategoryModel *model;

@end
