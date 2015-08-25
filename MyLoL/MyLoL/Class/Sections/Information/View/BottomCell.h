//
//  BottomCell.h
//  MyLoL
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "HomepageInformationModel.h"

@interface BottomCell : UITableViewCell

@property (nonatomic, strong)UIImageView *cellImage;
@property (nonatomic, strong)UILabel     *titleLabel;
@property (nonatomic, strong)UILabel     *contontLabel;
@property (nonatomic, strong)UILabel     *lookTime;
@property (nonatomic, strong)HomepageInformationModel *HomePageInfoModel;


@end
