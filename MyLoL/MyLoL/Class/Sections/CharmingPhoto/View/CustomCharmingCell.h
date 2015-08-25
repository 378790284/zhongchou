//
//  CustomCharmingCell.h
//  MyLoL
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharmingPhotoModel.h"

@interface CustomCharmingCell : UICollectionViewCell

@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UIImageView *aImageView;
@property (nonatomic,strong)UILabel *contentLabel;

- (void)configCellWithNewsModel:(CharmingPhotoModel *)model;

@end
