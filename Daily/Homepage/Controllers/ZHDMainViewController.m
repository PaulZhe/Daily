//
//  MainViewController.m
//  
//
//  Created by 小哲的DELL on 2018/10/24.
//

#import "ZHDMainViewController.h"
#import "ZHDDateUtils.h"
#import "ZHDDetailsViewController.h"
#include <SDWebImage/UIImageView+WebCache.h>
#import "ZHDCacheManager.h"

@interface ZHDMainViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, ZHDCarouselViewDelegate, ZHDMainViewDelegate> {
    ZHDCacheManager *cacheManager;
    BOOL haveNet;
    NSMutableArray *newsTitleArray;
    NSMutableArray *carouselTitleArray;
    NSMutableArray *carouselImageArray;
    NSMutableArray *newsImageUrlArray;
}
@property (nonatomic, assign) BOOL isLoading;
@end

@implementation ZHDMainViewController

- (void)viewWillAppear:(BOOL)animated{
    _menuButton.hidden = NO;
    self.navigationController.navigationBar.hidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self createChildView];
    [self setupHeader];
}

- (void)viewWillDisappear:(BOOL)animated{
    _menuButton.hidden = YES;
}

- (void)createChildView{
    //初始化数据库
    cacheManager = [ZHDCacheManager sharedManager];
    [cacheManager createNewsTable];
    
    self.days = -1;
    self.data = [NSMutableArray new];
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    self.IDArray = [NSMutableArray array];
    
    //设置导航栏背景图片
    UIImage *colorImage = [ZHDMainViewController createImageWithColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBackgroundImage:colorImage forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;

    //设置导航栏上的菜单按钮
    _menuButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _menuButton.hidden = NO;
    [_menuButton setImage:[UIImage imageNamed:@"菜单"] forState:UIControlStateNormal];
    [_menuButton setTintColor:[UIColor whiteColor]];
    [_menuButton addTarget:self action:@selector(openCloseMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:_menuButton];
    [_menuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.navigationController.navigationBar.mas_left).with.offset(15);
        make.top.equalTo(self.navigationController.navigationBar.mas_top).with.offset(10);
        make.bottom.equalTo(self.navigationController.navigationBar.mas_bottom).with.offset(-10);
        make.width.equalTo(@30);
    }];
    
    //设置tableView
    self.mainView = [[ZHDMainView alloc] initWithFrame:self.view.bounds];
    self.mainView.tableView.delegate = self;
    self.mainView.tableView.dataSource = self;
    _mainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mainView];
    self.mainView.delegate = self;
    
    //网络请求数据
    [self postStories];
    self.days++;
    
}

/**侧边栏的展开和关闭*/
- (void)openCloseMenu: (UIButton *)sender
{
    [self.navigationController.parentViewController performSelector:@selector(openCloseMenu)];
}

