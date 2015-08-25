//
//  HeaderView.h
//  MyLoL
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView<UIScrollViewDelegate>

@property (nonatomic,assign)BOOL isLock;

@property (nonatomic,strong)UIImageView *firstImage;
@property (nonatomic,strong)UIImageView *secondImage;
@property (nonatomic,strong)UIImageView *thirdImage;
@property (nonatomic,strong)UIImageView *fourthImage;
@property (nonatomic,strong)UIImageView *fifthImage;

@property (nonatomic,strong)UIPageControl *pageControl;

- (id)initWithFrame:(CGRect)frame;

@end
