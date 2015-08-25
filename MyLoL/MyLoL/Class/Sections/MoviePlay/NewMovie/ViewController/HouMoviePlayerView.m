//
//  HouMoviePlayerView.m
//  自定义播放器demo
//
//  Created by 侯志超 on 15/7/13.
//  Copyright (c) 2015年 侯志超. All rights reserved.
//

#import "HouMoviePlayerView.h"
#import <AVFoundation/AVFoundation.h>

@implementation HouMoviePlayerView

//  重新播放界面的init方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        //  添加所有子视图
        [self addAllSubViews];
        
    }
    return self;
}

- (void)layoutSubviews
{
    self.topOperationView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 54);
    self.rightOperationView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 45, CGRectGetMaxY(_topOperationView.frame) + 8, 45, 185);
    self.bottomOperationView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 65, [UIScreen mainScreen].bounds.size.width, 65);
    self.endTimeLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 9, 48, 21);
    
    self.progressSlider.frame = CGRectMake(CGRectGetMaxX(self.startTimeLabel.frame) + 6, 5, CGRectGetMinX(self.endTimeLabel.frame) - 12 - CGRectGetMaxX(self.startTimeLabel.frame), 31);
    

}
//  添加所有子视图的方法
- (void)addAllSubViews
{
    //  顶部的操作视图
    self.topOperationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 54)];
    self.topOperationView.backgroundColor = [UIColor blackColor];
    self.topOperationView.alpha = 0.69;
    [self addSubview:_topOperationView];
    //  顶部视图上添加返回按钮
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"播放器_返回"] forState:UIControlStateNormal];
    self.backButton.frame = CGRectMake(4, 17, 36, 36);
    [self.topOperationView addSubview:_backButton];
    //  顶部添加movieNameLabel
    self.movieName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.backButton.frame) + 1, 25, 362, 21)];
    self.movieName.font = [UIFont systemFontOfSize:13.0];
    self.movieName.textColor = [UIColor whiteColor];
    self.movieName.textAlignment = NSTextAlignmentCenter;
    [self.topOperationView addSubview:self.movieName];
    
    
    
    
    //  左面的操作视图
    self.leftOperationView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topOperationView.frame) + 8, 45, 185)];
    self.leftOperationView.backgroundColor = [UIColor blackColor];
    self.leftOperationView.alpha = 0.69;
    [self addSubview:_leftOperationView];
    //  左面视图添加三个操作按钮
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareButton setBackgroundImage:[UIImage imageNamed:@"分享_plyer"] forState:UIControlStateNormal];
    self.shareButton.frame = CGRectMake(7, 22, 27, 40);
    [self.leftOperationView addSubview:self.shareButton];
    
    self.colletionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.colletionButton setBackgroundImage:[UIImage imageNamed:@"收藏_plyer"] forState:UIControlStateNormal];
    self.colletionButton.frame = CGRectMake(7, CGRectGetMaxY(self.shareButton.frame) + 10, 27, 40);
    [self.leftOperationView addSubview:self.colletionButton];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.saveButton setBackgroundImage:[UIImage imageNamed:@"缓存_plyer"] forState:UIControlStateNormal];
    self.saveButton.frame = CGRectMake(7, CGRectGetMaxY(self.colletionButton.frame) + 10, 27, 40);
    [self.leftOperationView addSubview:self.saveButton];
      //  右面的操作视图
    self.rightOperationView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 45, CGRectGetMaxY(_topOperationView.frame) + 8, 45, 185)];
    self.rightOperationView.backgroundColor = [UIColor blackColor];
    self.rightOperationView.alpha = 0.69;
    [self addSubview:_rightOperationView];
    //  右面视图添加两个控件
    //  音量滑杆
    self.voiceSlider = [[UISlider alloc] initWithFrame:CGRectMake(-27, 68, 100, 31)];
    self.voiceSlider.transform = CGAffineTransformRotate(self.voiceSlider.transform, -M_PI_2);
    [self.rightOperationView addSubview:_voiceSlider];
    //  音量图标
    self.voiceImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"播放器_音量"]];
    self.voiceImageView.frame = CGRectMake(13, 143, 19, 19);
    [self.rightOperationView addSubview:_voiceImageView];
    //  底部的操作视图
    self.bottomOperationView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 65, [UIScreen mainScreen].bounds.size.width, 65)];
    self.bottomOperationView.backgroundColor = [UIColor blackColor];
    self.bottomOperationView.alpha = 0.69;
    [self addSubview:_bottomOperationView];
    
    //  底部视图上添加控件
    self.startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 9, 48, 21)];
    self.startTimeLabel.adjustsFontSizeToFitWidth = YES;
    self.startTimeLabel.text = @"00:00:00";
    self.startTimeLabel.textColor = [UIColor whiteColor];
    [self.bottomOperationView addSubview:_startTimeLabel];
    self.endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 9, 48, 21)];
    self.endTimeLabel.textColor = [UIColor whiteColor];
    [self.bottomOperationView addSubview:_endTimeLabel];
    
    self.progressSlider = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.startTimeLabel.frame) + 6, 5, CGRectGetMinX(self.endTimeLabel.frame) - 6, 31)];
    [self.bottomOperationView addSubview:_progressSlider];
    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playButton setBackgroundImage:[UIImage imageNamed:@"播放器_播放"] forState:UIControlStateNormal];
    self.playButton.frame = CGRectMake(23, 35, 24, 24);
    [self.bottomOperationView addSubview:_playButton];
    
    
    
}



@end
