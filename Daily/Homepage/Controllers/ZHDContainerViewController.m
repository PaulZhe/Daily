//
//  ZHDContainerViewController.m
//  Daily
//
//  Created by 小哲的DELL on 2018/11/3.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "ZHDContainerViewController.h"

@interface ZHDContainerViewController ()

@end

@implementation ZHDContainerViewController

//封装菜单界面
- (void)addMenuViewController{
    //创建菜单控制器
    [self setMenuViewController:[[ZHDMenuViewController alloc]init]];
    [self addChildViewController:self.menuViewController];
    [self.view addSubview:self.menuViewController.view];
}

//添加子控制对象
- (void)addContentController{
    self.mainViewController = [[ZHDMainViewController alloc] init];
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:self.mainViewController];
    self.mainViewController.title = @"今日热闻";
    [self addChildViewController:mainNavigationController];
    [self.view addSubview:mainNavigationController.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMenuViewController];
    [self addContentController];
    // Do any additional setup after loading the view.
}

/**侧边按钮的动画*/
- (void)openCloseMenu
{
    
    if (_isAnimating) {
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        _isAnimating = YES;
        if(!_isMenuOpen){
            self.mainViewController.navigationController.view.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width / 2, 0);
            self.menuViewController.view.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width / 2, 0);
        }
        //       else {
        //           self.contentController.view.transform = CGAffineTransformMakeTranslation(0, 0);
        //     }
    }completion:^(BOOL finished) {
        _isMenuOpen = !_isMenuOpen;
        if (!_isMenuOpen ) {
            [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionCurveEaseOut  animations:^{
                self.mainViewController.navigationController.view.transform = CGAffineTransformIdentity;
                self.menuViewController.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                _isAnimating = NO;
            }];
        }
        else {
            _isAnimating = NO;
        }
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
