//
//  TopicViewController.m
//  MyLoL
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "TopicViewController.h"
#import "BlockEngine.h"
#import "TopicModel.h"
#import "BottomCell.h"
#import "UIImageView+WebCache.h"
#import "Define.h"
#import "MJRefresh.h"
#import "DetilWebContorller.h"
#import "AppDelegate.h"
#import "MyTabBarController.h"

@implementation TopicViewController

//http://box.dwstatic.com/apiNewsList.php?topicId=69&OSType=iOS8.4&v=117&action=topic

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadNewData];
}

- (void)loadNewData
{
    
    [self.dataArray removeAllObjects];
    __block TopicViewController *topicVC = self;
    topicVC.engine = [[BlockEngine alloc]initWithSuccessFulBlock:^(NSDictionary *dic) {
        NSArray *dataArray = [dic objectForKey:@"data"];
        NSDictionary *dataDic = [[dataArray firstObject] objectForKey: @"data"];
        NSArray *newsArray = [dataDic objectForKey:@"news"];
        
        for (NSDictionary *celldata in newsArray) {
            TopicModel *topicModel = [[TopicModel alloc]initWithDictionary:celldata];
            if ([topicModel.type isEqualToString:@"news"]) {
                [self.dataArray addObject:topicModel];
            }
        }
        [self.aTableView reloadData];
//        NSLog(@"%@", newsArray);
    } failBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://box.dwstatic.com/apiNewsList.php?topicId=%@&OSType=iOS8.4&v=117&action=topic", _subjectId];
    [topicVC.engine getString:urlString];
    
    [self.aTableView reloadData];
    
    [self.aTableView.footer endRefreshing];
    [self.aTableView.header endRefreshing];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cell";
    BottomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[BottomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    if (self.dataArray.count != 0) {
        TopicModel *topicModel = self.dataArray[indexPath.row];
        [cell.cellImage sd_setImageWithURL:(NSURL *)topicModel.photo];
        cell.titleLabel.text = topicModel.title;
        cell.contontLabel.text = topicModel.content;

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MAIN_SCREEN_HEIGHT * 0.14;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    DetilWebContorller *detilVC = [[DetilWebContorller alloc]init];
    TopicModel *topicModel = [[TopicModel alloc]init];
    topicModel = (TopicModel *)self.dataArray[indexPath.row];
    detilVC.artId = topicModel.ID;
    [app.MyTabVC.viewControllers.firstObject pushViewController:detilVC animated:YES];
    
}


@end
