//
//  CharmingPhotoModel.h
//  MyLoL
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharmingPhotoModel : NSObject

@property (nonatomic,strong)NSString *galleryId;
@property (nonatomic,strong)NSString *clicks;
@property (nonatomic,strong)NSString *commentCount;
@property (nonatomic,strong)NSString *coverHeight;
@property (nonatomic,strong)NSString *coverUrl;
@property (nonatomic,strong)NSString *coverWidth;
@property (nonatomic,strong)NSString *created;
@property (nonatomic,strong)NSString *DESCRIPTION;
@property (nonatomic,strong)NSString *destUrl;
@property (nonatomic,strong)NSString *modify_time;
@property (nonatomic,strong)NSString *picsum;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *updated;

- (id)initWithDictionary:(NSDictionary *)Dic;

@end
