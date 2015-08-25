//
//  TitleModel.h
//  MyLoL
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TitleModel : NSObject

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *tag;
@property (nonatomic,strong)NSString *type;

- (id)initWithDictionary:(NSDictionary *)dic;


@end
