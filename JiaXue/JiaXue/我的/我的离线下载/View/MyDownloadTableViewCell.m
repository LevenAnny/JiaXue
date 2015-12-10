//
//  MyDownloadTableViewCell.m
//  JiaXue
//
//  Created by xiang_jj on 15/11/27.
//  Copyright (c) 2015年 xiang_jj  千锋. All rights reserved.
//

#import "MyDownloadTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface MyDownloadTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIProgressView *myProgressView;


@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIButton *stopBtn;

@end


@implementation MyDownloadTableViewCell

-(void)setDetailModel:(CategoryDetailModel *)detailModel
{
    _detailModel = detailModel;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:_detailModel.iconUrl]];
    self.titleLabel.text = _detailModel.title;
    

}

-(void)setSession:(MySessionDownloadStopAndResume *)session
{
    _session = session;

    [self.myProgressView setProgress:session.progress];
    if (_session.progress == 1.0) {
        self.progressLabel.text = @"下载成功！";
        self.stopBtn.alpha = 0;
    }else{
        //这里是为了保证按钮的状态被正确显示
        if (_session.isStop == YES) {
            [self.stopBtn setTitle:@"继续" forState:UIControlStateSelected];
            self.stopBtn.selected = YES;
        }else{
            [self.stopBtn setTitle:@"暂停" forState:UIControlStateSelected];
            self.stopBtn.selected = NO;
        }
    }
    

}

//如果当前cell显示的视频已经被下载了
-(void)updateUI
{
    [self.myProgressView setProgress:1.0f];
    self.progressLabel.text = @"已下载！";
    self.stopBtn.alpha = 0;

    
}

//暂停按钮被点击
- (IBAction)stopBtnClick:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    if (btn.selected == NO) {
        btn.selected = YES;
        [btn setTitle:@"继续" forState:UIControlStateSelected];
        [self.session  pauseDownload];
        
    }else
    {
        btn.selected = NO;
        [btn setTitle:@"暂停" forState:UIControlStateSelected];
        [self.session continueDownLoad];

    }
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
