//
//  DetilWebContorller.m
//  MyLoL
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DetilWebContorller.h"
#import "BlockEngine.h"
#import "Define.h"
#import "HelperFiler.h"


@implementation DetilWebContorller

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadNewData];
}

- (void)loadNewData
{
    __block DetilWebContorller * detilVC = self;
    detilVC.engine = [[BlockEngine alloc]initWithSuccessFulBlock:^(NSDictionary *dic) {
//        NSLog(@"%@", dic);
        NSDictionary *data = [dic objectForKey:@"data"];
        NSString *urlString = [data objectForKey:@"content"];
        [self configWebView:urlString];
        //NSLog(@"%@", urlString);
    } failBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    NSString * urlString = [NSString stringWithFormat:@"http://box.dwstatic.com/apiNewsList.php?action=d&newsId=%@&v=117&OSType=iOS8.4&versionName=2.2.7", _artId];
    [detilVC.engine getString:urlString];
    
}


- (NSInteger)configWebView:(NSString *)urlString
{
    //NSLog(@"%@",urlString);
    
    NSArray *stringArray = [[NSArray alloc]init];
//    NSString *appendingString = nil;
    if ([urlString containsString:@"<a class=\"play\""]) {
        urlString = [HelperFiler shareHelper].webUrl;
        [self configVideoView:urlString];
        return 1;
    }
    stringArray = [urlString componentsSeparatedByString:@"</article><div class=\"u-comment\">"];
    NSString * appendingString = [NSString stringWithFormat:@"%@</div><footer></footer></body></html>", stringArray[0]];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT - 108)];
    [webView loadHTMLString:appendingString baseURL:nil];
    [self.view addSubview:webView];
    //NSLog(@"2");
    return 0;
}

//处理  视频的Scrollow  用row的第四页;
- (void)configVideoView:(NSString *)urlString
{
    __block DetilWebContorller * detilVC = self;
    detilVC.engine = [[BlockEngine alloc]initWithSuccessFulBlock:^(NSDictionary *dic) {
        //        NSLog(@"%@", dic);
        NSDictionary *data = [dic objectForKey:@"data"];
        NSString *urlString = [data objectForKey:@"content"];
        [self configWebView:urlString];
        //NSLog(@"%@", urlString);
    } failBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    [detilVC.engine getString:urlString];
}



@end
