//
//  XJFMDBManager.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/27.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "XJFMDBManager.h"
#import "CategoryDetailModel.h"


@implementation XJFMDBManager

+(id)shareXJFMDBManager{

    static XJFMDBManager *manager = nil;
    if (manager == nil) {
        manager = [[XJFMDBManager alloc] init];
    }

    return manager;
}

-(id)init{
    if (self = [super init]) {
        /**
         数据库操作:
         1.创建数据库并打开
         
         2.创建表
         3.增
         4.删
         5.改
         6.查
         7.关闭数据库
         */
        
        NSString *path1 = [NSString stringWithFormat:@"%@/Documents/MovieInfo.rdb",NSHomeDirectory()];
        
        NSLog(@"%@",NSHomeDirectory());
        
        //创建数据库
        self.database = [[FMDatabase alloc]initWithPath:path1];
        
        if (self.database.open == NO) {
            NSLog(@"打开失败");
            return nil;
        }
    }
    
    return self;
}
//创建表格
-(void)createTable{

    NSString *createTab = @"CREATE TABLE IF NOT EXISTS MovieInfo(title varchar(32),iconUrl varchar(32))";
    
    //注意:增,删,创,改 都是通过executeUpdate:这个方法实现
    //查是通过executeQuery:方法实现
    BOOL isSuc = [_database executeUpdate:createTab];
    
    if (isSuc) {
        NSLog(@"创建成功");
    }else{
        NSLog(@"创建失败");
    }
}

//增加数据
-(void)insertData{
    
    CategoryDetailModel *detailModel = (CategoryDetailModel *)self.model;
    
    
    //?代表要插入的字段的值
    //注意:在结构化查询语句中不能出现中文
    //?之间不能有空格等符号
    NSString *insertSql = @"INSERT INTO MovieInfo(title,iconUrl) values(?,?)";
    
    //注意:在插入数据时,参数都要先暂时转化成字符串
    BOOL isSuc = [_database executeUpdate:insertSql,detailModel.title,detailModel.iconUrl];
    
    
    if (isSuc) {
        NSLog(@"插入成功");
    }else{
        NSLog(@"插入失败");
    }
    
}

//删除数据
-(void)deleteData:(NSString *)title
{
    NSString *deleteSql = @"DELETE FROM MovieInfo WHERE title = ?";
    
    BOOL isSuc = [_database executeUpdate:deleteSql,title];
    
    if (isSuc) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }

}

//查
-(NSArray *)selectData{
    _datas = [NSMutableArray array];
    
    NSString *selectSql = @"SELECT * FROM MovieInfo";
    
    //FMResultSet是一个集合类  ,结果集
    FMResultSet *set = [self.database executeQuery:selectSql];
    //next取当前行数据,取到执行,取不到结束循环
    while ([set next]) {
        
        CategoryDetailModel *detailModel = [[CategoryDetailModel alloc] init];
        detailModel.title = [set stringForColumnIndex:0];
        detailModel.iconUrl  = [set stringForColumnIndex:1];

        [_datas addObject:detailModel];
    }
    
    return _datas;
}







@end
