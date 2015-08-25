//
//  NewVideoCell.h
//  MyLoL
//
//  Created by lanou3g on 15/7/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewVideoModel.h"

@interface NewVideoCell : UITableViewCell

- (void)confingNewvideo:(NewVideoModel *)newVideoModel;

@property (nonatomic,strong)UIButton *downLoadButton;

@property (nonatomic,strong)NewVideoModel *videoModel;

@property (nonatomic,strong)UIButton *collectButton;

//创建收藏单元格
- (void)collectionVideo:(NSString *)movieTitle
              movieTime:(NSString *)movieTime
             movieImage:(NSString *)movieImage
            movieUpdate:(NSString *)movieUpdate;

- (void)getDownName:(NSString *)downName
      downUrlString:(NSString *)downUrlString
             sender:(UIButton *)sender;

@end
