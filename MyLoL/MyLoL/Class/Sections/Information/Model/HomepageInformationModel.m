//
//  HomepageInformationModel.m
//  MyLoL
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "HomepageInformationModel.h"

@implementation HomepageInformationModel

- (id)initWithDictonary:(NSDictionary *)Dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:Dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"]){
        self.ID = value;
    }
    
}




@end
