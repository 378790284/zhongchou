

//
//  FmdbModel.m
//  MyLoL
//
//  Created by lanou3g on 15/7/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "FmdbModel.h"
#import "FMDatabase.h"

@implementation FmdbModel

+(FmdbModel *)shareFmdb
{
    static FmdbModel *model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[FmdbModel alloc]init];
    });
    return model;
}

- (NSString *)dataFilePath
{
    NSString *cahesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
//    NSLog(@"%@", cahesPath);
    return [cahesPath stringByAppendingPathComponent:@"CollectDataBase.sqlite"];
}

//如果没有数据库创建数据库 并插入数据
- (void)saveMovieTitle:(NSString *)movieTitle
              movieUrl:(NSString *)movieUrl
             movieTime:(NSString *)movieTime
            movieImage:(NSString *)movieImage
           movieUpdate:(NSString *)movieUpDate
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    FMDatabase *fmdb = [FMDatabase databaseWithPath:[self dataFilePath]];
    if (![fileManager fileExistsAtPath:[self dataFilePath]]) {
        if ([fmdb open]) {
            BOOL res = [fmdb executeUpdate:@"create table if not exists CollectModel(movieTitle text,movieUrl text,movieTime text,movieImage text,movieUpDate text)"];
            if (res) {
                NSLog(@"数据库创建成功");
            }
            else
            {
                NSLog(@"数据库已创建,或者数据库创建失败");
            }
        }
        [fmdb close];
    }
    
    [fmdb open];
    BOOL res = [fmdb executeUpdate:@"insert into CollectModel (movieTitle,movieUrl,movieTime,movieImage,movieUpDate) values(?,?,?,?,?)", movieTitle,movieUrl,movieTime,movieImage,movieUpDate];
    if (res) {
        NSLog(@"插入数据成功");
    }
    else{
        NSLog(@"插入数据失败");
    }
    [fmdb close];
}

//根据数据标题删除数据库
- (void)deleData:(NSString *)movieTitle
{
    FMDatabase *fmdb = [FMDatabase databaseWithPath:[self dataFilePath]];
    [fmdb open];
    BOOL res = [fmdb executeUpdate:@"delete from CollectModel where movieTitle = (?)", movieTitle];
    if (res) {
        NSLog(@"删除数据成功%@", movieTitle);
    }
    else
    {
        NSLog(@"删除失败");
    }
    [fmdb close];
}

//获取所有的数据
- (NSArray *)getAll
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    NSFileManager *fileManger = [NSFileManager defaultManager];
    if ([fileManger fileExistsAtPath:[self dataFilePath]]) {
        FMDatabase *fmdb = [FMDatabase databaseWithPath:[self dataFilePath]];
        if ([fmdb open]) {
            FMResultSet *set = [fmdb executeQuery:@"select *from CollectModel"];
            while ([set next]) {
                // 创建字典来保存信息
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
                NSString *movieTitle = [set stringForColumn:@"movieTitle"];
                NSString *movieUrl   = [set stringForColumn:@"movieUrl"];
                NSString *movieTime  = [set stringForColumn:@"movieTime"];
                NSString *movieImage = [set stringForColumn:@"movieImage"];
                NSString *movieUpDate = [set stringForColumn:@"movieUpDate"];
                [dic setValue:movieTitle forKey:@"movieTitle"];
                [dic setValue:movieUrl forKey:@"movieUrl"];
                [dic setValue:movieTime forKey:@"movieTime"];
                [dic setValue:movieImage forKey:@"movieImage"];
                [dic setValue:movieUpDate forKey:@"movieUpDate"];
                
                // 依次把字典添加到数组中
                [array addObject:dic];
            }
            [set close];
            [fmdb close];
        }
    }
    return [NSArray arrayWithArray:array];
}

//查看数据是否再数据库中 如果存在返回yes  否则返回NO
- (BOOL)backTheDataInOrOut:(NSString *)movieTitle
{
    NSArray *AllColloct = [NSArray arrayWithArray:[self getAll]];
    for (NSDictionary * perDic in AllColloct) {
        NSString *getMovieTitle = [perDic objectForKey:@"movieTitle"];
        if ([getMovieTitle isEqualToString:movieTitle]) {
            return YES;
        }
    }
    return NO;
}


@end
