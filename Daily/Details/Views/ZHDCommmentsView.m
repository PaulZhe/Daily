//
//  ZHDCommmentsView.m
//  Daily
//
//  Created by 小哲的DELL on 2018/11/24.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "ZHDCommmentsView.h"
#import <masonry.h>
#import "ZHDCommentsTableViewCell.h"

@implementation ZHDCommmentsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.bottomView = [[UIView alloc] init];
        self.bottomView.backgroundColor = [UIColor colorWithRed:0.24f green:0.24f blue:0.24f alpha:1.00f];
        [self addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom);
            make.left.mas_equalTo(self.mas_left);
            make.width.mas_equalTo(self.mas_width);
            make.height.equalTo(@42);
        }];
        
        self.backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [self.backButton setTintColor:[UIColor colorWithRed:0.56f green:0.56f blue:0.56f alpha:1.00f]];
        [self.bottomView addSubview:self.backButton];
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(20);
            make.top.mas_equalTo(self.bottomView.mas_top).offset(9);
            make.height.equalTo(@24);
            make.width.equalTo(@24);
        }];
        
        self.writeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.writeButton setImage:[UIImage imageNamed:@"评论2"] forState:UIControlStateNormal];
        [self.writeButton setTitle:@"写点评" forState:UIControlStateNormal];
        [self.writeButton setTintColor:[UIColor colorWithRed:0.64f green:0.64f blue:0.64f alpha:1.00f]];
        [self.bottomView addSubview:self.writeButton];
        [self.writeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(self.frame.size.width/2 + self.writeButton.frame.size.width);
            make.top.mas_equalTo(self.bottomView.mas_top).offset(9);
            make.height.equalTo(@24);
            make.width.equalTo(@80);
        }];

        self.tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - self.bottomView.frame.size.height-40)];
        [self.tabelView registerClass:[ZHDCommentsTableViewCell class] forCellReuseIdentifier:@"cell"];
        [self addSubview:self.tabelView];
    }
    return self;
}

@end
