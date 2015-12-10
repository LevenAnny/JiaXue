//
//  XJViewController.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/25.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "XJViewController.h"

@interface XJViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)NSArray *btnArray;//所有要显示的按钮
@property(nonatomic,strong)NSArray *myViewControllers;//所有要显示的视图
@property(nonatomic,assign)NSInteger number;//页面显示几个UIButton

@property (strong,nonatomic)UIScrollView *myScrollView;//当前主页面的滚动视图
@property (strong,nonatomic)UILabel *redLabel;
@property (strong,nonatomic)UIScrollView *btnScrollView;//btn按钮后的滚动视图

@end

@implementation XJViewController

-(id)initWithBtnArray:(NSArray *)btnArray  andWithVCS:(NSArray *)vcArray andCurrentPage:(NSInteger)page{
    self = [super init];
    if (self) {
        self.btnArray = btnArray;
        self.myViewControllers = vcArray;
        self.number = page;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self creatNavButton];
    [self creatUIView];

}
-(UIScrollView *)btnScrollView
{
    if (!_btnScrollView) {
        _btnScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 45)];
        _btnScrollView.showsHorizontalScrollIndicator = NO;
        _btnScrollView.showsVerticalScrollIndicator = NO;
        _btnScrollView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.btnScrollView];
    }
    return _btnScrollView;
}

-(UIScrollView *)myScrollView
{
    if (!_myScrollView) {
        _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, screen_Width, screen_Height-44-64)];
        _myScrollView.delegate = self;
        [self.view addSubview:_myScrollView];
    }
    return _myScrollView;
}

//创建主页的三个导航按钮，分类，精品，排行
-(void)creatNavButton{
    
    //循环创建
    for(int i = 0;i<self.btnArray.count;i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*screen_Width/self.number, 5, screen_Width/self.number, 40);
        [btn setTitle:self.btnArray[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        if(i == 0){
            btn.selected = YES;
        }
        [self.btnScrollView addSubview:btn];
    }
    
    self.btnScrollView.contentSize = CGSizeMake(self.btnArray.count*(screen_Width/self.number), 0);
    
    //按钮下的红色横线
    self.redLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 42, screen_Width/self.number, 2)];
    self.redLabel.backgroundColor = [UIColor redColor];
    [self.btnScrollView addSubview:self.redLabel];
    
}

//创建三大主页面
-(void)creatUIView{
    
    for (int i = 0; i<self.myViewControllers.count; i++) {
        UIViewController *obj = self.myViewControllers[i];
        obj.view.frame = CGRectMake(i*self.myScrollView.frame.size.width, 0, self.myScrollView.frame.size.width, self.myScrollView.frame.size.height);
        [self.myScrollView addSubview:obj.view];
        [self addChildViewController:obj];
        
    }
    
    self.myScrollView.contentSize = CGSizeMake(self.myScrollView.frame.size.width*self.myViewControllers.count, 0);
    self.myScrollView.pagingEnabled = YES;
}

//点击@"分类",@"精品",@"排行"三个按钮的时候，动画改变红色label的frame  同时改变滚动视图的偏移量
-(void)btnClick:(UIButton *)btn{
    //改变按钮和label的状态
    [self upDateUIButtonAndLabel:btn.tag-100];

    [self updateScrollViewWithPage:btn.tag-100];
}


-(void)upDateUIButtonAndLabel:(NSInteger)tag{
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:(tag+100)];
    //循环遍历所有的子视图
    for (int i = 0; i<self.btnScrollView.subviews.count; i++) {
        //依此取出所有的子视图
        id obj = self.btnScrollView.subviews[i];
        //如果该子视图是UIButton类型
        if ([obj isKindOfClass:[UIButton class]]) {
            //强转UIButton类型
            UIButton *objBtn = (UIButton *)obj;
            //如果当前点击的按钮等于当前遍历的这个按钮
            if (objBtn.tag == btn.tag) {
                //那么把当前点击的按钮设置为选中状态，并执行动画
                btn.selected = YES;
                //UIView自带的动画
                [UIView  animateWithDuration:0.2 animations:^{
                    
                    CGRect frame = self.redLabel.frame;
                    frame.origin.x = btn.frame.origin.x;
                    self.redLabel.frame = frame;
                    
                }];
                
            }else{//所有非选中的按钮，设为非选中状态，字体颜色为灰色
                objBtn.selected = NO;
            }
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateScrollViewWithPage:(NSInteger)page{
    
    //改变偏移量
    [self.myScrollView setContentOffset:CGPointMake(page*self.myScrollView.frame.size.width, 0) animated:NO];}

#pragma  mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger page = scrollView.contentOffset.x/self.myScrollView.frame.size.width;
    
    
    [self upDateUIButtonAndLabel:page];

    
    //根据偏移量改变btnScrollView的偏
    if(((page+1)-self.number)>=0){
    [self.btnScrollView setContentOffset:CGPointMake(((page+1)-self.number)*self.redLabel.frame.size.width, 0) animated:YES];
    }
    

}


@end
