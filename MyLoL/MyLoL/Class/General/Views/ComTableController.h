//
//  ComTableController.h
//  MyLoL
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComTableController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *aTableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger       count;
@property (nonatomic,assign)BOOL            isPullRefresh;

- (void)loadNewData;

- (void)loadMoreData;

- (void)loadWithNewCount:(NSInteger)count;

@end
