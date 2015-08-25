//
//  MovieModel.m
//  MyLoL
//
//  Created by lanou3g on 15/7/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MovieModel.h"
#import "Tramscpde.h"
@implementation MovieModel

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        //NSLog(@"%@", [dic objectForKey:@"transcode"]);
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    NSLog(@"%@", key);
//    NSLog(@"sdfasdf%@", value);
    if ([key isEqualToString:@"transcode"]) {
//        NSLog(@"1");
        self.tramscpdeDic = [[Tramscpde alloc]initWithDictionary:value];
    }
}

@end
