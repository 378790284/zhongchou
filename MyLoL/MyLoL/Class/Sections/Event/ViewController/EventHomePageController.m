//
//  EventHomePageController.m
//  MyLoL
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "EventHomePageController.h"
#import "NetWorkEngine.h"
#import "HomepageInformationModel.h"
#import "MJRefresh.h"
#import "BottomCell.h"
#import "UIImageView+WebCache.h"
#import "Define.h"
#import "DetilWebContorller.h"
#import "TopicViewController.h"

#import "AppDelegate.h"
#import "MyTabBarController.h"

@implementation EventHomePageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadNewData];
}

- (void)loadNewData
{
    self.count = 1;
    self.isPullRefresh = YES;
    [self loadWithNewCount:self.count];
}

- (void)loadMoreData
{
    self.isPullRefresh = NO;
    [self loadWithNewCount:++self.count];
}

- (void)loadWithNewCount:(NSInteger)count
{
    self.engine = [[NetWorkEngine alloc]init];
    NSString *urlString = [NSString stringWithFormat:@"http://box.dwstatic.com/apiNewsList.php?action=l&newsTag=upgradenews&p=%ld&v=117&OSType=iOS8.4&versionName=2.2.7" , self.count];
    self.engine.delegate = self;
    [self.engine get:urlString];
}

- (void)netWorkDidSuccessful:(NSDictionary *)dic
{
    if (self.isPullRefresh) {
        [self.dataArray removeAllObjects];
    }
    NSArray *cellData = [dic objectForKey:@"data"];
    //NSLog(@"%@", cellData);
    
    for (NSDictionary *cellDic in cellData) {
        HomepageInformationModel *cellModel = [[HomepageInformationModel alloc]initWithDictonary:cellDic];
        if ([cellModel.hasVideo integerValue] == 0) {
            [self.dataArray addObject:cellModel];
        }
    }
    
    [self.aTableView reloadData];
    if (cellData.count < 25) {
        self.aTableView.footer.hidden = YES;
    }
    else{
        self.aTableView.footer.hidden = NO;
    }

    [self.aTableView.footer endRefreshing];
    [self.aTableView.header endRefreshing];
}

//  接口请求失败
- (void)netWorkDidFail:(NSError *)error
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.dataArray.count != 0) {
        HomepageInformationModel *homepageModel = self.dataArray[indexPath.row];
        
        static NSString *cellIndentifier = @"cell";
        if ([homepageModel.type isEqualToString:@"topic"]) {
            
            static NSString *topicCell = @"topic";
            BottomCell *topicC = [tableView dequeueReusableCellWithIdentifier:topicCell];
            if (!topicC) {
                topicC = [[BottomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topicCell];
            }
            
            topicC.HomePageInfoModel = homepageModel;
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 30, 15)];
            label.text = [NSString stringWithFormat:@"专题"];
            label.backgroundColor = [UIColor redColor];
            label.font = FONT(12);
            [topicC addSubview: label];
            topicC.selectionStyle = UITableViewCellSelectionStyleNone;
            return topicC;
        }

        BottomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (!cell) {
            cell = [[BottomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        cell.HomePageInfoModel = homepageModel;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MAIN_SCREEN_HEIGHT * 0.14;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HomepageInformationModel *homePageModel = [[HomepageInformationModel alloc]init];
    homePageModel = (HomepageInformationModel *)self.dataArray[indexPath.row];
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    if ([homePageModel.type isEqualToString:@"topic"]) {
        TopicViewController *topicVC = [[TopicViewController alloc]init];
        topicVC.subjectId = homePageModel.subjectId;
        [app.MyTabVC.viewControllers.firstObject pushViewController:topicVC animated:YES];
        //NSLog(@"1");
    }
    if ([homePageModel.type isEqualToString:@"news"]) {
        DetilWebContorller *detilVC = [[DetilWebContorller alloc]init];
        detilVC.artId = homePageModel.artId;
        [app.MyTabVC.viewControllers.firstObject pushViewController:detilVC animated:YES];
    }
    
    
    
}

@end
