//
//  EventHomePageController.h
//  MyLoL
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ComTableController.h"
#import "NetWorkEngine.h"



@interface EventHomePageController : ComTableController<NetWorkProtrol>

@property(nonatomic,strong)NetWorkEngine *engine;

@end
