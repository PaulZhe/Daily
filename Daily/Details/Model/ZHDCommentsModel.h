//
//  ZHDCommentsModel.h
//  Daily
//
//  Created by 小哲的DELL on 2018/11/24.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "JSONModel.h"

@interface ZHDCommentsModel : JSONModel
@property (nonatomic, copy) NSString *long_comments;
@property (nonatomic, copy) NSString *popularity;
@property (nonatomic, copy) NSString *short_comments;
@property (nonatomic, copy) NSString *comments;
@end
