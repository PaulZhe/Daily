//
//  ZHDCommentsTableViewCell.h
//  Daily
//
//  Created by 小哲的DELL on 2018/11/24.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHDCommentsTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *idLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UILabel *replyLabel;
@property (nonatomic, strong) UIButton *foldButton;
-(void)cellOpen;
-(void)cellClose;
//- (void)update;
@end
