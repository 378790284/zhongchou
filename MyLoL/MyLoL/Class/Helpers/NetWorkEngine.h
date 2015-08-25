//
//  NetWorkEngine.h
//  MyLoL
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetWorkProtrol <NSObject>

//  接口请求失败
- (void)netWorkDidFail:(NSError *)error;

@optional
//  接口请求成功
- (void)netWorkDidSuccessful:(NSDictionary *)dic;
//  第二个请求成功接口
- (void)SecondNetWorkDidSuccessful:(NSDictionary *)dic;
//  请求返回数组的接口
- (void)netWorkDidSuccessfulBackArray:(NSArray *)array;

@end

@interface NetWorkEngine : NSObject

//代理
@property (nonatomic, weak)id<NetWorkProtrol>delegate;
@property (nonatomic, strong)NSURLConnection *connection;

- (void)get:(NSString *)urlString;

- (void)secondGet:(NSString *)urlString;

- (void)getArray:(NSString *)urlString;

- (void)post:(NSString *)urlString;

- (void)cancleNetWorkingRequest;

@end