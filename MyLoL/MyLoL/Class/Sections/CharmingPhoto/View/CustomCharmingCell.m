//
//  CustomCharmingCell.m
//  MyLoL
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CustomCharmingCell.h"
#import "UIViewAdditions.h"
#import "Define.h"
#import "CharmingPhotoModel.h"
#import "UIImageView+WebCache.h"

@implementation CustomCharmingCell

- (UIImageView *)aImageView
{
    if (_aImageView == nil) {
        self.aImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (MAIN_SCREEN_WIDTH - 15) / 2, 160)];
        _aImageView.backgroundColor = DEBUG_COLOR;
    }
    return _aImageView;
}

- (UILabel *)numberLabel
{
    if (_numberLabel == nil) {
        self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.aImageView.bottom, self.aImageView.width, (20 / 568) * MAIN_SCREEN_HEIGHT)];
        self.numberLabel.backgroundColor = RGB_COLOR(0, 0, 0, 1);
        _numberLabel.font = FONT(14);
        _numberLabel.textAlignment = NSTextAlignmentLeft;
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.alpha = 0.7;
    }
    return _numberLabel;
}

- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.numberLabel.bottom, self.numberLabel.width - 10, (40 / 568) * MAIN_SCREEN_HEIGHT)];
        self.contentLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.f];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
//        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.numberOfLines = 2;
        
    }
    return _contentLabel;
}

// 在加载数据的时候要从新定义这些控件的frame
- (void)configCellWithNewsModel:(CharmingPhotoModel *)model
{
    CGRect frame = self.aImageView.frame;
    frame.size.height = ([model.coverHeight floatValue] - 40) / 568 * MAIN_SCREEN_HEIGHT;
    self.aImageView.frame = frame;
    [self.aImageView sd_setImageWithURL:(NSURL *)model.coverUrl];
    
    self.numberLabel.text = [NSString stringWithFormat:@" %@张",model.picsum];
    self.numberLabel.frame = CGRectMake(0, self.aImageView.bottom, self.aImageView.width, 20 * MAIN_SCREEN_HEIGHT / 568);
    
    NSString *newTitle = [model.title stringByReplacingOccurrencesOfString:@"手机盒子" withString:@"LOL"];
    self.contentLabel.text = [NSString stringWithFormat:@"%@", newTitle];
    self.contentLabel.frame = CGRectMake(5, self.numberLabel.bottom, self.numberLabel.width - 10, 40 * MAIN_SCREEN_HEIGHT / 568);
    
    [self addSubview:self.aImageView];
    [self addSubview:self.numberLabel];
    [self addSubview:self.contentLabel];
}

@end
