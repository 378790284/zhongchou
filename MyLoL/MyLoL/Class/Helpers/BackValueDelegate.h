//
//  BackValueDelegate.h
//  MyLoL
//
//  Created by lanou3g on 15/7/22.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol backValueProtrol <NSObject>

- (void)backValueSuccessful:(NSString *)value;

@end


@interface BackValueDelegate : NSObject

@property (nonatomic, strong)id<backValueProtrol>delegate;


@end
