//
//  MovieModel.h
//  MyLoL
//
//  Created by lanou3g on 15/7/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Tramscpde;
@interface MovieModel : NSObject

@property (nonatomic,strong)NSString  *definition;
@property (nonatomic,strong)NSString  *transcode_id;
@property (nonatomic,strong)NSString  *vid;
@property (nonatomic,strong)NSString  *video_name;

@property (nonatomic,strong)Tramscpde *tramscpdeDic;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
