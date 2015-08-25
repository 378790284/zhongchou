//
//  Define.h
//  MyLoL
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "SizeDefine.h"

#define RGB_COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#if 1

#define DEBUG_COLOR [UIColor colorWithRed:arc4random() % 256 /255.0 green:arc4random() % 256 /255.0 blue:arc4random() % 256 /255.0/255.0 alpha:1]

#else

#define DEBU_COLOR [UIColor clearColor]



#endif