//将请求得的数据放到主界面
-(void)postStories{
    self.isLoading = YES;
    if (self.days == -1) {
        [[ZHDNowManager sharedManager] requestNowStoriesWith:self.days Success:^(ZHDTotalJSONModel *resultModel) {
            NSLog(@"传值成功1");
            self.totalModel = resultModel;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mainView.tableView reloadData];
            });
            self.isLoading = NO;
            
            //设置轮播图图片
            NSMutableArray *imageAarray = [NSMutableArray new];
            NSMutableArray *titleAarray = [NSMutableArray new];
            for (ZHDTop_storiesModel *ts in self.totalModel.top_stories) {
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:ts.image]];
                UIImage *image = [UIImage imageWithData:data];
                [imageAarray addObject:image];
                [titleAarray addObject:ts.title];
            }
            //添加ID数组
            for (ZHDStoriesJSONModel *story in self.totalModel.stories) {
                [self.IDArray addObject:story.id];
            }
            
            self->haveNet = YES;    //判断是否有网
            [self->cacheManager resetAllData];
            [self->cacheManager insertNewsTableModel:resultModel];
            [self->cacheManager insertCarouselImages:imageAarray :resultModel];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mainView.carousel setImages:imageAarray titles:titleAarray];
                self.mainView.tableView.tableHeaderView = self.mainView.carousel;
                [self.mainView.tableView reloadData];
            });

        } Failure:^(NSError *error) {
            self->haveNet = NO;
            //设置缓存的标题数组
            self->newsTitleArray = [NSMutableArray array];
            self->newsTitleArray = [self->cacheManager getNewsTitles];
            self->carouselTitleArray = [NSMutableArray array];
            self->carouselTitleArray = [self->cacheManager getCarouselTitles];
            self->carouselImageArray = [NSMutableArray array];
            self->carouselImageArray = [self->cacheManager getCarouselImages];
            self->newsImageUrlArray = [NSMutableArray array];
            self->newsImageUrlArray = [self->cacheManager getNewsImages];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mainView.carousel setImages:self->carouselImageArray titles:self->carouselTitleArray];
                [self.mainView.tableView reloadData];
            });
        }];
    } else{
        [[ZHDNowManager sharedManager] requestRecentStoriesWith:self.days :self.data Success:^(NSMutableArray *storiesArray) {
            NSLog(@"传值成功2");
            self.data = storiesArray;

            for (int i = 0; i < self.data.count; i++) {
                for (ZHDStoriesJSONModel *story in self.data[i]) {
                    [self.IDArray addObject:[NSString stringWithFormat:@"%@", story.id]];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mainView.tableView reloadData];
            });
            self.isLoading = NO;
            self->haveNet = YES;    //判断是否有网
        } Failure:^(NSError *error) {
            self->haveNet = NO;
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.13 * self.mainView.frame.size.height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (haveNet == YES) {
        return self.days + 1;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (haveNet == YES) {
        if (section == 0) {
            return self.totalModel.stories.count;
        } else{
            return [self.data[section-1] count];
        }
    } else {
        return newsTitleArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    } else {
        NSDate *date = [[NSDate alloc] init];
        
        _headerView = [[ZHDHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        _headerView.lable.text = [ZHDDateUtils getDate:date :-section];
        _headerView.lable.tag = section;
        return _headerView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    } else return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (haveNet == YES) {
        if (indexPath.section == 0) {
            self.mainView.tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            self.mainView.tableViewCell.label.text = [self.totalModel.stories[indexPath.row] title];
            
            NSString *str = [self.totalModel.stories[indexPath.row] images][0];
            [self.mainView.tableViewCell.rightImageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
            
            return self.mainView.tableViewCell;
        } else{
            self.mainView.tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            ZHDStoriesJSONModel *story = self.data[indexPath.section-1][indexPath.row];
            self.mainView.tableViewCell.label.text = story.title;
            [self.mainView.tableViewCell.rightImageView sd_setImageWithURL:[NSURL URLWithString:story.images[0]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
            
            return self.mainView.tableViewCell;
        }
    } else {
        self.mainView.tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        self.mainView.tableViewCell.label.text = newsTitleArray[indexPath.row];

        [self.mainView.tableViewCell.rightImageView sd_setImageWithURL:[NSURL URLWithString:newsImageUrlArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
        
        return self.mainView.tableViewCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHDDetailsViewController *detailsViewController = [[ZHDDetailsViewController alloc] init];
    if (indexPath.section == 0) {
        detailsViewController.ID = [self.totalModel.stories[indexPath.row] id];
        detailsViewController.IDArray = [[NSMutableArray alloc] initWithArray:_IDArray copyItems:YES];
        detailsViewController.days = self.days;
        if (indexPath.row + 2 >= self.IDArray.count && haveNet == YES) {
            [detailsViewController postID];
        }
        [self.navigationController pushViewController:detailsViewController animated:NO];
    } else{
        ZHDStoriesJSONModel *story = self.data[indexPath.section-1][indexPath.row];
        detailsViewController.ID = [NSString stringWithFormat:@"%@", story.id];
        detailsViewController.IDArray = [[NSMutableArray alloc] initWithArray:_IDArray copyItems:YES];
        
        detailsViewController.days = self.days;
        if (indexPath.row + 2 >= self.IDArray.count && haveNet == YES) {
            detailsViewController.days++;
            [detailsViewController postID];
        }
        [self.navigationController pushViewController:detailsViewController animated:NO];
    }
}

//mainView的代理方法，轮播图的点击事件处用
- (void)pass:(NSInteger)index{
    ZHDDetailsViewController *detailsViewController = [[ZHDDetailsViewController alloc] init];
    detailsViewController.ID = [self.totalModel.top_stories[index] id];
    detailsViewController.IDArray = self.IDArray;
    [self.navigationController pushViewController:detailsViewController animated:YES];
}


//设置图片透明度
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

//设置纯色图片
+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//if (scrollView.contentOffset.y < 0.1245 * self.mainView.frame.size.height * self.totalModel.stories.count + 200)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //下拉刷新所需属性
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize contentSize = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = contentSize.height;
    float reload_distance = 10;
    
    if (scrollView.contentOffset.y < 0.13 * self.mainView.frame.size.height * self.totalModel.stories.count + 300) {
        // 设置状态栏颜色
        self.statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        if ([self.statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
            self.statusBar.backgroundColor = [UIColor clearColor];
        }
        
        //设置tableView内边距
        self.mainView.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        self.navigationController.navigationBar.hidden = NO;
        self.navigationItem.title = @"今日热闻";
        
        UIImage *colorImage = [ZHDMainViewController createImageWithColor:[UIColor colorWithRed:0.00f green:0.53f blue:0.85f alpha:1.00f]];
        UIImage *colorLastImage = [ZHDMainViewController imageByApplyingAlpha:scrollView.contentOffset.y / 200.0 image:colorImage];
        
        [self.navigationController.navigationBar setBackgroundImage:colorLastImage forBarMetrics:UIBarMetricsDefault];
//        NSLog(@"----NO.1--%f--", scrollView.contentOffset.y);
        
        if (scrollView.contentOffset.y > 0.13 * self.mainView.frame.size.height * self.totalModel.stories.count + 200 - self.view.frame.size.height) {
            if (y > h + reload_distance - 0.13 * self.mainView.frame.size.height) {
                if (self.isLoading) {
                    return;
                } else{
                    self.days++;
                    [self postStories];
                }
            }
        }
    } else{
        //设置状态栏颜色
        self.statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        if ([self.statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
            self.statusBar.backgroundColor = [UIColor colorWithRed:0.00f green:0.53f blue:0.85f alpha:1.00f];
        }
        self.mainView.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        self.navigationController.navigationBar.hidden = YES;
//        NSLog(@"----NO.2--%f--", scrollView.contentOffset.y);

        if (y > h + reload_distance - 0.13 * self.mainView.frame.size.height) {
            if (self.isLoading) {
                return;
            } else{
                self.days++;
                [self postStories];
            }
        }
    }
}

- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshView];
    
    // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeader addToScrollView:self.mainView.tableView];
    
    __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
    __weak typeof(self) weakSelf = self;
    refreshHeader.beginRefreshingOperation = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf postStories];
            [weakRefreshHeader endRefreshing];
        });
    };
    
    // 进入页面自动加载一次数据
    [refreshHeader autoRefreshWhenViewDidAppear];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Do something next year
@end
