//
//  BoFangModel.h
//  J_APP
//
//  Created by 孙密 on 15/11/5.
//  Copyright (c) 2015年 孙密. All rights reserved.
//

#import "BaseModel.h"



@interface BoFangModel : BaseModel

proStr(quality_10);
proStr(quality_20);
proStr(quality_30);

+(BoFangModel *)boFangModelWithRequestData:(NSData *)data;

@end
