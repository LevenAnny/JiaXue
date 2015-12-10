//
//  XJFMDBManager.h
//  JiaXue
//
//  Created by xiang_jj on 15/11/27.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"



@interface XJFMDBManager : NSObject
@property (nonatomic,strong)FMDatabase *database;

@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)id model;

+(id)shareXJFMDBManager;

//创建表
-(void)createTable;
//插入
-(void)insertData;
//删除
-(void)deleteData:(NSString *)title;
//查找
-(NSArray *)selectData;


@end
