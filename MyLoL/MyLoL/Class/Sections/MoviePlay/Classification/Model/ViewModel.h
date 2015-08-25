//
//  ViewModel.h
//  MyLoL
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewModel : NSObject

@property (nonatomic,strong)NSString *dailyUpdate;
@property (nonatomic,strong)NSString *icon;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *tag;

- (id)initWithDiction:(NSDictionary *)dic;

@end
