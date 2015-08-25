//
//  HomepageInformation.m
//  MyLoL
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "HomepageInformation.h"
#import "NetWorkEngine.h"
#import "HomepageInformationModel.h"
#import "HeadHomePageModel.h"
#import "TitleModel.h"
#import "BottomCell.h"
#import "UIImageView+WebCache.h"
#import "Define.h"
#import "HeaderView.h"
#import "DetilWebContorller.h"
#import "MJRefresh.h"
#import "HelperFiler.h"
#import "AppDelegate.h"
#import "MyTabBarController.h"

@interface HomepageInformation ()

@end

@implementation HomepageInformation

- (void)viewDidLoad {
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
    //NSLog(@"%ld", self.count);
}

- (void)loadWithNewCount:(NSInteger)count
{
    self.engine = [[NetWorkEngine alloc]init];
    NSString *urlString = [NSString stringWithFormat:@"http://box.dwstatic.com/apiNewsList.php?action=c&v=117&OSType=iOS8.4&versionName=2.2.7"];
    NSString *secondUrlString = [NSString stringWithFormat:@"http://box.dwstatic.com/apiNewsList.php?action=l&newsTag=headlineNews&p=%ld&v=117&OSType=iOS8.4&versionName=2.2.7", self.count];
    _engine.delegate = self;
    [_engine get:urlString];
    [_engine secondGet:secondUrlString];
}

- (void)netWorkDidSuccessful:(NSDictionary *)dic
{
    
    for (NSDictionary *titleDic in dic) {
//        NSLog(@"%@", titleDic);
        TitleModel *titleModel = [[TitleModel alloc]initWithDictionary:titleDic];
        [self.titleArray addObject:titleModel];
        //NSLog(@"%@", titleModel.name);
    }
    [self.aTableView reloadData];
}

- (void)SecondNetWorkDidSuccessful:(NSDictionary *)dic
{
//    NSLog(@"%@" , dic);
    if (self.isPullRefresh) {
        [self.dataArray removeAllObjects];
    }
    
    NSArray *cellData = [dic objectForKey:@"data"];
    //NSLog(@"%ld", cellData.count);
    for (NSDictionary *cellDic in cellData) {
        HomepageInformationModel *cellModel = [[HomepageInformationModel alloc]initWithDictonary:cellDic];
        
        if ([cellModel.hasVideo integerValue] == 0){
            [self.dataArray addObject:cellModel];
        }
        
        
        //NSLog(@"%@", cellModel.ID);
    }

    
    NSArray *headerline = [dic objectForKey:@"headerline"];
    
//    NSLog(@"%@", headerline);
    
    if (self.count == 1) {
        // 判断是否为空
        for (NSDictionary *headerDic in headerline) {
            if (headerline == nil) {
                
            }
            else{
                HeadHomePageModel *headerModel = [[HeadHomePageModel alloc]initWithDictionary:headerDic];
                [self.headerArray addObject:headerModel];
                //NSLog(@"%@", headerDic);

            }
        }
        
    }

    [self.aTableView reloadData];
    
    if (cellData.count < 25) {
        self.aTableView.footer.hidden = YES;
    }
    else{
        self.aTableView.footer.hidden = NO;
    }
//    NSLog(@"%ld", self.count);
    
    [self.aTableView.footer endRefreshing];
    [self.aTableView.header endRefreshing];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count + 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //头视图
    if (indexPath.row == 0) {
        static NSString *headerCell = @"header";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headerCell];
        if (!cell) {
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headerCell];
        }
        if (self.titleArray.count != 0) {
            
            HeaderView *headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT / 3)];
            NSMutableArray *hearderUrl = [NSMutableArray arrayWithCapacity:1];
            for (HeadHomePageModel * hearderModel in self.headerArray) {
                [hearderUrl addObject:hearderModel.photo];
            }
            headerView.userInteractionEnabled = YES;
            
            
            if (hearderUrl.count != 0) {
//                NSLog(@"%@", hearderUrl);
                [headerView.firstImage sd_setImageWithURL:hearderUrl[0]];
                headerView.firstImage.tag = 900;
                [headerView.secondImage sd_setImageWithURL:hearderUrl[1]];
                [headerView.thirdImage sd_setImageWithURL:hearderUrl[2]];
                [headerView.fourthImage sd_setImageWithURL:hearderUrl[3]];
                [headerView.fifthImage sd_setImageWithURL:hearderUrl[4]];
                [self createTapGesture:headerView.firstImage];
                [self createTapGesture:headerView.secondImage];
                [self createTapGesture:headerView.thirdImage];
                [self createTapGesture:headerView.fourthImage];
                [self createTapGesture:headerView.fifthImage];
                
            }
            
            
            [cell addSubview:headerView];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.row > 0) {
        static NSString *cellIndentifier = @"cell";
        BottomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (!cell) {
            cell = [[BottomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        if (self.dataArray.count != 0) {
            HomepageInformationModel *homepageModel = self.dataArray[indexPath.row - 1];
            
            if (indexPath.row == 4) {
                [HelperFiler shareHelper].webUrl = [NSString stringWithFormat:@"http://box.dwstatic.com/apiNewsList.php?action=d&newsId=%@&v=117&OSType=iOS8.4&versionName=2.2.7", homepageModel.artId];
            }
            
            cell.HomePageInfoModel = homepageModel;
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
    
}

- (void)createTapGesture:(UIImageView *)aImageView
{
    //创建手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    //轻怕两次
    tapGesture.numberOfTapsRequired = 1;
    [aImageView addGestureRecognizer:tapGesture];
}


- (void)handleTapGesture:(UIGestureRecognizer *)tapGesture
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    HeadHomePageModel *headModel = [[HeadHomePageModel alloc]init];
    headModel = (HeadHomePageModel *)self.headerArray[tapGesture.view.tag - 900];
    DetilWebContorller *detilWebVC = [[DetilWebContorller alloc]init];
    detilWebVC.artId = headModel.artId;
    [app.MyTabVC.viewControllers.firstObject pushViewController:detilWebVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return MAIN_SCREEN_HEIGHT / 3;
    }
    return MAIN_SCREEN_HEIGHT * 0.14;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row > 0) {
        DetilWebContorller *detilVC = [[DetilWebContorller alloc]init];
        HomepageInformationModel *homepageModel = [[HomepageInformationModel alloc]init];
        homepageModel = (HomepageInformationModel *)self.dataArray[indexPath.row - 1];
//        NSLog(@"%@", homepageModel.artId);
        detilVC.artId = homepageModel.artId;
        [app.MyTabVC.viewControllers.firstObject pushViewController:detilVC animated:YES];
    }
    
}

- (void)netWorkDidFail:(NSError *)error
{
    
}

- (NSMutableArray *)titleArray
{
    if (_titleArray == nil) {
        self.titleArray = [[NSMutableArray alloc]init];
    }
    return _titleArray;
}

- (NSMutableArray *)headerArray
{
    if (_headerArray == nil) {
        self.headerArray = [[NSMutableArray alloc]init];
    }
    return _headerArray;
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
