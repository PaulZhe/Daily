//
//  ZHDCommentsViewController.h
//  Daily
//
//  Created by 小哲的DELL on 2018/11/24.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHDCommentsModel.h"
#import "ZHDCommmentsView.h"
#import "ZHDCommentsContentModel.h"

@interface ZHDCommentsViewController : UIViewController
@property (nonatomic, assign) NSString* ID;
@property (nonatomic, strong) ZHDCommentsModel *commentsModel;
@property (nonatomic, strong) ZHDCommmentsView *commentsView;
@property (nonatomic, strong) ZHDCommentsTotalModel *shortCommentsModel;
@property (nonatomic, strong) ZHDCommentsTotalModel *longCommentsModel;
@property (nonatomic, strong) UIView *statusBar;
@end
