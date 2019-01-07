//
//  MainView.h
//  Daily
//
//  Created by 小哲的DELL on 2018/10/24.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHDMainTableViewCell.h"
#import "ZHDCarouselView.h"
#import "ZHDTop_storiesModel.h"
#import "ZHDDetailsViewController.h"
@class ZHDMainView;
@protocol ZHDMainViewDelegate <NSObject>
- (void)pass:(NSInteger)index;
@end

@interface ZHDMainView : UIView <ZHDCarouselViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZHDMainTableViewCell *tableViewCell;
@property (nonatomic, strong) ZHDCarouselView *carousel;
@property (nonatomic, strong) ZHDTotalJSONModel *totalModel;
@property (nonatomic, weak) id<ZHDMainViewDelegate> delegate;

@end
