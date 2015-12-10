//
//  GoodModelManager.h
//  JiaXue
//
//  Created by xiang_jj on 15/11/30.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BannersModel.h"
#import "GoodsModel.h"
#import "GoodsSectionModel.h"

@interface GoodModelManager : NSObject

+(NSArray *)arrayWithBannerModel:(NSData *)data;

+(NSArray *)arrayWithGoodsSextionModel:(NSData *)data;
@end
