//
//  HouMoviePlayerViewController.h
//  自定义播放器demo
//
//  Created by 侯志超 on 15/7/13.
//  Copyright (c) 2015年 侯志超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieModel;
@class Tramscpde;
@interface HouMoviePlayerViewController : UIViewController

@property (nonatomic, strong) NSURL *movieURL;
@property (nonatomic, strong) NSString *titleName;
@property (nonatomic, strong) MovieModel *movieModel;

@end
