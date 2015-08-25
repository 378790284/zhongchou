//
//  HomepageInformationModel.h
//  MyLoL
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomepageInformationModel : NSObject

@property (nonatomic,strong)NSString *artId;
@property (nonatomic,strong)NSString *commentSum;
@property (nonatomic,strong)NSString *commentUrl;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *destUrl;
@property (nonatomic,strong)NSString *hasVideo;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *isSubjectEntrance;
@property (nonatomic,strong)NSString *photo;
@property (nonatomic,strong)NSString *readCount;
@property (nonatomic,strong)NSString *subjectId;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *weight;
@property (nonatomic,strong)NSString *ymz_id;

- (id)initWithDictonary:(NSDictionary *)Dic;

@end
