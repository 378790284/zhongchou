//
//  TopicModel.h
//  MyLoL
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicModel : NSObject

@property (nonatomic,strong)NSString *commentSum;
@property (nonatomic,strong)NSString *commentUrl;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *destUrl;
@property (nonatomic,strong)NSString *hasVideo;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *photo;
@property (nonatomic,strong)NSString *time;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *type;

- (id)initWithDictionary:(NSDictionary *)Dic;


@end
