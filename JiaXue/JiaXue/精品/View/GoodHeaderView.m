//
//  GoodHeaderView.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/30.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "GoodHeaderView.h"
#import "UIImageView+WebCache.h"
#import "Header.h"

@interface GoodHeaderView()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *myScrollView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)UILabel *titleLabel;

@end

@implementation GoodHeaderView


-(void)setBannerArray:(NSArray *)bannerArray
{
    _bannerArray = bannerArray;
    
    for (int i = 0; i<_bannerArray.count; i++) {
        BannersModel *model = _bannerArray[i];
        
        //根据数据源的个数，创建图片的个数
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 100+i;
        [self.myScrollView addSubview:imageView];
        
        //根据model里存储的网址下载图片
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
        //第一张图片上lable显示的文字
        if(i == 0){
            self.titleLabel.text = model.title;
        }
        
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [imageView addGestureRecognizer:tap];
    }
    
    self.pageControl.numberOfPages = bannerArray.count;
    self.myScrollView.contentSize = CGSizeMake(_bannerArray.count*self.frame.size.width, 0);
    self.myScrollView.pagingEnabled = YES;
    
}

-(void)tapClick:(UITapGestureRecognizer *)tap{
    //点击广告页面上的图片，响应的方法
    if ([self.delegate respondsToSelector:@selector(didSelectedImageView:)]) {
        [self.delegate didSelectedImageView:self.bannerArray[tap.view.tag-100]];
    }

}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
      
        self.myScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.myScrollView.delegate = self;
        [self addSubview:self.myScrollView];

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height*0.7, self.frame.size.width, self.frame.size.height*0.3)];
        view.backgroundColor = [UIColor grayColor];
        view.alpha = 0.3;
        [self addSubview:view];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height*0.7, self.frame.size.width, self.frame.size.height*0.3)];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width-150, self.frame.size.height*0.8, 150, 30)];
        [self addSubview:self.pageControl];
        
    }
    return self;
}

#pragma mark  UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger page = scrollView.contentOffset.x/self.frame.size.width;
    
    BannersModel *model = self.bannerArray[page];
    
    self.titleLabel.text = model.title;
    self.pageControl.currentPage = page;
}


@end










