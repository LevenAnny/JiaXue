//
//  SectionHeaderView.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/24.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "SectionHeaderView.h"

@implementation SectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame andName:(NSString *)name
{
    self = [super initWithFrame:frame];
    if (self) {
    
        
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 1)];
        imageView.image =[UIImage imageNamed:@"navi_sha"];
        [self addSubview:imageView];
        
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(8, 0, 200, self.frame.size.height)];
        label.text =name;
        label.textColor =[UIColor blackColor];
        label.font =[UIFont systemFontOfSize:14.0f];
        [self addSubview:label];
        
//        
//        UILabel *moreLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-70, 0, 30, 30)];
//        moreLabel.text = @"更多";
//        moreLabel.textColor =[UIColor blackColor];
//        moreLabel.font =[UIFont systemFontOfSize:14.0f];
//        [self addSubview:moreLabel];
        
        UIImageView *image =[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width -30 -15, 0, 30, 30)];
        image.image= [UIImage imageNamed:@"buddy_arrow_right"];
        [self addSubview:image];
        
    }
    return self;
}
@end
