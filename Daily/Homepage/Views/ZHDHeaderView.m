//
//  ZHDHeaderView.m
//  Daily
//
//  Created by 小哲的DELL on 2018/10/30.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "ZHDHeaderView.h"

@implementation ZHDHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.00f green:0.53f blue:0.85f alpha:1.00f];
        _lable = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width / 4.0, 0, frame.size.width / 2.0, frame.size.height)];
        _lable.textColor = [UIColor whiteColor];
        _lable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lable];
    }
    return self;
}

@end
