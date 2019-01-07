//
//  ZHDContainerViewController.h
//  Daily
//
//  Created by 小哲的DELL on 2018/11/3.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHDMenuViewController.h"
#import "ZHDMainViewController.h"

@interface ZHDContainerViewController : UIViewController

/**菜单控制器*/
@property(strong,nonatomic) ZHDMenuViewController *menuViewController;
/**用来存放和记录当前呈现的主控制器界面*/
@property(strong,nonatomic)ZHDMainViewController *mainViewController;
/**标记当前菜单是打开还是关闭状态*/
@property(assign,nonatomic,readonly)BOOL isMenuOpen;
/**判断动画是否正在执行*/
@property(assign,nonatomic,readonly)BOOL isAnimating;


@end
