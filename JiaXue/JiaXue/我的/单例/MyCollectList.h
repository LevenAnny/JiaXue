//
//  MyCollectList.h
//  JiaXue
//
//  Created by xiang_jj on 15/12/1.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryDetailModel.h"

@interface MyCollectList : NSObject

@property(nonatomic,strong)NSMutableArray *collecList;//收藏列表

+(id)shareMyCollecList;

@end
