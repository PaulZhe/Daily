//
//  ZHDCommentsManager.h
//  Daily
//
//  Created by 小哲的DELL on 2018/11/24.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHDCommentsModel.h"
#import "ZHDCommentsContentModel.h"

typedef void(^ZHDGetComments)(ZHDCommentsModel *commentsModel);
typedef void(^ZHDGetCommentsContent)(ZHDCommentsTotalModel *commentsContentModel);
typedef void(^ErrorHandel)(NSError *error);
@interface ZHDCommentsManager : NSObject

+ (instancetype)sharedManager;
- (void)requestCommentsWithID:(NSString *)ID Success:(ZHDGetComments)succeedBlock Failure: (ErrorHandel)failBlock;
- (void)requestLongCommentsContentWithID:(NSString *)ID Success:(ZHDGetCommentsContent)succeedBlock Failure: (ErrorHandel)failBlock;
- (void)requestShortCommentsContentWithID:(NSString *)ID Success:(ZHDGetCommentsContent)succeedBlock Failure: (ErrorHandel)failBlock;
@end
