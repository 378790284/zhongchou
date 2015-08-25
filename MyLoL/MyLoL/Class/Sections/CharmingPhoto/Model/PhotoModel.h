//
//  PhotoModel.h
//  MyLoL
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoModel : NSObject

@property (nonatomic,strong)NSString *cai;
@property (nonatomic,strong)NSString *coverUrl;
@property (nonatomic,strong)NSString *ding;
@property (nonatomic,strong)NSString *fileHeight;
@property (nonatomic,strong)NSString *fileUrl;
@property (nonatomic,strong)NSString *fileWidth;
@property (nonatomic,strong)NSString *old;
@property (nonatomic,strong)NSString *picDesc;
@property (nonatomic,strong)NSString *source;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *url;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
