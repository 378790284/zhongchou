//
//  NewVideoController.m
//  MyLoL
//
//  Created by lanou3g on 15/7/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

//http://box.dwstatic.com/apiVideoesNormalDuowan.php?tag=newest&p=1&v=117&OSType=iOS8.4&src=letv&action=l

#import "NewVideoController.h"
#import "Define.h"
#import "UIViewAdditions.h"
#import "NewVideoModel.h"
#import "NewVideoCell.h"
#import "DownLoadTable.h"
#import "MovieModel.h"
#import "Tramscpde.h"
#import "FmdbModel.h"
#import "HouMoviePlayerViewController.h"

@interface NewVideoController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *aTableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *nameArray;
@property (nonatomic,strong)NSMutableArray *downArray;
@property (nonatomic,strong)NSString *newstTag;


@end


@implementation NewVideoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.newstTag = @"newest";
    if (self.pushTag != nil) {
        self.newstTag = self.pushTag;
    }
    
    [self loadNewData];
    [self loadRightTaBar];
    [self.view addSubview:self.aTableView];
}

#pragma mark -- 下载页面按钮
- (void)loadRightTaBar
{
    //下载页面的跳转
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下载" style:UIBarButtonItemStyleDone target:self action:@selector(push)];
}
#pragma mark -- 下载页面跳转
- (void)push
{
    NSLog(@"点击下载");
    DownLoadTable *downLoadTable = [[DownLoadTable alloc]init];
    [self.navigationController pushViewController:downLoadTable animated:YES];
}

#pragma mark -- 数据请求
- (void)loadNewData
{
    [self.dataArray removeAllObjects];
    __block NewVideoController *newVideoVC = self;
    
    newVideoVC.blockEngine = [[BlockEngine alloc]initWithSuccessFulBlock:^(NSDictionary *dic) {
        //NSLog(@"%@", dic);
        
        //下载地址
        for (NSDictionary *cellDic in dic) {
            NewVideoModel *newVideoModel = [[NewVideoModel alloc]initWithDictionary:cellDic];
            [self.dataArray addObject:newVideoModel];
            
            }
        
        [self.aTableView reloadData];
        
        
    } failBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    NSString *urlString = [NSString stringWithFormat:@"http://box.dwstatic.com/apiVideoesNormalDuowan.php?tag=%@&p=1&v=117&OSType=iOS8.4&src=letv&action=l", self.newstTag];
    [newVideoVC.blockEngine getString:urlString];
    
    [self.aTableView reloadData];
    
}

#pragma mark -- 视频播放的数据请求和模态跳转
- (void)loadInData:(NSString *)vid
             title:(NSString *)title{
    
    __block NewVideoController *newVC = self;
    newVC.inEngine = [[BlockEngine alloc]initWithSuccessFulBlock:^(NSDictionary *dic) {
        //NSLog(@"%@", dic);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //    NSLog(@"%@", dic);
            NSDictionary *reslut = [dic objectForKey:@"result"];
            //    NSLog(@"%@", reslut);
            NSDictionary *items = [reslut objectForKey:@"items"];
            //    NSLog(@"qqq%@", items);
            NSDictionary *firstMovie = [items objectForKey:@"1000"];
            //    NSLog(@"%@", firstMovie);
            
            
            MovieModel *movieModel = [[MovieModel alloc]initWithDictionary:firstMovie];
            //    NSLog(@"%@", movieModel.tramscpdeDic.urls);
            NSString *urlInString = movieModel.tramscpdeDic.urls.firstObject;
            
            
            //完事之后回到主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                HouMoviePlayerViewController *houPlay = [[HouMoviePlayerViewController alloc]init];
                houPlay.movieURL = [NSURL URLWithString:urlInString];
                houPlay.titleName = title;
                [self presentViewController:houPlay animated:YES completion:^{
                    houPlay.movieModel = movieModel;
                }];
            });
            
        });

    } failBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://box.dwstatic.com/apiVideoesNormalDuowan.php?action=f&vid=%@", vid];
    [newVC.inEngine getString:urlString];
    
}

#pragma mark -- 返回单元个个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

