//
//  ZHDDetailsView.m
//  Daily
//
//  Created by 小哲的DELL on 2018/11/24.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "ZHDDetailsView.h"
#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height

@implementation ZHDDetailsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.bottomView = [[ZHDBottomView alloc] initWithFrame:CGRectMake(0, HEIGHT*0.94, WIDTH, HEIGHT*0.06)];
        [self addSubview:self.bottomView];
    }
    return self;
}

@end
