//
//  BlockEngine.h
//  MyLoL
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^successfulBlock)(NSDictionary *dic);
typedef void (^failBlock)(NSError *error);
@class AFHTTPRequestOperationManager;

@interface BlockEngine : NSObject

@property(nonatomic,copy)successfulBlock successfulBlock;
@property(nonatomic,copy)failBlock failBlock;

@property (nonatomic,strong)AFHTTPRequestOperationManager *manager;

- (void)getString:(NSString *)str;

- (id)initWithSuccessFulBlock:(successfulBlock)successfulBlock
                    failBlock:(failBlock)failBlock;

@end
