//
//  WallPaperController.h
//  MyLoL
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWorkEngine.h"

@interface WallPaperController : UIViewController<NetWorkProtrol,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)NetWorkEngine *engine;

@end
