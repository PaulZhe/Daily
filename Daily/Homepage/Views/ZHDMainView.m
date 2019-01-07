//
//  MainView.m
//  Daily
//
//  Created by 小哲的DELL on 2018/10/24.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "ZHDMainView.h"
#import "ZHDMainViewController.h"

@implementation ZHDMainView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
        [self.tableView registerClass:[ZHDMainTableViewCell class] forCellReuseIdentifier:@"cell"];

        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [self addSubview:self.tableView];
        
        _carousel = [[ZHDCarouselView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 300)];
        _carousel.delegate = self;
        _carousel.currentPageColor = [UIColor orangeColor];
        _carousel.pageColor = [UIColor grayColor];
        self.tableView.tableHeaderView = _carousel;
    }
    return self;
}

- (void)carouselView:(ZHDCarouselView *)carouselView indexOfClickedImageBtn:(NSUInteger )index {
    NSLog(@"点击了第%ld张图片",index);
    [self.delegate pass:index];
}


@end
