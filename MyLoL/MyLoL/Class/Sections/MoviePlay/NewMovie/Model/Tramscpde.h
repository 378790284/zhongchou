//
//  Tramscpde.h
//  MyLoL
//
//  Created by lanou3g on 15/7/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tramscpde : NSObject

@property (nonatomic,strong)NSString *duration;
@property (nonatomic,strong)NSString *height;
@property (nonatomic,strong)NSString *path;
@property (nonatomic,strong)NSString *size;
@property (nonatomic,strong)NSArray  *urls;
@property (nonatomic,strong)NSString *video_name;
@property (nonatomic,strong)NSString *width;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
