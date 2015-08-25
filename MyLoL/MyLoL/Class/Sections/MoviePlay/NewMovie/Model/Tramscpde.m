//
//  Tramscpde.m
//  MyLoL
//
//  Created by lanou3g on 15/7/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "Tramscpde.h"

@implementation Tramscpde

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    if ([key isEqualToString:@"urls"]) {
//        self.urlString = [NSString stringWithFormat:@"%@", ((NSArray *)value).firstObject];
//    }
}


@end
