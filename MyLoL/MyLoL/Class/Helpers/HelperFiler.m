//
//  HelperFiler.m
//  MyLoL
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "HelperFiler.h"

static HelperFiler *helerFiler = nil;

@implementation HelperFiler

+ (HelperFiler *)shareHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helerFiler = [[HelperFiler alloc]init];
    });
    return helerFiler;
}

- (NSArray *)helperArray
{
    if (_helperArray == nil) {
        self.helperArray = [[NSArray alloc]init];
    }
    return _helperArray;
}

@end