#pragma mark -- cell的定义 和重用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIndentifier = @"cell";
    NewVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[NewVideoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    if (self.dataArray.count != 0 ) {
        NewVideoModel *newVideoModel = [[NewVideoModel alloc]init];
        
        newVideoModel = (NewVideoModel *)self.dataArray[indexPath.row];
        //NSLog(@"%@", self.nameArray);
        [cell confingNewvideo:newVideoModel];
        
        cell.collectButton.tag = 1000 + indexPath.row;
        //NSLog(@"%ld",cell.downLoadButton.tag);
        [cell.collectButton addTarget:self action:@selector(downLoadAction:) forControlEvents:UIControlEventTouchUpInside];
        if (![[FmdbModel shareFmdb]backTheDataInOrOut:newVideoModel.title]) {
            //如果数据库中不存在
            [cell.collectButton setTitle:@"收藏" forState:UIControlStateNormal];
        }
        else
        {
            [cell.collectButton setTitle:@"已收藏" forState:UIControlStateNormal];
        }
        
    }
    
    return cell;
}
#pragma mark -- 单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MAIN_SCREEN_HEIGHT / 7;
}
#pragma mark -- 单元格点击跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewVideoModel *newVideoModel = [[NewVideoModel alloc]init];
    newVideoModel = (NewVideoModel *)self.dataArray[indexPath.row];
    [self loadInData: newVideoModel.vid title:newVideoModel.title];
}

- (void)downLoadAction:(UIButton *)sender
{
    NewVideoModel *newVideiModel = [[NewVideoModel alloc]init];
    newVideiModel = (NewVideoModel *)self.dataArray[sender.tag - 1000];
    NSString *vid = [NSString stringWithFormat:@"%@", newVideiModel.vid];
    NSString *urlString = [NSString stringWithFormat:@"http://box.dwstatic.com/apiVideoesNormalDuowan.php?action=f&vid=%@", vid];
    
    
    
    NSLog(@"%ld",sender.tag);
    __block NewVideoController *newDownVC = self;
    newDownVC.downEngine = [[BlockEngine alloc]initWithSuccessFulBlock:^(NSDictionary *dic) {
        //NSLog(@"%@", dic);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //    NSLog(@"%@", dic);
            NSDictionary *reslut = [dic objectForKey:@"result"];
            //    NSLog(@"%@", reslut);
            NSDictionary *items = [reslut objectForKey:@"items"];
            //    NSLog(@"qqq%@", items);
            NSDictionary *firstMovie = [items objectForKey:@"1000"];
            //    NSLog(@"%@", firstMovie);
            MovieModel *movieModel = [[MovieModel alloc]initWithDictionary:firstMovie];
            //    NSLog(@"%@", movieModel.tramscpdeDic.urls);
            NSString *urlInString = movieModel.tramscpdeDic.urls.firstObject;
            //视频保存名字
            //NSString *urlName = movieModel.tramscpdeDic.video_name;
            
            //完事之后回到主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //NewVideoCell *cell = [[NewVideoCell alloc]init];
                
                if([sender.currentTitle isEqualToString:@"收藏"])
                {
                    [[FmdbModel shareFmdb]saveMovieTitle:newVideiModel.title movieUrl:urlInString movieTime:newVideiModel.video_length movieImage:newVideiModel.cover_url movieUpdate:newVideiModel.upload_time];
                    [sender setTitle:@"已收藏" forState:UIControlStateNormal];
                }
                else
                {
                    [[FmdbModel shareFmdb]deleData:newVideiModel.title];
                    [sender setTitle:@"收藏" forState:UIControlStateNormal];
                }
                
                //下载
                //[cell getDownName:urlName downUrlString:urlInString sender:sender];
                
            });
            
        });
        
    } failBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
   [newDownVC.downEngine getString:urlString];
}

- (UITableView *)aTableView
{
    if (_aTableView == nil) {
        self.aTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.left, self.view.top, self.view.width, self.view.height)];
        self.aTableView.backgroundColor = [UIColor whiteColor];
        self.aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _aTableView.delegate = self;
        _aTableView.dataSource = self;
    }
    return _aTableView;
}

- (NSMutableArray *)nameArray
{
    if (_nameArray == nil) {
        self.nameArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _nameArray;
}

- (NSMutableArray *)downArray
{
    if (_downArray == nil) {
        self.downArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _downArray;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

@end
