//
//  NewVideoController.h
//  MyLoL
//
//  Created by lanou3g on 15/7/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockEngine.h"

@interface NewVideoController : UIViewController

@property (nonatomic,strong)BlockEngine *blockEngine;

@property (nonatomic,strong)BlockEngine *inEngine;

@property (nonatomic,strong)BlockEngine *downEngine;

@property (nonatomic,strong)NSString *pushTag;
@end
