//
//  GoodsSectionModel.h
//  JiaXue
//
//  Created by xiang_jj on 15/11/30.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "BaseModel.h"

@interface GoodsSectionModel : NSObject

proStr(columnId);
proArr(courses);
proStr(title);
proStr(iType);


-(NSArray *)courses;
@end
