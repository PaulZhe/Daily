//
//  ZHDCommentsContentModel.h
//  Daily
//
//  Created by 小哲的DELL on 2018/11/25.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "JSONModel.h"
//@protocol ZHDReplyModel
//@end

@protocol ZHDCommentsContentModel
@end

@interface ZHDReplyModel : JSONModel
@property (nonatomic, copy) NSString *error_msg;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) long status;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *author;
@end

@interface ZHDCommentsContentModel : JSONModel
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSMutableString *avatar;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) ZHDReplyModel *reply;
@end

@interface ZHDCommentsTotalModel : JSONModel
@property (nonatomic, copy) NSArray<ZHDCommentsContentModel> *comments;
@end
