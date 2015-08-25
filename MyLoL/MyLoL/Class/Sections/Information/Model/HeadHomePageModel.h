//
//  HeadHomePageModel.h
//  MyLoL
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeadHomePageModel : NSObject

@property (nonatomic,strong)NSString *artId;
@property (nonatomic,strong)NSString *commentSum;
@property (nonatomic,strong)NSString *commentUrl;
@property (nonatomic,strong)NSString *destUrl;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *photo;
@property (nonatomic,strong)NSString *weight;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
