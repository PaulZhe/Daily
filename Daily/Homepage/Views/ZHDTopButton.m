//
//  ZHDTopButton.m
//  Daily
//
//  Created by 小哲的DELL on 2018/12/8.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "ZHDTopButton.h"

@implementation ZHDTopButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTintColor:[UIColor whiteColor]];
        self.titleLabel.font = [UIFont systemFontOfSize:23];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self titleRectForContentRect:self.frame];
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = 200;
    CGFloat titleW = 374;
    CGFloat titleX = 20;
    CGFloat titleH = 100;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
