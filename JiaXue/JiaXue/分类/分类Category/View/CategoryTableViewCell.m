//
//  CategoryTableViewCell.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/24.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "CategoryTableViewCell.h"
#import "CategoryCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "Header.h"
@implementation CategoryTableViewCell
{
    UICollectionView *myCollectionView ;
}
-(void)setModel:(CategoryModel *)model
{
    _model = model;
    [myCollectionView reloadData];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifie];
    if (self) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //单元格（每一项）的大小（宽高）
        layout.itemSize = CGSizeMake((screen_Width-(screen_Width*0.05*4))/4, 80);
        //最小格间距（每个单元格之间的最小间距）
        layout.minimumInteritemSpacing = screen_Width*0.05;
        //最小行间距
        layout.minimumLineSpacing = screen_Width*0.05;
        //分区之间的边距
        layout.sectionInset = UIEdgeInsetsMake(15, screen_Width*0.05, 0, 0);
        //设置滚动的方法(Vertical竖向)
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 100) collectionViewLayout:layout];
        myCollectionView.delegate = self;
        myCollectionView.dataSource = self;
        myCollectionView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:myCollectionView];
        
        //注册Cell
        [myCollectionView registerNib:[UINib nibWithNibName:@"CategoryCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cellName"];

    }
    return self;
}

- (void)awakeFromNib {



}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

#pragma mark - UICollectionViewDataSource

//1问 有几个分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
//2问 每个分区有多少项
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}
//3问 每一项长什么样子
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //从复用池里去取有没有符合要求的单元格，如果没有，自己创建一个cell返回
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellName" forIndexPath:indexPath];
    CategoryListModel *listModel = self.model.subcategories[indexPath.row];
    
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:listModel.iconUrl]];

    cell.myLabel.text = listModel.name;
        
    
    return cell;
}

//点击每一项 响应的事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if ([self.delegate respondsToSelector:@selector(didSelectorItem:andIndexPath:)]) {
        [self.delegate didSelectorItem:self.model  andIndexPath:indexPath.row];
    }
    
}

@end











