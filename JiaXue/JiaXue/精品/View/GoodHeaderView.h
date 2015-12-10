//
//  GoodHeaderView.h
//  JiaXue
//
//  Created by xiang_jj on 15/11/30.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannersModel.h"

@protocol GoodHeaderViewDelegate  <NSObject>

-(void)didSelectedImageView:(BannersModel *)model;

@end


@interface GoodHeaderView : UIView

@property(nonatomic,assign)id<GoodHeaderViewDelegate> delegate;
@property(nonatomic,strong)NSArray  *bannerArray;;

@end
