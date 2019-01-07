//
//  ZHDCommentsViewController.m
//  Daily
//
//  Created by 小哲的DELL on 2018/11/24.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "ZHDCommentsViewController.h"
#import "ZHDCommentsTableViewCell.h"
#import "ZHDCommentsManager.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "ZHDDateUtils.h"

@interface ZHDCommentsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (copy, nonatomic) NSMutableString *str;
@end

@implementation ZHDCommentsViewController{
    NSMutableArray *cellArray;
    BOOL isSpread;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    [self postData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

//- (void)viewWillDisappear:(BOOL)animated{
//    self.navigationController.navigationBar.hidden = YES;
//}

- (void)initUI{
    NSMutableArray *cellArray1 = [NSMutableArray arrayWithArray:@[@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO]];
    NSMutableArray *cellArray0 = [NSMutableArray arrayWithArray:@[@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO]];
    cellArray = [NSMutableArray new];
    [cellArray addObject:cellArray0];
    [cellArray addObject:cellArray1];
    
//    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.00f green:0.53f blue:0.85f alpha:1.00f];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.00f green:0.49f blue:0.86f alpha:1.00f];
    [self.navigationItem setHidesBackButton:YES];
//    self.navigationController.navigationBar.hidden = NO;
//    // 设置状态栏颜色
//    self.statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    if ([self.statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//        self.statusBar.backgroundColor = [UIColor colorWithRed:0.00f green:0.53f blue:0.85f alpha:1.00f];
//    }
    
    self.commentsView = [[ZHDCommmentsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.commentsView];
    
    [self.commentsView.backButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    self.commentsView.tabelView.delegate = self;
    self.commentsView.tabelView.dataSource = self;
    self.commentsView.tabelView.rowHeight = UITableViewAutomaticDimension;
//    self.commentsView.tabelView.estimatedRowHeight = 200;
//    self.commentsView.tabelView.estimatedRowHeight = 0;
//    self.commentsView.tabelView.estimatedSectionHeaderHeight = 0;
//    self.commentsView.tabelView.estimatedSectionFooterHeight = 0;
}

- (void)postData{
    [[ZHDCommentsManager sharedManager] requestLongCommentsContentWithID:self.ID Success:^(ZHDCommentsTotalModel *commentsModel) {
        self.longCommentsModel = commentsModel;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.commentsView.tabelView reloadData];
        });
    } Failure:^(NSError *error) {
        
    }];
    [[ZHDCommentsManager sharedManager] requestShortCommentsContentWithID:self.ID Success:^(ZHDCommentsTotalModel *commentsModel) {
        self.shortCommentsModel = commentsModel;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.commentsView.tabelView reloadData];
        });
    } Failure:^(NSError *error) {
        
    }];
}

- (void)click{
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if ([self.commentsModel.long_comments integerValue] > 13) {
            return 13;
        } else{
           return [self.commentsModel.long_comments integerValue];
            
        }
    } else{
        if (isSpread == NO) {
            return 0;
        } else {
            if ([self.commentsModel.short_comments integerValue] > 20) {
                return 20;
            } else{
                return [self.commentsModel.short_comments integerValue];
            }
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if ([self.commentsModel.long_comments isEqualToString:@"0"]) {
            return self.view.frame.size.height - 64-84;
        } else{
            return 36;
        }
    } else{
        return 36;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if ([self.commentsModel.long_comments isEqualToString:@"0"]) {
            UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64-84)];
//            UIView *headView = [[UIView alloc] init];
//            headView.frame.size = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 64-84);

            headView.backgroundColor = [UIColor whiteColor];
            UIImageView *sofaImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"沙发"]];
            [headView addSubview:sofaImageView];
            [sofaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(headView.mas_left).offset(headView.frame.size.width/3);
                make.top.equalTo(headView.mas_top).offset(headView.frame.size.height/2-70);
                make.width.mas_equalTo(headView.frame.size.width/3);
                make.height.mas_equalTo(sofaImageView.mas_width);
            }];
            UILabel *label = [[UILabel alloc] init];
            label.text = @"深度长评虚位以待";
            label.textColor = [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.00f];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:14];
            [headView addSubview:label];;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(sofaImageView.mas_bottom).offset(16);
                make.left.equalTo(headView.mas_left).offset(headView.frame.size.width/3);
                make.width.mas_equalTo(headView.frame.size.width/3);
                make.height.equalTo(@20);
            }];
            return headView;
        } else{
            UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 42)];
            headView.backgroundColor = [UIColor whiteColor];
            UILabel *label = [[UILabel alloc] init];
            label.text = [NSString stringWithFormat:@"%@条长评", self.commentsModel.long_comments];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            [headView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(headView.mas_left).offset(20);
                make.top.mas_equalTo(headView.mas_top).offset(4);
                make.width.equalTo(@100);
                make.height.equalTo(@22);
            }];
            return headView;
        }
    } else{
        UIButton *headView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 42)];
        headView.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString stringWithFormat:@"%@条短评", self.commentsModel.short_comments];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor blackColor];
        [headView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headView.mas_left).offset(20);
            make.top.mas_equalTo(headView.mas_top).offset(4);
            make.width.equalTo(@100);
            make.height.equalTo(@22);
        }];
        [headView addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
        return headView;
    }
}

