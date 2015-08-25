//
//  HomepageInformation.h
//  MyLoL
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ComTableController.h"
#import "NetWorkEngine.h"


@interface HomepageInformation : ComTableController<NetWorkProtrol>

@property (nonatomic,strong)NetWorkEngine *engine;
@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)NSMutableArray *headerArray;

@end
