

//
//  DownLoadController.m
//  MyLoL
//
//  Created by lanou3g on 15/7/21.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DownLoadView.h"
#import "AFNetworking.h"
#import "UIViewAdditions.h"
#import "Define.h"
#import "MovieModel.h"
#import "Tramscpde.h"
#import "NetWorkEngine.h"

@interface DownLoadView ()


@property (nonatomic, strong) AFHTTPRequestOperation *operation;


@end

static DownLoadView *shareDownLoadView = nil;

@implementation DownLoadView

+ (DownLoadView *)shareDownLoad
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareDownLoadView = [[DownLoadView alloc]init];
    }) ;
    return shareDownLoadView;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.downLoadButton];
        [self addSubview:self.sliderView];
        [self addSubview:self.progress];
    }
    return self;
}


- (void)loadDataDownName:(NSString *)downName
             downLoadURL:(NSString *)downLoadURL
                  sender:(UIButton *)sender
{
    //进度文件
    NSString *txtTemppath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@Temp/%@.txt",downName,downName] ];
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    if ([fileManger fileExistsAtPath:txtTemppath]) {
        self.sliderView.progress = [[NSString stringWithContentsOfFile:txtTemppath encoding:NSUTF8StringEncoding  error:nil]floatValue];
    }
    else
        _sliderView.progress = 0;
    self.progress.text = [NSString stringWithFormat:@"%.2f%%", _sliderView.progress * 100];
    
    [self startDown:downName downLoadURL:downLoadURL sender:sender];
}
- (void)startDown:(NSString *)downName
      downLoadURL:(NSString *)downLoadURL
           sender:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"下载"]) {
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        //下载地址
        
        NSString *CachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
        NSFileManager * fileManager = [NSFileManager defaultManager];
        NSLog(@"%@", CachePath);
        NSString *folderPath = [CachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", downName]];
        NSString *tempPath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@Temp",downName]];
        
        //判断缓存文件夹和视频存放文件夹是否存在,如果不存在,就创建一个文件夹
        if(![fileManager fileExistsAtPath:folderPath]){
            [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        if (![fileManager fileExistsAtPath:tempPath]) {
            [fileManager createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        NSString *temFilePath = [tempPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.temp",downName ]];// 缓存路径
        NSString *mvFilePath = [folderPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",downName ]]; // 文件保存路径
        NSString *txtFilePath = [tempPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",downName] ]; //保存重启程序下载的进度
        
        
        unsigned long long downloadedBytes = 0;
        
        NSURL *URL = [NSURL URLWithString:downLoadURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        if ([fileManager fileExistsAtPath:temFilePath]) { // 如果存在,说明有缓存文件
            downloadedBytes = [self fileSizeAtPath:temFilePath];// 计算缓存文件的大小
            NSMutableURLRequest *mutableURLRequest = [request mutableCopy];
            NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-", downloadedBytes];
            [mutableURLRequest setValue:requestRange forHTTPHeaderField:@"Range"];
            request = mutableURLRequest;
            NSLog(@"=======断点续传");
        }
        
        if (![fileManager fileExistsAtPath:mvFilePath]){
            [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
            self.operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
            [_operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:temFilePath append:YES]];
            
//            NSLog(@"sadf%@", self.operation);
            __weak typeof (self)myself = self;
            [_operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
                myself.sliderView.progress = ((float)totalBytesRead + downloadedBytes) / (totalBytesExpectedToRead + downloadedBytes);
                
                myself.progress.text = [NSString stringWithFormat:@"%.2f%%", _sliderView.progress *100];
                NSString *progress = [NSString stringWithFormat:@"%.3f", ((float)totalBytesRead + downloadedBytes) / (totalBytesExpectedToRead + downloadedBytes)];
                [progress writeToFile:txtFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }];
            [_operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //把下载完成的文件转移到保存的路径
                [fileManager moveItemAtPath:temFilePath toPath:mvFilePath error:nil];
                // 删除保存进度的txt文档
                [fileManager removeItemAtPath:txtFilePath error:nil];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@", error);
            }];
            [_operation start];
        }
        else{
            
        }
    }
    else
    {
        [sender setTitle:@"下载" forState:UIControlStateNormal];
        NSLog(@"asdf");
        NSLog(@"%@", self.operation);
        [self.operation cancel];
        
        self.operation = nil;
    }
    
}

- (void)dealloc
{
    NSLog(@"%@",self.operation);
    NSLog(@"1");
}

// 计算缓存文件大小的方法
- (unsigned long long)fileSizeAtPath:(NSString *)fileAbsolutePath
{
    signed long long fileSize = 0;
    NSFileManager *fileManger = [NSFileManager new];
    if ([fileManger fileExistsAtPath:fileAbsolutePath]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManger attributesOfItemAtPath:fileAbsolutePath error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    
    return fileSize;
}

- (UILabel *)progress
{
    if (_progress == nil) {
        self.progress = [[UILabel alloc]initWithFrame:CGRectMake(100, 40, 50, 50)];
        _progress.backgroundColor = [UIColor blueColor];
    }
    return _progress;
}

- (UIProgressView *)sliderView
{
    if (_sliderView == nil) {
        self.sliderView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
        _sliderView.backgroundColor = [UIColor cyanColor];
    }
    return _sliderView;
}



//- (UIButton *)downLoadButton
//{
//    if (_downLoadButton == nil) {
//        self.downLoadButton = [UIButton buttonWithType:UIButtonTypeSystem];
//        _downLoadButton.frame = CGRectMake(self.width * 0.75, self.bottom - 40 , 40, 20);
//        [_downLoadButton addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
//        [_downLoadButton setTitle:@"下载" forState:UIControlStateNormal];
//        _downLoadButton.titleLabel.font = FONT(12);
//        _downLoadButton.backgroundColor = [UIColor redColor];
//    }
//    return _downLoadButton;
//}

@end
