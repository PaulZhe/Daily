//
//  ZHDDetailsViewController.m
//  Daily
//
//  Created by 小哲的DELL on 2018/11/18.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
#import "ZHDDetailsViewController.h"
#import <WebKit/WebKit.h>
#import "ZHDCommentsViewController.h"
#import "ZHDCommentsManager.h"
#import "ZHDNowManager.h"

@interface ZHDDetailsViewController () <WKUIDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIView *statusBar;
@end

@implementation ZHDDetailsViewController {
    int count;
    NSString *nextID;
    NSString *lastID;
    BOOL haveNet;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self postData];
    [self createChildView:self.ID];
    [self search];
}

//寻找下一条新闻的ID
- (void)search {
    
    for (int i = 0; i <_IDArray.count; i++) {
        if ([_IDArray[i] isEqualToString:self.ID]) {
//            lastID = _IDArray[i-1];
            nextID = _IDArray[++i];
            count = i;
            break;
        }
    }
}

- (void)postID {
    [[ZHDNowManager sharedManager] requestRecentIDWith:self.days+1 :self.IDArray Success:^(NSMutableArray *storiesArray) {

    } Failure:^(NSError *error) {
        
    }];
}

- (UIView *)createChildView: (NSString *)ID{
    self.detailsView = [[ZHDDetailsView alloc] initWithFrame:self.view.frame];
    // 设置状态栏颜色
    self.statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([self.statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        self.statusBar.backgroundColor = [UIColor clearColor];
    }
    self.navigationController.navigationBar.hidden = YES;
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT*0.94)];
    webView.UIDelegate = self;
    webView.scrollView.delegate = self;
    
    NSString *str = [NSString stringWithFormat:@"https://daily.zhihu.com/story/%@", ID];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.detailsView addSubview:webView];
    
    [self.view addSubview:self.detailsView];

    //为bottomView的button添加点击事件
    [self.detailsView.bottomView.backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.detailsView.bottomView.commentButton addTarget:self action:@selector(commentsClilk) forControlEvents:UIControlEventTouchUpInside];
    [self.detailsView.bottomView.downButton addTarget:self action:@selector(downClick) forControlEvents:UIControlEventTouchUpInside];
    return self.detailsView;
}

- (void)postData{
    [[ZHDCommentsManager sharedManager] requestCommentsWithID:self.ID Success:^(ZHDCommentsModel *commentsModel) {
        self.commentsModel = commentsModel;
        self->haveNet = YES;
    } Failure:^(NSError *error) {
        self->haveNet = NO;
    }];
}

-(void)downClick {
    [UIView transitionFromView:self.detailsView toView:[self createChildView:nextID] duration:1 options:UIViewAnimationOptionTransitionCurlUp completion:^(BOOL finished) {
        self.ID = self->nextID;
        [self postData];
        if (self->count + 2 >= self.IDArray.count && self->haveNet) {

            [self postID];
        }
//        count++;
        if (self->haveNet) {
            self->nextID = self.IDArray[++self->count];
        }
        
//        lastID = self.ID;
    }];
}

//- (void)upClick {
//    lastID = self.IDArray[--count];
//    [UIView transitionFromView:self.detailsView toView:[self createChildView:lastID] duration:1 options:UIViewAnimationOptionTransitionCurlUp completion:^(BOOL finished) {
//    }];
//}

- (void)backClick{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)commentsClilk{
    ZHDCommentsViewController *commentsController = [[ZHDCommentsViewController alloc] init];
    commentsController.ID = self.ID;
    commentsController.title = [NSString stringWithFormat:@"%@条点评", self.commentsModel.comments];
    commentsController.commentsModel = self.commentsModel;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:commentsController];
    [self presentViewController:navigationController animated:YES completion:nil];
//    [self.navigationController pushViewController:commentsController animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
//    NSLog(@"%f", scrollView.contentOffset.y);
    CGRect bounds = scrollView.bounds;
    CGSize contentSize = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = contentSize.height;
    float reload_distance = 10;
    if (y > h + reload_distance && scrollView.contentSize.height != 0) {
        [self downClick];
    }
//    if (scrollView.contentOffset.y < -30 && scrollView.contentSize.height != 0) {
//        [self upClick];
//    }
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
