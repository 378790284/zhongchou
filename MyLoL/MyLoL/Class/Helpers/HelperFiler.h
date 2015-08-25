//
//  HelperFiler.h
//  MyLoL
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HelperFiler : NSObject

+ (HelperFiler *)shareHelper;
@property (nonatomic, strong)NSArray *helperArray;

@property (nonatomic, strong)NSString *webUrl;

@end
