//
//  BottomCell.m
//  MyLoL
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "BottomCell.h"
#import "Define.h"
#import "UIViewAdditions.h"

@implementation BottomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.cellImage];
        [self.contentView addSubview:self.titleLabel];
        
        [self.contentView addSubview:self.contontLabel];
        [self.contentView addSubview:self.lookTime];
    }
    return self;
}

- (void)setHomePageInfoModel:(HomepageInformationModel *)HomePageInfoModel
{
    [self.cellImage sd_setImageWithURL:(NSURL *)HomePageInfoModel.photo];
    self.titleLabel.text = HomePageInfoModel.title;
    self.contontLabel.text = HomePageInfoModel.content;
    self.lookTime.text = [NSString stringWithFormat:@"%@ 阅读",HomePageInfoModel.readCount] ;
}

- (UIImageView *)cellImage
{
    if (_cellImage == nil) {
        self.cellImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, HOMEPAGE_CELL_HEIGHT, HOMEPAGE_CELL_WIDTH)];
        //_cellImage.backgroundColor = DEBUG_COLOR;
    }
    return _cellImage;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.cellImage.right + 5, self.cellImage.top, MAIN_SCREEN_WIDTH * 0.6, MAIN_SCREEN_HEIGHT / 128 * 7)];
        //_titleLabel.backgroundColor = DEBUG_COLOR;
        _titleLabel.font = FONT(0.040 * MAIN_SCREEN_WIDTH);
    }
    return _titleLabel;
}

- (UILabel *)contontLabel
{
    if (_contontLabel == nil) {
        self.contontLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.left , self.titleLabel.bottom , self.titleLabel.width, self.titleLabel.height)];
        //_contontLabel.backgroundColor =DEBUG_COLOR;
        _contontLabel.font = FONT(0.031 * MAIN_SCREEN_WIDTH);
        _contontLabel.numberOfLines = 0;
    }
    return _contontLabel;
}


- (UILabel *)lookTime
{
    if (_lookTime == nil) {
        self.lookTime = [[UILabel alloc]initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH / 15 * 12, HOMEPAGE_CELL_HEIGHT * 0.55, MAIN_SCREEN_WIDTH / 5, HOMEPAGE_CELL_HEIGHT / 7)];
        //_lookTime.backgroundColor = DEBUG_COLOR;
        _lookTime.font = FONT(0.031 * MAIN_SCREEN_WIDTH);
    }
    return _lookTime;
}

@end
