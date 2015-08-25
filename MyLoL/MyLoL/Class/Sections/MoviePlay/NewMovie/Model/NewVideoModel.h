//
//  NewVideoModel.h
//  MyLoL
//
//  Created by lanou3g on 15/7/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewVideoModel : NSObject

@property (nonatomic,strong)NSString *channelId;
@property (nonatomic,strong)NSString *cover_url;
@property (nonatomic,strong)NSString *letv_video_id;
@property (nonatomic,strong)NSString *letv_video_unique;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *totalPage;
@property (nonatomic,strong)NSString *udb;
@property (nonatomic,strong)NSString *upload_time;
@property (nonatomic,strong)NSString *vid;
@property (nonatomic,strong)NSString *video_length;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
