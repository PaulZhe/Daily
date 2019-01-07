//
//  ZHDDetailsViewController.h
//  Daily
//
//  Created by 小哲的DELL on 2018/11/18.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHDDetailsView.h"
#import "ZHDCommentsModel.h"

@interface ZHDDetailsViewController : UIViewController
@property (nonatomic, assign) NSInteger days;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, strong) NSMutableArray *IDArray;
@property (nonatomic, strong) ZHDDetailsView *detailsView;
@property (nonatomic, strong) ZHDCommentsModel *commentsModel;

- (void)postID;
@end
