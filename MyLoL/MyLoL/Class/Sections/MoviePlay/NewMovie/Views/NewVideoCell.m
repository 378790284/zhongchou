

//
//  NewVideoCell.m
//  MyLoL
//
//  Created by lanou3g on 15/7/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NewVideoCell.h"
#import "NewVideoModel.h"
#import "Define.h"
#import "UIViewAdditions.h"
#import "UIImageView+WebCache.h"
#import "DownLoadView.h"
#import "FmdbModel.h"


@interface NewVideoCell ()

@property (nonatomic,strong)UIImageView *aImageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *longTimeLabel;
@property (nonatomic,strong)UILabel *speatorline;
//@property (nonatomic,strong)DownLoadView *downLoadVC;



@end

@implementation NewVideoCell

- (void)confingNewvideo:(NewVideoModel *)newVideoModel
{
    [self.aImageView sd_setImageWithURL:(NSURL *)newVideoModel.cover_url];
    self.titleLabel.text = [NSString stringWithFormat:@"%@", newVideoModel.title];
    
    
    self.timeLabel.text = [self contentTime:newVideoModel.upload_time];
    self.longTimeLabel.text = [self videoAllTime:newVideoModel.video_length];
    
    //创建收藏按钮
    
//    [self addSubview:self.downLoadVC];
    //下载按钮
//    [self addSubview:self.downLoadButton];
    
    [self addSubview:self.collectButton];
    [self addSubview:self.aImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.longTimeLabel];
    [self addSubview:self.speatorline];
}

- (void)collectionVideo:(NSString *)movieTitle
              movieTime:(NSString *)movieTime
             movieImage:(NSString *)movieImage
            movieUpdate:(NSString *)movieUpdate
{
    [self.aImageView sd_setImageWithURL:(NSURL *)movieImage];
    self.titleLabel.text = [NSString stringWithFormat:@"%@", movieTitle];
    self.timeLabel.text = [self contentTime:movieUpdate];
    self.longTimeLabel.text = [self videoAllTime:movieTime];
    
    [self addSubview:self.collectButton];
    
    [self addSubview:self.aImageView];
    [self addSubview:self.timeLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.longTimeLabel];
}

- (void)getDownName:(NSString *)downName
      downUrlString:(NSString *)downUrlString
             sender:(UIButton *)sender
{
    [[DownLoadView shareDownLoad] loadDataDownName:downName downLoadURL:downUrlString sender:sender];
}


//- (DownLoadView *)downLoadVC
//{
//    if (_downLoadVC == nil) {
//        self.downLoadVC = [[DownLoadView alloc]initWithFrame:CGRectMake(0, 0, self.width , self.aImageView.height)];
////        NSLog(@"%@",NSStringFromCGRect(self.frame));
//       // _downLoadVC.downLoadButton.frame = CGRectMake(self.timeLabel.left + 40, self.timeLabel.top , 40, 20);
////        _downLoadVC.sliderView.frame = CGRectMake(0, self.aImageView.bottom + 4, MAIN_SCREEN_WIDTH, 1);
//        
//        _downLoadVC.sliderView.hidden = YES;
//        _downLoadVC.progress.hidden = YES;
//        _downLoadVC.downLoadButton.hidden = YES;
//    }
//    return _downLoadVC;
//}

#pragma mark -- 下载按钮
//- (UIButton *)downLoadButton
//{
//    if (_downLoadButton == nil) {
//        self.downLoadButton = [UIButton buttonWithType:UIButtonTypeSystem];
//        _downLoadButton.frame = CGRectMake(self.timeLabel.left + 40, self.timeLabel.top , 40, 20);
////        [_downLoadButton addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
//        [_downLoadButton setTitle:@"下载" forState:UIControlStateNormal];
//        _downLoadButton.titleLabel.font = FONT(12);
//        _downLoadButton.backgroundColor = [UIColor redColor];
//    }
//    return _downLoadButton;
//}
//

#pragma mark -- 收藏按钮

- (UIButton *)collectButton
{
    if (_collectButton == nil) {
        self.collectButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _collectButton.frame = CGRectMake(self.timeLabel.left + 40, self.timeLabel.top, 50, 20);
        _collectButton.titleLabel.font = FONT(12);
        _collectButton.backgroundColor = [UIColor redColor];
    }
    return _collectButton;
}


- (UIImageView *)aImageView
{
    if (_aImageView == nil) {
        self.aImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, HOMEVIDEO_CELL_WIDTH, HOMEVIDEO_CELL_HEIGTH)];
        _aImageView.backgroundColor = DEBUG_COLOR;
    }
    return _aImageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.aImageView.right + 5, self.aImageView.top, MAIN_SCREEN_WIDTH - HOMEVIDEO_CELL_WIDTH - 20, self.aImageView.height / 3 * 2)];
//        _titleLabel.backgroundColor = DEBUG_COLOR;
        _titleLabel.numberOfLines = 0;
        
    }
    
    return _titleLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom + 5, 80, 20)];
//        _timeLabel.backgroundColor = DEBUG_COLOR;
        _timeLabel.textColor = RGB_COLOR(0, 0, 0, 0.5);
        _timeLabel.font = FONT(12);
    }
    return _timeLabel;
}

- (UILabel *)longTimeLabel
{
    if (_longTimeLabel == nil) {
        self.longTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.right - 80, self.timeLabel.top, 80, 20)];
        _longTimeLabel.textColor = RGB_COLOR(155, 155, 155, 1);
        _longTimeLabel.textAlignment = NSTextAlignmentRight;
        [_downLoadButton setTitle:@"下载" forState:UIControlStateNormal];
        _longTimeLabel.font = FONT(12);
    }
    return _longTimeLabel;
}

- (UILabel *)speatorline
{
    if (_speatorline == nil) {
        self.speatorline = [[UILabel alloc]initWithFrame:CGRectMake(0, self.aImageView.bottom + 5, MAIN_SCREEN_WIDTH, 1)];
        _speatorline.backgroundColor = RGB_COLOR(155, 155, 155, 1);
    }
    return _speatorline;
}

- (NSString *)contentTime:(NSString *)time
{
    NSArray *timeArray = [time componentsSeparatedByString:@" "];
//    NSLog(@"%@", timeArray);
    
    NSArray *dataArray = [[timeArray firstObject] componentsSeparatedByString:@"-"];
//    NSLog(@"%@", dataArray);
    
    NSString *newdata = [NSString stringWithFormat:@"%@-%@", dataArray[1], dataArray[2]];
    
    return newdata;
}

- (NSString *)videoAllTime:(NSString *)videoLong
{
    NSInteger time = [videoLong integerValue];
    
    NSInteger hour = time / 3600;
    NSInteger lastSecond = time % 3600;
    
    NSInteger min = lastSecond / 60;
    lastSecond = lastSecond % 60;
    
    NSString *AllTime = [NSString stringWithFormat:@"%ld:%ld:%ld", hour, min, lastSecond];
    return AllTime;
}


@end
