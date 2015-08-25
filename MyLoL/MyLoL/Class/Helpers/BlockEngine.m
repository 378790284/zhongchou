//
//  BlockEngine.m
//  MyLoL
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "BlockEngine.h"
#import "AFNetworking.h"

@implementation BlockEngine

-(id)initWithSuccessFulBlock:(successfulBlock)successfulBlock failBlock:(failBlock)failBlock
{
    if ([super init]) {
        self.successfulBlock = successfulBlock;
        self.failBlock = failBlock;
    }
    return self;
}

- (void)getString:(NSString *)str
{
    NSString *string = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = @{@"format": @"json"};
    self.manager = [AFHTTPRequestOperationManager manager];
    [_manager GET:string parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.successfulBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.failBlock(error);
    }];
}

@end
