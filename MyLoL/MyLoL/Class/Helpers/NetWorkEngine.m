//
//  NetWorkEngine.m
//  MyLoL
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NetWorkEngine.h"
#import "AFNetworking.h"

@interface NetWorkEngine()

@property (nonatomic,strong)NSMutableData *data;
@property (nonatomic,strong)AFHTTPRequestOperationManager *manager;

@end



@implementation NetWorkEngine

#pragma mark - Connection 获取数据

- (void)get:(NSString *)urlString
{
    
    NSString *string = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.manager = [[AFHTTPRequestOperationManager alloc]init];
    NSDictionary *dic = @{@"format":@"json"};
    [_manager GET:string parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        if ([_delegate respondsToSelector:@selector(netWorkDidSuccessful:)]) {
            [_delegate netWorkDidSuccessful:responseObject];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([_delegate respondsToSelector:@selector(netWorkDidFail:)]) {
            [_delegate netWorkDidFail:error];
        }
    }];
}

- (void)secondGet:(NSString *)urlString
{
    NSString *string = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.manager = [[AFHTTPRequestOperationManager alloc]init];
    NSDictionary *dic = @{@"format":@"json"};
    [_manager GET:string parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([_delegate respondsToSelector:@selector(SecondNetWorkDidSuccessful:)]) {
            [_delegate SecondNetWorkDidSuccessful:responseObject];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([_delegate respondsToSelector:@selector(netWorkDidFail:)]) {
            [_delegate netWorkDidFail:error];
        }
    }];

}

- (void)getArray:(NSString *)urlString
{
    NSString *string = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.manager = [[AFHTTPRequestOperationManager alloc]init];
    NSDictionary *dic = @{@"format":@"json"};
    [_manager GET:string parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([_delegate respondsToSelector:@selector(netWorkDidSuccessfulBackArray:)]) {
            [_delegate netWorkDidSuccessfulBackArray:responseObject];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([_delegate respondsToSelector:@selector(netWorkDidFail:)]) {
            [_delegate netWorkDidFail:error];
        }
    }];

}

- (void)post:(NSString *)urlString{
    
}
- (void)cancleNetWorkingRequest
{
    [self.manager.operationQueue cancelAllOperations];
}



@end
