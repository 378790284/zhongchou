//
//  PhotoDetilController.m
//  MyLoL
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//


//http://box.dwstatic.com/apiAlbum.php?action=d&albumId=106655&v=117&OSType=iOS8.4&versionName=2.2.7

#import "PhotoDetilController.h"
#import "NetWorkEngine.h"
#import "PhotoModel.h"
#import "Define.h"
#import "UIImageView+WebCache.h"
#import "UIViewAdditions.h"

@interface PhotoDetilController ()

@property (nonatomic,strong)UIScrollView *aScrollView;
@property (nonatomic,strong)NSString *picsum;
@property (nonatomic,strong)NSString *pictures;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation PhotoDetilController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(0, 64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT - 108);
    [self loadNewData];
    
}

- (void)loadNewData
{
    self.engine = [[NetWorkEngine alloc]init];
    NSString *urlString = [NSString stringWithFormat:@"http://box.dwstatic.com/apiAlbum.php?action=d&albumId=%@&v=117&OSType=iOS8.4&versionName=2.2.7" , self.albumId];
    self.engine.delegate = self;
    [_engine get:urlString];
}

- (void)netWorkDidSuccessful:(NSDictionary *)dic
{
//    NSLog(@"%@",dic);
    
    self.picsum = [dic objectForKey:@"picsum"];
    NSArray *pictures = [dic objectForKey:@"pictures"];
//    NSLog(@"%@", pictures);
    for (NSDictionary *perPictures in pictures) {
        PhotoModel *photoModel = [[PhotoModel alloc]initWithDictionary:perPictures];
        [self.dataArray addObject:photoModel];
    }
   // NSLog(@" dfas %@", self.dataArray);
    dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"数据请求完成");
            [self createScrollView];
    });
    
    
}

- (void)createScrollView
{
    
//    NSLog(@"123");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"%@", photoModel.coverUrl);
        
        for (int i = 0; i < self.dataArray.count; i++) {
            PhotoModel *photoModel = [[PhotoModel alloc]init];
            photoModel = (PhotoModel *)self.dataArray[i];
            //设置图片高度
            CGFloat photoHeight = ([photoModel.fileHeight floatValue] / [photoModel.fileWidth floatValue] * MAIN_SCREEN_WIDTH);
            //创建UIImageView
            UIImageView *aImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (MAIN_SCREEN_HEIGHT - photoHeight) / 2, MAIN_SCREEN_WIDTH ,  photoHeight)];
            //加载图片
            [aImageView sd_setImageWithURL:(NSURL *)photoModel.source];
            //创建单个scrollow
            UIScrollView *perScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(i * MAIN_SCREEN_WIDTH  , 0, self.view.width , self.view.height )];
            //打开图片交互
            aImageView.userInteractionEnabled = YES;
            
            aImageView.tag = 100 + i;
            
            //保存照片到相册
//            UIImageWriteToSavedPhotosAlbum(aImageView.image, self, nil, nil);
            
            //创建手势
//            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
//            //添加手势
//            [aImageView addGestureRecognizer:tapGesture];
//            //轻怕两次
//            tapGesture.numberOfTapsRequired = 2;
//
            [perScrollView addSubview:aImageView];
            //NSLog(@"%f", aImageView.size.height);
            
            perScrollView.delegate = self;
            
            [self.aScrollView addSubview:perScrollView];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.view addSubview:self.aScrollView];
        });
        
    });

    
}

//大的ScorllView
- (UIScrollView *)aScrollView
{
    if (_aScrollView == nil) {
        self.aScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _aScrollView.backgroundColor = [UIColor blackColor];
        _aScrollView.contentSize = CGSizeMake(MAIN_SCREEN_WIDTH * [self.picsum integerValue], 504);
        _aScrollView.pagingEnabled = YES;
        _aScrollView.delegate = self;
        _aScrollView.showsHorizontalScrollIndicator = NO;
        _aScrollView.showsVerticalScrollIndicator = NO;
    }
    return _aScrollView;
}

//手势方法
//- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture
//{
////    PhotoModel *photoModel = [[PhotoModel alloc]init];
////    photoModel = (PhotoModel *)self.dataArray[tapGesture.view.tag - 100];
////    CGFloat nowWidth  = [photoModel.fileWidth floatValue];
////    CGFloat nowHeight = [photoModel.fileHeight floatValue];
////    NSLog(@"width = %f , heigth = %f",nowWidth, nowHeight);
////    tapGesture.view.frame = CGRectMake(0, 0, nowWidth, nowHeight);
//    
//    
//}

// 检查是否保存成功
//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
//    if (error != NULL) {
//        [SVProgressHUD showErrorWithStatus:@"保存失败!!!"];
//    }else {
//        [SVProgressHUD showSuccessWithStatus:@"保存成功!!!"];
//    }
//    [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:2];
//}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}


//系统自带返回主线程刷新
//    [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:YES];

//- (void)updateUI
//{
//    NSLog(@"sdf");
//}

//  接口请求失败
- (void)netWorkDidFail:(NSError *)error
{
    
}

@end
