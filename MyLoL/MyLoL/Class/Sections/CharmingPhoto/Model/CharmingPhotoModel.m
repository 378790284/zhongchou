//
//  CharmingPhotoModel.m
//  MyLoL
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CharmingPhotoModel.h"

@implementation CharmingPhotoModel

- (id)initWithDictionary:(NSDictionary *)Dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:Dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        self.DESCRIPTION = value;
    }
}



@end
