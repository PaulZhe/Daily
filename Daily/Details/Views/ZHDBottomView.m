//
//  ZHDBottomView.m
//  Daily
//
//  Created by 小哲的DELL on 2018/11/24.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//
#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height
#import "ZHDBottomView.h"
#import <masonry.h>

@implementation ZHDBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 2)];
        lineView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
        [self addSubview:lineView];
        
        self.backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.downButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.likeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.shareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.commentButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [self.backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [self.backButton setTintColor:[UIColor colorWithRed:0.65f green:0.64f blue:0.65f alpha:1.00f]];
        [self.downButton setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
        [self.downButton setTintColor:[UIColor colorWithRed:0.65f green:0.64f blue:0.65f alpha:1.00f]];
        [self.likeButton setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
        [self.likeButton setTintColor:[UIColor colorWithRed:0.65f green:0.64f blue:0.65f alpha:1.00f]];
        [self.shareButton setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
        [self.shareButton setTintColor:[UIColor colorWithRed:0.65f green:0.64f blue:0.65f alpha:1.00f]];
        [self.commentButton setImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
        [self.commentButton setTintColor:[UIColor colorWithRed:0.65f green:0.64f blue:0.65f alpha:1.00f]];
        
        [self addSubview:self.backButton];
        [self addSubview:self.downButton];
        [self addSubview:self.likeButton];
        [self addSubview:self.shareButton];
        [self addSubview:self.commentButton];
        
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.mas_height).multipliedBy(0.5);
            make.width.mas_equalTo(self.backButton.mas_height);
            make.left.equalTo(self.mas_left).offset((WIDTH/5)*0 + (WIDTH/5 - self.backButton.frame.size.width)/2 );
            make.top.equalTo(self.mas_top).offset(12);
        }];
        [self.downButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.mas_height).multipliedBy(0.5);
            make.width.mas_equalTo(self.downButton.mas_height);
            make.left.equalTo(self.mas_left).offset((WIDTH/5)*1 + (WIDTH/5 - self.downButton.frame.size.width)/2 );
            make.top.equalTo(self.mas_top).offset(12);
        }];
        [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.mas_height).multipliedBy(0.5);
            make.width.mas_equalTo(self.likeButton.mas_height);
            make.left.equalTo(self.mas_left).offset((WIDTH/5)*2 + (WIDTH/5 - self.likeButton.frame.size.width)/2 );
            make.top.equalTo(self.mas_top).offset(12);
        }];
        [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.mas_height).multipliedBy(0.5);
            make.width.mas_equalTo(self.shareButton.mas_height);
            make.left.equalTo(self.mas_left).offset((WIDTH/5)*3 + (WIDTH/5 - self.shareButton.frame.size.width)/2 );
            make.top.equalTo(self.mas_top).offset(12);
        }];
        [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.mas_height).multipliedBy(0.5);
            make.width.mas_equalTo(self.commentButton.mas_height);
            make.left.equalTo(self.mas_left).offset((WIDTH/5)*4 + (WIDTH/5 - self.commentButton.frame.size.width)/2 );
            make.top.equalTo(self.mas_top).offset(12);
        }];
    }
    return self;
}

@end