- (void)headClick:(UIButton *)btn{
    isSpread = !isSpread;
    [self.commentsView.tabelView reloadData];
    if (isSpread == YES) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.commentsView.tabelView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ZHDCommentsTableViewCell  *commentsTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        //判断cell是否处于展开状态
        if ([cellArray[0][indexPath.row]  isEqual: @YES]) {
            [commentsTableViewCell cellOpen];
            commentsTableViewCell.foldButton.selected = YES;
        }
        if (!commentsTableViewCell) {
            commentsTableViewCell = [[ZHDCommentsTableViewCell alloc] init];
        }

        _str = [self.longCommentsModel.comments[indexPath.row] avatar];
        if ([_str characterAtIndex:4] != 's') {
            [_str insertString:@"s" atIndex:4];
        }

        [commentsTableViewCell.headImageView sd_setImageWithURL:[NSURL URLWithString:_str] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
        
        commentsTableViewCell.idLabel.text = [self.longCommentsModel.comments[indexPath.row] author];
        commentsTableViewCell.contentLabel.text = [self.longCommentsModel.comments[indexPath.row] content];
        [commentsTableViewCell.likeButton setTitle:[self.longCommentsModel.comments[indexPath.row] likes] forState:UIControlStateNormal];
        [commentsTableViewCell.likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        commentsTableViewCell.timeLabel.text = [ZHDDateUtils getDateStringWithTimeStr:[self.longCommentsModel.comments[indexPath.row] time]];
        
        //判断回复label是否存在
        if ([self.longCommentsModel.comments[indexPath.row] reply] == nil) {
            commentsTableViewCell.replyLabel.text = nil;
            commentsTableViewCell.foldButton.hidden = YES;
        } else{
            commentsTableViewCell.foldButton.hidden = NO;

            if ([[[self.longCommentsModel.comments[indexPath.row] reply] error_msg] isEqualToString:@"抱歉，原点评已经被删除"]) {
                commentsTableViewCell.foldButton.hidden = YES;
                commentsTableViewCell.replyLabel.text = @"抱歉，原点评已经被删除";
            } else {
                NSString *str = [NSString stringWithFormat:@"//%@：", [[self.longCommentsModel.comments[indexPath.row] reply] author]];
                NSMutableString *replyStr = [[NSMutableString alloc] initWithString:str];
                [replyStr appendString:[[self.longCommentsModel.comments[indexPath.row] reply] content]];
            
                NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:replyStr];
                NSRange range1 = NSMakeRange(0, [str length] - 1);
                NSRange range2 = NSMakeRange([str length] + 1, [[[self.longCommentsModel.comments[indexPath.row] reply] content] length] - 1);
                [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
                [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.53f green:0.53f blue:0.53f alpha:1.00f] range:range2];
                [commentsTableViewCell.replyLabel setAttributedText:noteStr];
            
                [commentsTableViewCell.foldButton addTarget:self action:@selector(reloadCell:) forControlEvents:UIControlEventTouchUpInside];
            
                //计算回复label中隐藏的文字长度
                NSInteger count = [self textHeightFromTextString:replyStr width:commentsTableViewCell.contentView.frame.size.width - 22 - (commentsTableViewCell.contentView.frame.size.width * (40.0/534.0) + 33) fontSize:17].height / commentsTableViewCell.replyLabel.font.lineHeight;
                if (count <= 2) {
                    commentsTableViewCell.foldButton.hidden = YES;
                } else{
                    commentsTableViewCell.foldButton.hidden = NO;
                }
            }
        }
        //判断cell是否处于展开状态
        if ([cellArray[0][indexPath.row]  isEqual: @NO]){
            [commentsTableViewCell cellClose];
            commentsTableViewCell.foldButton.selected = NO;
        }
        return commentsTableViewCell;
    } else{
        ZHDCommentsTableViewCell *commentsTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        //判断cell是否处于展开状态
        if ([cellArray[1][indexPath.row]  isEqual: @YES]) {
            [commentsTableViewCell cellOpen];
            commentsTableViewCell.foldButton.selected = YES;
        }

        if (!commentsTableViewCell) {
            commentsTableViewCell = [[ZHDCommentsTableViewCell alloc] init];
        }
        _str = [self.shortCommentsModel.comments[indexPath.row] avatar];
        
        if ([_str characterAtIndex:4] != 's') {
            [_str insertString:@"s" atIndex:4];
        }
        
        [commentsTableViewCell.headImageView sd_setImageWithURL:[NSURL URLWithString:_str] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
        
        commentsTableViewCell.idLabel.text = [self.shortCommentsModel.comments[indexPath.row] author];
        commentsTableViewCell.contentLabel.text = [self.shortCommentsModel.comments[indexPath.row] content];
        [commentsTableViewCell.likeButton setTitle:[self.shortCommentsModel.comments[indexPath.row] likes] forState:UIControlStateNormal];
        [commentsTableViewCell.likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        commentsTableViewCell.timeLabel.text = [ZHDDateUtils getDateStringWithTimeStr:[self.shortCommentsModel.comments[indexPath.row] time]];
        
        //判断回复label是否出现
        if ([self.shortCommentsModel.comments[indexPath.row] reply] == nil) {
            commentsTableViewCell.foldButton.hidden = YES;
            commentsTableViewCell.replyLabel.text = nil;
        } else{
            commentsTableViewCell.foldButton.hidden = NO;
            //判断原评论是否被删除
            if ([[[self.shortCommentsModel.comments[indexPath.row] reply] error_msg] isEqualToString:@"抱歉，原点评已经被删除"]) {
                commentsTableViewCell.foldButton.hidden = YES;
                commentsTableViewCell.replyLabel.text = @"抱歉，原点评已经被删除";
            } else {
                NSString *str = [NSString stringWithFormat:@"//%@：", [[self.shortCommentsModel.comments[indexPath.row] reply] author]];
                NSMutableString *replyStr = [[NSMutableString alloc] initWithString:str];
                
                [replyStr appendString:[[self.shortCommentsModel.comments[indexPath.row] reply] content]];
                NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:replyStr];
                NSRange range1 = NSMakeRange(0, [str length] - 1);
                NSRange range2 = NSMakeRange([str length] + 1, [[[self.shortCommentsModel.comments[indexPath.row] reply] content] length] - 1);
                [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
                [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.53f green:0.53f blue:0.53f alpha:1.00f] range:range2];
                
                [commentsTableViewCell.replyLabel setAttributedText:noteStr];
                
                [commentsTableViewCell.foldButton addTarget:self action:@selector(reloadCell:) forControlEvents:UIControlEventTouchUpInside];
                
                //计算回复label中隐藏的文字长度
                NSInteger count = [self textHeightFromTextString:replyStr width:commentsTableViewCell.contentView.frame.size.width - 22 - (commentsTableViewCell.contentView.frame.size.width * (40.0/534.0) + 33) fontSize:17].height / commentsTableViewCell.replyLabel.font.lineHeight;
                if (count <= 2) {
                    commentsTableViewCell.foldButton.hidden = YES;
                } else{
                    commentsTableViewCell.foldButton.hidden = NO;
                }
            }
            //判断cell是否处于展开状态
            if ([cellArray[1][indexPath.row]  isEqual: @NO]){
                [commentsTableViewCell cellClose];
                commentsTableViewCell.foldButton.selected = NO;
            }
        }
        
        return commentsTableViewCell;
    }
}

- (void)reloadCell:(UIButton *)button{
    ZHDCommentsTableViewCell *cell = (ZHDCommentsTableViewCell *)[[button superview] superview];
    NSIndexPath *indexPath = [_commentsView.tabelView indexPathForCell:cell];
    if ([cellArray[indexPath.section][indexPath.row]  isEqual:@YES]) {
        cellArray[indexPath.section][indexPath.row] = @NO;
    } else {
        cellArray[indexPath.section][indexPath.row] = @YES;
    }
    [_commentsView.tabelView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(CGSize)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size{
    //计算 label需要的宽度和高度
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    CGSize size1 = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size]}];
    
    return CGSizeMake(size1.width, rect.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
