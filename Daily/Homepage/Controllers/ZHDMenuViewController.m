//
//  ZHDMenuViewController.m
//  Daily
//
//  Created by 小哲的DELL on 2018/11/3.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//
#define MidWidth self.view.frame.size.width / 2
#define Height self.view.frame.size.height
#define Width self.view.frame.size.width

#import "Masonry.h"
#import "ZHDMenuViewController.h"
#import "ZHDTitleButton.h"

@interface ZHDMenuViewController ()

@end

@implementation ZHDMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createChildView];
    
    // Do any additional setup after loading the view.
}

- (void)createChildView{
    self.view.frame = CGRectMake(-MidWidth, 0, Width, Height);
    self.view.backgroundColor = [UIColor colorWithRed:0.13f green:0.16f blue:0.19f alpha:1.00f];
    
    UIImageView *headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head.jpeg"]];
    [self.view addSubview:headImageView];
    [headImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width).multipliedBy(0.13);
        make.height.mas_equalTo(headImageView.mas_width);
        make.top.equalTo(self.view.mas_top).offset(35);
        make.left.equalTo(self.view.mas_left).offset(20);
    }];
    headImageView.layer.masksToBounds = YES;
    [headImageView.layer setCornerRadius:CGRectGetHeight([headImageView bounds])/2];

    UILabel *idLabel = [[UILabel alloc] init];
    idLabel.text = @"CP3";
    idLabel.textColor = [UIColor colorWithRed:0.57f green:0.58f blue:0.60f alpha:1.00f];
    idLabel.font = [UIFont systemFontOfSize:22];
    [self.view addSubview:idLabel];
    [idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width).multipliedBy(0.2);
        make.height.mas_equalTo(headImageView.mas_width).multipliedBy(0.5);
        make.top.equalTo(headImageView.mas_top).offset(15);
        make.left.equalTo(headImageView.mas_right).offset(20);
    }];
    
    ZHDTitleButton *likeButton = [ZHDTitleButton buttonWithFrame:CGRectMake((MidWidth/3)*0+20, headImageView.frame.origin.y+headImageView.frame.size.height+30, headImageView.frame.size.width/2, headImageView.frame.size.height) title:@"收藏" image:[UIImage imageNamed:@"收藏"]];
    [self.view addSubview:likeButton];
    ZHDTitleButton *messeageButton = [ZHDTitleButton buttonWithFrame:CGRectMake((MidWidth/3)*1+20, headImageView.frame.origin.y+headImageView.frame.size.height+30, headImageView.frame.size.width/2, headImageView.frame.size.height) title:@"消息" image:[UIImage imageNamed:@"消息"]];
    [self.view addSubview:messeageButton];
    ZHDTitleButton *editButton = [ZHDTitleButton buttonWithFrame:CGRectMake((MidWidth/3)*2+20, headImageView.frame.origin.y+headImageView.frame.size.height+30, headImageView.frame.size.width/2, headImageView.frame.size.height) title:@"设置" image:[UIImage imageNamed:@"设置"]];
    [self.view addSubview:editButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
