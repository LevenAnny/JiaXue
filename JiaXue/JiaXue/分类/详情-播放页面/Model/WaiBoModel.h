//
//  WaiBoModel.h
//  J_APP
//
//  Created by 孙密 on 15/11/4.
//  Copyright (c) 2015年 孙密. All rights reserved.
//

#import "BaseModel.h"

@interface WaiBoModel : BaseModel
proStr(_id);
proStr(bgUrl);
proStr(goal);
proStr(overview);
proStr(title);
proStr(videoView);
proStr(singleVideoId);
proStr(videoId);

+(WaiBoModel *)waiboModelWithRequestData:(NSData *)data;

@end
