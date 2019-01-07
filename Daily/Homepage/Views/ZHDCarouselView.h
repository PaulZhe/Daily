//
//  ZZCarouseView.h
//  Daily
//
//  Created by 小哲的DELL on 2018/10/25.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHDCarouselView;
@protocol ZHDCarouselViewDelegate <NSObject>
@optional
 //点击图片的回调事件
- (void)carouselView:(ZHDCarouselView *)carouselView indexOfClickedImageBtn:(NSUInteger)index;
@end

@interface ZHDCarouselView : UIView
//传入图片数组
@property (nonatomic, copy) NSArray *images;
@property (nonatomic, copy) NSArray *titles;
//pageControl颜色设置
@property (nonatomic, strong) UIColor *currentPageColor;
@property (nonatomic, strong) UIColor *pageColor;
//是否竖向滚动
@property (nonatomic, assign, getter=isScrollDorectionPortrait) BOOL scrollDorectionPortrait;

@property (weak, nonatomic) id<ZHDCarouselViewDelegate> delegate;

- (void)setImages:(NSArray *)images titles:(NSArray *)titles;
@end

