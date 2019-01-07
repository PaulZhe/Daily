//
//  ZHDCommentsContentModel.m
//  Daily
//
//  Created by 小哲的DELL on 2018/11/25.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "ZHDCommentsContentModel.h"

@implementation ZHDReplyModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}

@end

@implementation ZHDCommentsContentModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"ID":@"id",
                                                                  @"reply":@"reply_to"
                                                                  }];
}

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}

@end

@implementation ZHDCommentsTotalModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"ID":@"id"                                                   
                                                                  }];
}
@end
