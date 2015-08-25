

//
//  MyTabBarController.m
//  MyLoL
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MyTabBarController.h"
#import "HomepageInformation.h"
#import "EventHomePageController.h"
#import "CharmingPhotoHome.h"
#import "FunnyPictureHome.h"
#import "WallPaperController.h"
#import "ClassificationView.h"
#import "NewVideoController.h"
#import "SetViewController.h"

#import "FirstSection.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadControllers];
}

- (void)loadControllers
{
//    HomepageInformation *homePageVC = [[HomepageInformation alloc]init];
//    homePageVC.title = @"主页";
//    UINavigationController *homePageNav = [[UINavigationController alloc]initWithRootViewController:homePageVC];
//    self.tabBar.translucent = NO;
//    
//    
//    EventHomePageController *eventHomeVC = [[EventHomePageController alloc]init];
//    eventHomeVC.title = @"赛事";
//    UINavigationController *eventNav = [[UINavigationController alloc]initWithRootViewController:eventHomeVC];
//    self.tabBar.translucent = NO;
//    
//    CharmingPhotoHome *charmingPhotoHomeVC = [[CharmingPhotoHome alloc]init];
//    charmingPhotoHomeVC.title = @"靓照";
//    UINavigationController *charmingPhotoNav = [[UINavigationController alloc]initWithRootViewController:charmingPhotoHomeVC];
//    
//    FunnyPictureHome *funnyHomeVC = [[FunnyPictureHome alloc]init];
//    funnyHomeVC.title = @"囧图";
//    UINavigationController *funnyHomeNav = [[UINavigationController alloc]initWithRootViewController:funnyHomeVC];
//    
//    WallPaperController *wallPaperHome = [[WallPaperController alloc]init];
//    wallPaperHome.title = @"壁纸";
//    UINavigationController *wallPaperNav = [[UINavigationController alloc]initWithRootViewController:wallPaperHome];
    
    NewVideoController *newVideoVC = [[NewVideoController alloc]init];
    newVideoVC.title = @"视频";
    UINavigationController *newVideoNav = [[UINavigationController alloc]initWithRootViewController:newVideoVC];
    
    
    FirstSection *firstSectionVC = [[FirstSection alloc]init];
    firstSectionVC.title = @"信息";
    UINavigationController *firstSectionNav = [[UINavigationController alloc]initWithRootViewController:firstSectionVC];
    
    ClassificationView *classificationVC = [[ClassificationView alloc]init];
    classificationVC.title = @"解说视频";
    UINavigationController *classificationNav = [[UINavigationController alloc]initWithRootViewController:classificationVC];
    
    SetViewController *setVC = [[SetViewController alloc]init];
    setVC.title = @"设置";
    UINavigationController *setNav = [[UINavigationController alloc]initWithRootViewController:setVC];
    
    self.view.userInteractionEnabled = YES;
    self.viewControllers = @[firstSectionNav ,newVideoNav, classificationNav,setNav];
    
    self.tabBar.translucent = NO;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
