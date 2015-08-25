//
//  FmdbModel.h
//  MyLoL
//
//  Created by lanou3g on 15/7/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FmdbModel : NSObject


+(FmdbModel *)shareFmdb;

//如果没有数据库创建数据库 并插入数据
- (void)saveMovieTitle:(NSString *)movieTitle
              movieUrl:(NSString *)movieUrl
             movieTime:(NSString *)movieTime
            movieImage:(NSString *)movieImage
           movieUpdate:(NSString *)movieUpDate;

//根据数据标题删除数据库
- (void)deleData:(NSString *)movieTitle;

//获取所有的数据
- (NSArray *)getAll;


//查看数据是否再数据库中 如果存在返回yes  否则返回NO
- (BOOL)backTheDataInOrOut:(NSString *)movieTitle;


@end
