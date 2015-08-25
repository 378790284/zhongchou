//
//  SectionCell.h
//  MyLoL
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SectionCellDelegate <NSObject>

- (void)pushotherVC:(NSString *)str;



@end

@interface SectionCell : UITableViewCell

@property (nonatomic,assign)id<SectionCellDelegate>delegate;
@property (nonatomic,strong)NSString *tagString;
- (void)addCellForArray:(NSDictionary *)array;


@end
