//
//  ZHDCommentsTableViewCell.m
//  Daily
//
//  Created by 小哲的DELL on 2018/11/24.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "ZHDCommentsTableViewCell.h"
#import <Masonry.h>

@implementation ZHDCommentsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_headImageView];
        
        _headImageView.layer.masksToBounds = YES;
        [_headImageView.layer setCornerRadius:(self.contentView.frame.size.width * (40.0 / 534.0))/2];
        [_headImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(40.0/534.0);
            make.height.mas_equalTo(self.headImageView.mas_width);
            make.top.mas_equalTo(self.contentView.mas_top).offset(25);
            make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        }];
        
        self.idLabel = [[UILabel alloc] init];
        _idLabel.textColor = [UIColor blackColor];
        _idLabel.textAlignment = NSTextAlignmentLeft;
        _idLabel.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_idLabel];
        [_idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.7);
            make.height.equalTo(@20);
            make.left.mas_equalTo(self.headImageView.mas_right).offset(13);
            make.top.mas_equalTo(self.headImageView.mas_top).offset(4);
        }];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.textColor = [UIColor blackColor];
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        self.contentLabel.font = [UIFont systemFontOfSize:17];
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.idLabel.mas_bottom).offset(10);
            //            make.bottom.equalTo(self.contentView.mas_bottom);
            make.left.equalTo(self.idLabel.mas_left);
            make.right.equalTo(self.contentView.mas_right).offset(-22);
        }];
        
        self.likeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _likeButton.tintColor = [UIColor colorWithRed:0.71f green:0.71f blue:0.71f alpha:1.00f];
        [self.contentView addSubview:_likeButton];
        [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.idLabel.mas_top);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.height.equalTo(@20);
            make.width.equalTo(@50);
        }];

        self.timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor colorWithRed:0.71f green:0.71f blue:0.71f alpha:1.00f];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.idLabel.mas_left);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
            make.height.equalTo(@20);
            make.width.equalTo(@200);
        }];
        
        self.foldButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_foldButton setTitle:@"展开" forState:UIControlStateNormal];
        [_foldButton setTitle:@"收起" forState:UIControlStateSelected];
        [_foldButton setBackgroundColor:[UIColor colorWithRed:0.84f green:0.89f blue:0.95f alpha:1.00f]];
        [_foldButton setTintColor:[UIColor colorWithRed:0.84f green:0.89f blue:0.95f alpha:1.00f]];
        [_foldButton setTitleColor:[UIColor colorWithRed:0.55f green:0.56f blue:0.58f alpha:1.00f] forState:UIControlStateNormal];
        [_foldButton setTitleColor:[UIColor colorWithRed:0.55f green:0.56f blue:0.58f alpha:1.00f] forState:UIControlStateSelected];
        [self.contentView addSubview:_foldButton];
        [_foldButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLabel.mas_top).offset(-2);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.height.equalTo(@20);
            make.width.equalTo(@40);
        }];
        
        self.replyLabel = [[UILabel alloc] init];
        self.replyLabel.textColor = [UIColor colorWithRed:0.52f green:0.52f blue:0.52f alpha:1.00f];
        _replyLabel.textAlignment = NSTextAlignmentLeft;
        _replyLabel.font = [UIFont systemFontOfSize:17];
        self.replyLabel.numberOfLines = 2;
        [self.contentView addSubview:self.replyLabel];
        [_replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(6);
            //            make.height.mas_equalTo(50);
            make.bottom.equalTo(self.timeLabel.mas_top).offset(-8);
            make.left.equalTo(self.contentLabel.mas_left);
            make.right.equalTo(self.contentLabel.mas_right);
        }];
        
    }
    return self;
}
-(void)cellOpen{
    self.replyLabel.numberOfLines = 0;
}
-(void)cellClose{
    self.replyLabel.numberOfLines = 2;
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
