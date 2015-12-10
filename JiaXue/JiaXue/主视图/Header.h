//
//  ViewController.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/24.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#ifndef J_APP_PrefixHeader_pch
#define J_APP_PrefixHeader_pch
//#import "UIImageView+WebCache.h"
//#import "AFNetworking.h"
//#import "UIButton+WebCache.h"



#define iphone4_height  480.0f
#define iphone5_height  568.0f
#define iphone6_height  667.0f
#define iphone6p_height 736.0f

#define iphone4_width  320.0f
#define iphone5_width  320.0f
#define iphone6_width  375.0f
#define iphone6p_width 414.0f

#define iOS6 [[[UIDevice currentDevice]systemVersion]floatValue] >=6.0
#define iOS7 [[[UIDevice currentDevice]systemVersion]floatValue] >=7.0


#define fontSize14 [UIFont systemFontOfSize:14.0f]

#define screen_Width [UIScreen mainScreen].bounds.size.width

#define screen_Height [UIScreen mainScreen].bounds.size.height

#define nav_Height 64.0f
#define tabBar_Height 40.0f


//分类
#define URL_CATEGORY  @"http://course.jaxus.cn/api/category/subcategories?allSubcategories=%ld"
//分类详情
#define URL_CATEGORY_DETAIL @"http://course.jaxus.cn/api/category/%@/courses?channel=appstore&end=20&freeCourse=0&platform=2&start=0"
//分类-详情-播放
#define URL_CATEGORY_DETAIL_BOFANG @"http://course.jaxus.cn/api/course/%@?channel=appstore&platform=2"
//分类-播放
#define URL_BOFANG @"http://course.jaxus.cn/api/video/url?previewTime=-1&type=online&version=1&videoId=%@"

//精品-推荐
#define URL_GOODS_RECOMMEND @"http://course.jaxus.cn/api/%@/%@?channel=appstore&end=20&platform=2&start=0"

//排行
#define URL_LIST @"http://course.jaxus.cn/api/rank?channel=appstore&platform=2"
#endif








