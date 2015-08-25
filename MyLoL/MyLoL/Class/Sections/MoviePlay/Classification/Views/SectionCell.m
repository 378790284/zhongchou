//
//  SectionCell.m
//  MyLoL
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "SectionCell.h"
#import "UIViewAdditions.h"
#import "ViewModel.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "Define.h"

@interface SectionCell ()

@property (nonatomic,strong)UIView *aView;

@property (nonatomic,strong)NSMutableArray *dataArray;



@end

@implementation SectionCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
    }
    return self;
}


- (UIView *)aView
{
    if (_aView == nil) {
        self.aView = [[UIView alloc]initWithFrame:CGRectMake(self.left, self.top, self.width, self.height)];
        self.aView.userInteractionEnabled = YES;
//        _aView.backgroundColor = DEBUG_COLOR;
    }
    return _aView;
}

- (void)addCellForArray:(NSDictionary *)array
{
    
    
    NSArray *dealArray = [array objectForKey:@"subCategory"];

    for (NSDictionary *everyCell in dealArray) {
        ViewModel *viewModel1 = [[ViewModel alloc]initWithDiction:everyCell];
        [self.dataArray addObject:viewModel1];
    }
    
    
    for (int i = 0; i < self.dataArray.count; i++) {
        
        UIImageView *aImageView = [[UIImageView alloc]initWithFrame:CGRectMake((i % 4) * 80 + 5, (i / 4) * 100, 70, 70)];
        UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(aImageView.left, aImageView.bottom, aImageView.width, 25)];
        
        ViewModel *viewModel = (ViewModel *)self.dataArray[i];
        
        [aImageView sd_setImageWithURL:(NSURL *)viewModel.icon];
        aImageView.tag = i + 300;
        aLabel.text = viewModel.name;
        aImageView.userInteractionEnabled = YES;
        [self addTapGesture:aImageView];
        
//        aImageView.backgroundColor = DEBUG_COLOR;
//        aLabel.backgroundColor = DEBUG_COLOR;
        aLabel.textAlignment = NSTextAlignmentCenter;
        aLabel.font = FONT(14);
        [self.aView addSubview: aImageView];
        [self.aView addSubview: aLabel];
    }
    
    CGFloat height = ((self.dataArray.count - 1) / 4 + 1) * 100;
    
    self.aView.frame = CGRectMake(self.left, self.top, self.width, height);
    
    [self addSubview:self.aView];
    
}

- (void)addTapGesture:(UIImageView *)aImageView
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushAnther:)];
    [aImageView addGestureRecognizer:tap];
}

- (void)pushAnther:(UIGestureRecognizer *)tap
{
    ViewModel *viewModel = [[ViewModel alloc]init];
    viewModel = (ViewModel *)self.dataArray[tap.view.tag - 300];
    if ([_delegate respondsToSelector:@selector(pushotherVC:)]) {
        [_delegate pushotherVC:viewModel.tag];
    }
}


- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}



@end
