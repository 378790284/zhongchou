//
//  FunnyPictureHome.m
//  MyLoL
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

//http://box.dwstatic.com/apiAlbum.php?action=l&albumsTag=jiongTu&p=1&v=117&OSType=iOS8.4&versionName=2.2.7

#import "FunnyPictureHome.h"
#import "NetWorkEngine.h"
#import "CharmingPhotoModel.h"
#import "CustomCharmingCell.h"
#import "WaterFlowLayout.h"
#import "UIViewAdditions.h"
#import "MJRefresh.h"
#import "Define.h"
#import "PhotoDetilController.h"
#import "AppDelegate.h"
#import "MyTabBarController.h"

@interface FunnyPictureHome ()<waterFlowLayoutDelegate>

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UICollectionView *aCollerctionView;

@end

@implementation FunnyPictureHome

- (UICollectionView *)aCollerctionView
{
    if (!_aCollerctionView) {
        WaterFlowLayout *waterFlowLayout = [[WaterFlowLayout alloc]init];
        waterFlowLayout.numberOfColumns = 2;
        waterFlowLayout.itemWidth = (CGRectGetWidth(self.view.bounds) - 15)/ 2;
        waterFlowLayout.delegate =self;
        waterFlowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        self.aCollerctionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:waterFlowLayout];
    }
    return _aCollerctionView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.aCollerctionView.showsVerticalScrollIndicator = NO;
    self.aCollerctionView.backgroundColor = [UIColor whiteColor];
    [self.aCollerctionView registerClass:[CustomCharmingCell class] forCellWithReuseIdentifier:@"cell"];
    self.aCollerctionView.frame = CGRectMake(self.view.left, self.view.top, self.view.width, self.view.height - 49);
    [self.view addSubview:self.aCollerctionView];
    
    self.aCollerctionView.delegate = self;
    self.aCollerctionView.dataSource = self;
    
    [self.aCollerctionView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [self loadNewData];
}

- (void)loadNewData
{
    self.engine = [[NetWorkEngine alloc]init];
    NSString *urlString = [NSString stringWithFormat:@"http://box.dwstatic.com/apiAlbum.php?action=l&albumsTag=jiongTu&p=1&v=117&OSType=iOS8.4&versionName=2.2.7"];
    _engine.delegate = self;
    [_engine get:urlString];
}

//  接口请求成功
- (void)netWorkDidSuccessful:(NSDictionary *)dic
{
//    NSLog(@"%@",dic);
    [self.dataArray removeAllObjects];
    NSArray *data = [dic objectForKey:@"data"];
    //NSLog(@"%@", data);
    
    for (NSDictionary *perDic in data) {
        CharmingPhotoModel *charmingModel = [[CharmingPhotoModel alloc]initWithDictionary:perDic];
        [self.dataArray addObject:charmingModel];
    }
    
    [self.aCollerctionView reloadData];
    [self.aCollerctionView.header endRefreshing];
}

//返回数据个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
//返回cell的类型
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cell";
    CustomCharmingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    if (self.dataArray.count != 0) {
        CharmingPhotoModel *charmingModel = [[CharmingPhotoModel alloc]init];
        charmingModel = (CharmingPhotoModel *)self.dataArray[indexPath.row];
        [cell configCellWithNewsModel:charmingModel];
    }
    cell.layer.borderWidth = 1.0;
    cell.layer.borderColor = RGB_COLOR(155, 155, 155, 0.7).CGColor;
    return cell;
}
//跳转页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    PhotoDetilController *photoVC = [[PhotoDetilController alloc]init];
    CharmingPhotoModel *charmingModel = [[CharmingPhotoModel alloc]init];
    charmingModel = self.dataArray[indexPath.row];
    photoVC.albumId = charmingModel.galleryId;
    
    [app.MyTabVC.viewControllers.firstObject pushViewController:photoVC animated:YES];
}

// 返回高度
- (CGFloat) collectionView:(UICollectionView *)collectionView
           waterFlowLayout:(WaterFlowLayout *) waterFlowLayout
  heightForItemAtIndexPath:(NSIndexPath *) indexPath
{
    CharmingPhotoModel *charmingModel = [[CharmingPhotoModel alloc]init];
    charmingModel = (CharmingPhotoModel *)self.dataArray[indexPath.row];
    CGFloat charmingPhotoHeight = [charmingModel.coverHeight floatValue];
    return (charmingPhotoHeight + 30) / 568 *MAIN_SCREEN_HEIGHT;
}

//  接口请求失败
- (void)netWorkDidFail:(NSError *)error
{
    
}


- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}


@end
