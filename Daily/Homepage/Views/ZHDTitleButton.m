//
//  ZHDTitleButton.m
//  Daily
//
//  Created by 小哲的DELL on 2018/11/14.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "ZHDTitleButton.h"

@implementation ZHDTitleButton
+ (instancetype)buttonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image{
    ZHDTitleButton *button = [super buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTintColor:[UIColor colorWithRed:0.48f green:0.50f blue:0.52f alpha:1.00f]];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.imageView.contentMode = UIViewContentModeCenter;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button imageRectForContentRect:frame];
    [button titleRectForContentRect:frame];
    return button;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageX = 0;
    CGFloat imageY = 12;
    CGFloat imageWidth = contentRect.size.width;
    CGFloat imageHeight = contentRect.size.height * (1 - 0.4);
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleHeight = contentRect.size.height * 0.4;
    CGFloat titleY = contentRect.size.height - titleHeight + 10;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}

@end
