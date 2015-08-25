//
//  TopicViewController.h
//  MyLoL
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ComTableController.h"
#import "BlockEngine.h"


@interface TopicViewController : ComTableController

@property (nonatomic,strong)BlockEngine *engine;
@property (nonatomic,strong)NSString *subjectId;

@end
