//
//  DownLoadController.h
//  MyLoL
//
//  Created by lanou3g on 15/7/21.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface DownLoadView : UIView

+ (DownLoadView *)shareDownLoad;

@property (nonatomic,strong)UIButton *downLoadButton;
@property (nonatomic,strong)UIProgressView *sliderView;
@property (nonatomic,strong)UILabel  *progress;
//下载地址
@property (nonatomic,strong)NSString *downLoadURL;
//下载名字
@property (nonatomic,strong)NSString *downName;

- (void)loadDataDownName:(NSString *)downName
             downLoadURL:(NSString *)downLoadURL
                  sender:(UIButton *)sender;

@end
