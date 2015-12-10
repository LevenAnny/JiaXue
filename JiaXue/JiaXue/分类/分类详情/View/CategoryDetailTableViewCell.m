//
//  CategoryDetailTableViewCell.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/25.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "CategoryDetailTableViewCell.h"
#import "UIImageView+WebCache.h"


@implementation CategoryDetailTableViewCell

-(void)setDetailModel:(CategoryDetailModel *)detailModel{

    _detailModel = detailModel;

    [self.iconImageView  sd_setImageWithURL:[NSURL URLWithString:_detailModel.iconUrl]];
    
    self.myTitleLabel.text = _detailModel.title;
    
    self.descLabel.text = _detailModel.providerName;
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
