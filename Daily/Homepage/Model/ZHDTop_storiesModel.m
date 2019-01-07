//
//  ZHDTop_storiesModel.m
//  Daily
//
//  Created by 小哲的DELL on 2018/10/31.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "ZHDTop_storiesModel.h"

@implementation ZHDTop_storiesModel

@end

@implementation ZHDStoriesJSONModel

-(instancetype)initWithJSON:(NSDictionary *)json {
    self = [ZHDStoriesJSONModel new];
    if (self) {
        self.title = json[@"title"];
        self.id = json[@"id"];
        self.ga_prefix = json[@"ga_prefix"];
        self.type = json[@"type"];
        self.images = json[@"images"];
    }
    return self;
}

@end

@implementation ZHDTotalJSONModel


@end
