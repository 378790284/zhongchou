//
//  WallPaperController.m
//  MyLoL
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "WallPaperController.h"
#import "NetWorkEngine.h"
#import "CharmingPhotoModel.h"
#import "CustomCharmingCell.h"
#import "WallPaperController.h"
#import "UIViewAdditions.h"
#import "MJRefresh.h"
#import "Define.h"
#import "PhotoDetilController.h"
#import "WaterFlowLayout.h"
#import "AppDelegate.h"
#import "MyTabBarController.h"

//http://box.dwstatic.com/apiAlbum.php?action=l&albumsTag=wallpaper&p=1&v=117&OSType=iOS8.4&versionName=2.2.7

@interface WallPaperController ()<waterFlowLayoutDelegate>

@property (nonatomic,strong)UICollectionView *aCollerctionView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation WallPaperController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.aCollerctionView.showsVerticalScrollIndicator = NO;
    self.aCollerctionView.backgroundColor = [UIColor whiteColor];
    [self.aCollerctionView registerClass:[CustomCharmingCell class] forCellWithReuseIdentifier:@"cell"];
    self.aCollerctionView.frame = CGRectMake(self.view.left, self.view.top, self.view.width, self.view.height - 49);
    self.aCollerctionView.delegate = self;
    self.aCollerctionView.dataSource = self;
    [self.view addSubview:self.aCollerctionView];
    
    [self.aCollerctionView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [self loadNewData];
}

- (UICollectionView *)aCollerctionView
{
    if (_aCollerctionView == nil) {
        WaterFlowLayout *waterFlowLayout = [[WaterFlowLayout alloc]init];
        waterFlowLayout.numberOfColumns = 2;
        waterFlowLayout.itemWidth = (CGRectGetWidth(self.view.bounds)- 15) /2;
        waterFlowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        waterFlowLayout.delegate = self;
        self.aCollerctionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:waterFlowLayout];

    }
    return _aCollerctionView;
}

- (void)loadNewData
{
    self.engine = [[NetWorkEngine alloc]init];
    NSString *urlString = [NSString stringWithFormat:@"http://box.dwstatic.com/apiAlbum.php?action=l&albumsTag=wallpaper&p=1&v=117&OSType=iOS8.4&versionName=2.2.7"];
    _engine.delegate = self;
    [_engine get:urlString];
}

//  接口请求成功
- (void)netWorkDidSuccessful:(NSDictionary *)dic
{
//    NSLog(@"%@",dic);
    [self.dataArray removeAllObjects];
    NSArray *data = [dic objectForKey:@"data"];
//    NSLog(@"%@", data);
    for (NSDictionary *cellDic in data) {
        CharmingPhotoModel *charmingPhotoModel = [[CharmingPhotoModel alloc]initWithDictionary:cellDic];
        [self.dataArray addObject:charmingPhotoModel];
    }
    
    [self.aCollerctionView reloadData];
    
    [self.aCollerctionView.header endRefreshing];
}

//返回数据个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

///返回cell的类型
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    CustomCharmingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (self.dataArray.count != 0) {
        CharmingPhotoModel *charmingPhoto = [[CharmingPhotoModel alloc]init];
        charmingPhoto = (CharmingPhotoModel *)self.dataArray[indexPath.row];
        [cell configCellWithNewsModel:charmingPhoto];
    }
    cell.layer.borderWidth = 1.0;
    cell.layer.borderColor = RGB_COLOR(155, 155, 155, 0.7).CGColor;
    return cell;
}
//跳转
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    PhotoDetilController *photoVC = [[PhotoDetilController alloc]init];
    CharmingPhotoModel *charmingModel = [[CharmingPhotoModel alloc]init];
    charmingModel = self.dataArray[indexPath.row];
    photoVC.albumId = charmingModel.galleryId;
    [app.MyTabVC.viewControllers.firstObject pushViewController:photoVC animated:YES];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView waterFlowLayout:(WaterFlowLayout *)waterFlowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath
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
        self.dataArray = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _dataArray;
}

@end
