//
//  MainTableViewCell.m
//  
//
//  Created by 小哲的DELL on 2018/10/24.
//

#import "ZHDMainTableViewCell.h"

@implementation ZHDMainTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    
    
    
    return self;
}

- (void)initUI{
    self.label = [[UILabel alloc] init];
    self.rightImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.rightImageView];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-20);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.7);
    }];
    self.label.numberOfLines = 0;
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.contentView).multipliedBy(0.1845);
        make.height.mas_equalTo(self.contentView).multipliedBy(0.667);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
