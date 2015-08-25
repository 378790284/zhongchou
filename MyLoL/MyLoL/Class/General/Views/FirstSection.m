//
//  FirstSection.m
//  MyLoL
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "FirstSection.h"
#import "XLScrollViewer.h"
#import "HomepageInformation.h"
#import "EventHomePageController.h"
#import "CharmingPhotoHome.h"
#import "FunnyPictureHome.h"
#import "WallPaperController.h"

@interface FirstSection ()

@property (nonatomic, strong)XLScrollViewer *scroll;
@property (nonatomic, strong)HomepageInformation *informationVC;
@property (nonatomic, strong)EventHomePageController *evenHomeVC;
@property (nonatomic, strong)CharmingPhotoHome *charmingPhotoVC;
@property (nonatomic, strong)FunnyPictureHome *funnyPictureVC;
@property (nonatomic, strong)WallPaperController *wallPageVC;

@end

@implementation FirstSection

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.informationVC      = [[HomepageInformation alloc]init];
    self.evenHomeVC         = [[EventHomePageController alloc]init];
    self.charmingPhotoVC    = [[CharmingPhotoHome alloc]init];
    self.funnyPictureVC     = [[FunnyPictureHome alloc]init];
    self.wallPageVC         = [[WallPaperController alloc]init];
    self.informationVC.view.userInteractionEnabled = YES;
    self.view.userInteractionEnabled = YES;
    
    CGRect frame =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height -64);
    NSArray *views = @[self.informationVC.view, self.evenHomeVC.view, self.charmingPhotoVC.view, self.funnyPictureVC.view, self.wallPageVC.view];
    
    NSArray *names = @[@"头条", @"赛事", @"美照", @"搞笑", @"壁纸"];
    
    self.scroll.userInteractionEnabled = NO;
    self.scroll =[XLScrollViewer scrollWithFrame:frame withViews:views withButtonNames:names withThreeAnimation:222];//三中动画都选择
    
    //自定义各种属性。。打开查看
    //    self.scroll.xl_topBackImage =[UIImage imageNamed:@"10.jpg"];
    self.scroll.xl_topBackColor =[UIColor yellowColor];
    self.scroll.xl_sliderColor =[UIColor clearColor];
    self.scroll.xl_buttonColorNormal =[UIColor redColor];
    self.scroll.xl_buttonColorSelected =[UIColor blueColor];
    self.scroll.xl_buttonFont =14;
    self.scroll.xl_buttonToSlider =30;
    self.scroll.xl_sliderHeight =30;
    self.scroll.xl_topHeight =30;
    self.scroll.xl_isSliderCorner =YES;
    
    //加入控制器视图
    [self.view addSubview:self.scroll];
}

@end
