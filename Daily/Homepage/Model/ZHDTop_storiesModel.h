//
//  ZHDTop_storiesModel.h
//  Daily
//
//  Created by 小哲的DELL on 2018/10/31.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "JSONModel.h"


@protocol ZHDTop_storiesModel
@end

@protocol ZHDStoriesJSONModel
@end

@interface ZHDTop_storiesModel : JSONModel
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *ga_prefix;
@property (nonatomic, copy) NSString *title;

@end

@interface ZHDStoriesJSONModel : JSONModel

@property (nonatomic, copy) NSArray *images;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *ga_prefix;
@property (nonatomic, copy) NSString *title;

-(instancetype)initWithJSON:(NSDictionary *)json;

@end


@interface ZHDTotalJSONModel : JSONModel

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSArray<ZHDTop_storiesModel>*top_stories;
@property (nonatomic, copy) NSArray<ZHDStoriesJSONModel>*stories;

@end
