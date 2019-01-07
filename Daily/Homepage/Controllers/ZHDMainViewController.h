//
//  MainViewController.h
//  
//
//  Created by 小哲的DELL on 2018/10/24.
//

#import <UIKit/UIKit.h>
#import "ZHDMainView.h"
#import "ZHDMainTableViewCell.h"
#import "ZHDHeaderView.h"
#import "ZHDNowManager.h"
#import "SDRefresh.h"

@interface ZHDMainViewController : UIViewController
@property (nonatomic, strong) ZHDMainView *mainView;
@property (nonatomic, strong) ZHDHeaderView *headerView;
@property (nonatomic, strong) ZHDTotalJSONModel *totalModel;
@property (nonatomic, strong) ZHDStoriesJSONModel *storiesModel;
@property (nonatomic, strong) UIView *statusBar;
@property (nonatomic, assign) NSInteger days;
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, weak) SDRefreshHeaderView *refreshHeader;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) UIButton *menuButton;
@property (nonatomic, strong) NSMutableArray *IDArray;
@end
