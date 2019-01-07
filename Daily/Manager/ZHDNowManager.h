//
//  ZHDNowManager.h
//  Daily
//
//  Created by 小哲的DELL on 2018/11/1.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHDTop_storiesModel.h"

typedef void(^ZHDGetStories)(ZHDTotalJSONModel *resultModel);
typedef void(^ZHDGetRecentStories)(NSMutableArray *storiesArray);
typedef void(^ZHDGetRecentStories)(NSMutableArray *storiesArray);
typedef void(^ErrorHandel)(NSError *error);

@interface ZHDNowManager : NSObject

+ (instancetype)sharedManager;

- (void)requestNowStoriesWith:(NSInteger)days Success:(ZHDGetStories)succeedBlock Failure: (ErrorHandel)failBlock;
- (void)requestRecentStoriesWith:(NSInteger)days :(NSMutableArray *)mutableArray Success:(ZHDGetRecentStories)succeedBlock Failure: (ErrorHandel)failBlock;
- (void)requestRecentIDWith:(NSInteger)days :(NSMutableArray *)mutableArray Success:(ZHDGetRecentStories)succeedBlock Failure: (ErrorHandel)failBlock;
@end
