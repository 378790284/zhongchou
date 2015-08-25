//
//  CharmingPhotoHome.m
//  MyLoL
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CharmingPhotoHome.h"
#import "BlockEngine.h"
#import "CharmingPhotoModel.h"
#import "CustomCharmingCell.h"
#import "WaterFlowLayout.h"
#import "UIViewAdditions.h"
#import "Define.h"
#import "MJRefresh.h"
#import "PhotoDetilController.h"
#import "AppDelegate.h"
#import "MyTabBarController.h"
@interface CharmingPhotoHome ()<waterFlowLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic,strong)UICollectionView *aCollectionView;

@end

@implementation CharmingPhotoHome

- (UICollectionView *)aCollectionView
{
    if (!_aCollectionView) {
        
        WaterFlowLayout *waterFlowLayout = [[WaterFlowLayout alloc]init];
        waterFlowLayout.numberOfColumns = 2;
        waterFlowLayout.itemWidth = (CGRectGetWidth(self.view.bounds) - 15) / 2;
        waterFlowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        waterFlowLayout.delegate = self;
        self.aCollectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:waterFlowLayout];
    }
    return _aCollectionView;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.aCollectionView.showsVerticalScrollIndicator = NO;
    self.aCollectionView.backgroundColor = [UIColor whiteColor];
    //collectionView必须通过注册的形式注册cell,重用的时候没有可重用的cell,会根据类型创建一个cell
    [self.aCollectionView registerClass:[CustomCharmingCell class] forCellWithReuseIdentifier:@"cell"];
    self.aCollectionView.frame = CGRectMake(self.view.left, self.view.top, self.view.width, self.view.height - 49);
    self.aCollectionView.delegate = self;
    self.aCollectionView.dataSource = self;
    [self.view addSubview:self.aCollectionView];
    
    [self.aCollectionView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [self loadNewData];
}

- (void)loadNewData
{
    __block CharmingPhotoHome *charmingPhoto = self;
    charmingPhoto.engine = [[BlockEngine alloc] initWithSuccessFulBlock:^(NSDictionary *dic) {
        //NSLog(@"%@", dic);
        
        [self.dataArray removeAllObjects];
        
        NSArray *data = [dic objectForKey:@"data"];
        for (NSDictionary *cellDic in data) {
            CharmingPhotoModel *charmingPhotoModel = [[CharmingPhotoModel alloc]initWithDictionary:cellDic];
            [self.dataArray addObject:charmingPhotoModel];
            
//            NSLog(@"%@", charmingPhotoModel.commentCount);
        }
//        NSLog(@"%@",self.dataArray);
        
        //NSLog(@"%ld", self.dataArray.count);
        
        [self.aCollectionView reloadData];
        
    } failBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://box.dwstatic.com/apiAlbum.php?action=l&albumsTag=beautifulWoman&p=1&v=117&OSType=iOS8.4&versionName=2.2.7"];
    [charmingPhoto.engine getString:urlString];
    
    [self.aCollectionView.header endRefreshing];
    
}

//返回数据个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //NSLog(@"ccc%ld", self.dataArray.count);
    return self.dataArray.count;
}

//返回cell的类型
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"1cellForItemAtIndexPath");
    static NSString *cellIdentifier = @"cell";
    CustomCharmingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (self.dataArray.count != 0) {
        CharmingPhotoModel *charmingPhoto = [[CharmingPhotoModel alloc]init];
        charmingPhoto = (CharmingPhotoModel *)self.dataArray[indexPath.row];
        [cell configCellWithNewsModel:charmingPhoto];
    }
    
    //cell.backgroundColor = [UIColor redColor];
    
    cell.layer.borderWidth = 1.0;
    cell.layer.borderColor = RGB_COLOR(155, 155, 155, 0.7).CGColor;
    return cell;
    
    
}

// 跳转页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    PhotoDetilController *photoVC = [[PhotoDetilController alloc]init];
    CharmingPhotoModel *charmingModel = [[CharmingPhotoModel alloc]init];
    charmingModel = self.dataArray[indexPath.row];
    photoVC.albumId = charmingModel.galleryId;
   // NSLog(@"%@", charmingModel.galleryId);
    
    
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
    
    //NSLog(@"%f", charmingPhotoHeight);
    
    return (charmingPhotoHeight + 30) / 568 * MAIN_SCREEN_HEIGHT;
}


- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}




@end
