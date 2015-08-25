//
//  PhotoDetilController.h
//  MyLoL
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWorkEngine.h"

@interface PhotoDetilController : UIViewController<NetWorkProtrol, UIScrollViewDelegate>

@property (nonatomic,strong)NSString *albumId;

@property (nonatomic, strong)NetWorkEngine *engine;


@end
