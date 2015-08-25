//
//  HeaderView.m
//  MyLoL
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "HeaderView.h"
#import "Define.h"
#import "UIViewAdditions.h"


@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollView.backgroundColor = DEBUG_COLOR;
        scrollView.contentSize = CGSizeMake(frame.size.width * 5, frame.size.height);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.directionalLockEnabled = YES;
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.userInteractionEnabled = YES;
        scrollView.tag = 200;
        scrollView.userInteractionEnabled = YES;
        [scrollView addSubview:self.firstImage];
        [scrollView addSubview:self.secondImage];
        [scrollView addSubview:self.thirdImage];
        [scrollView addSubview:self.fourthImage];
        [scrollView addSubview:self.fifthImage];
        
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeNumber) userInfo:nil repeats:YES];
        
        [self addSubview:scrollView];
        [self addSubview:self.pageControl];
        
        //[_pageControl addTarget:self action:@selector(changPage:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}


- (UIImageView *)firstImage
{
    if(_firstImage == nil){
        self.firstImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.left, self.top, self.width, self.height)];
        _firstImage.backgroundColor = DEBUG_COLOR;
        _fifthImage.tag = 900;
        _firstImage.userInteractionEnabled = YES;
    }
    return _firstImage;
}

- (UIImageView *)secondImage
{
    if(_secondImage == nil){
        self.secondImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.width, self.top, self.width, self.height)];
        _secondImage.backgroundColor = DEBUG_COLOR;
        _secondImage.tag = 901;
        _secondImage.userInteractionEnabled = YES;
    }
    return _secondImage;
}

- (UIImageView *)thirdImage
{
    if(_thirdImage == nil){
        self.thirdImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.width * 2, self.top, self.width, self.height)];
        _thirdImage.backgroundColor = DEBUG_COLOR;
        _thirdImage.tag = 902;
        _thirdImage.userInteractionEnabled = YES;
    }
    return _thirdImage;
}

- (UIImageView *)fourthImage
{
    if(_fourthImage == nil){
        self.fourthImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.width * 3, self.top, self.width, self.height)];
        _fourthImage.backgroundColor = DEBUG_COLOR;
        _fourthImage.tag = 903;
        _fourthImage.userInteractionEnabled = YES;
    }
    return _fourthImage;
}

- (UIImageView *)fifthImage
{
    if(_fifthImage == nil){
        self.fifthImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.width * 4, self.top, self.width, self.height)];
        _fifthImage.backgroundColor = DEBUG_COLOR;
        _fifthImage.tag = 904;
        _fifthImage.userInteractionEnabled = YES;
    }
    return _fifthImage;
}

#pragma mark - ScrollView Method

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.width / 32 * 9, self.height / 8 * 7 , self.width / 32 * 14, self.height / 8)];
        _pageControl.numberOfPages = 5;
        //        self.pageControl.backgroundColor = [UIColor blackColor];
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

//- (void)changPage:(UIPageControl *)pageControl
//{
//    self.isLock = YES;
//    UIScrollView *scrollView = (UIScrollView *)[self viewWithTag:200];
//    [scrollView setContentOffset:CGPointMake(MAIN_SCREEN_WIDTH * pageControl.currentPage, 0) animated:YES];
//    NSLog(@"%ld", pageControl.currentPage);
//}


//连滚
- (void)changeNumber
{
    UIScrollView *scrollView = (UIScrollView *)[self viewWithTag:200];
    int with = scrollView.contentOffset.x + self.width;
    [scrollView setContentOffset:CGPointMake(with, 0) animated:YES];
    if (with == self.width * 5) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}

//滚动持续中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.isLock) {
        int number = (scrollView.contentOffset.x + MAIN_SCREEN_WIDTH / 2) / MAIN_SCREEN_WIDTH;
        self.pageControl.currentPage = number;
    }
    

}
//将要开始减速  最后一个页面跳转到第一个页面
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    int with = scrollView.contentOffset.x + self.width ;
    if (with > self.width * 5.15) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }

}

//将要开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.isLock = NO;
}

//减速完成(停止)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x / MAIN_SCREEN_WIDTH;
    
}
@end
