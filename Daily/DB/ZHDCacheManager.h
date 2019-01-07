//
//  ZHDCacheManager.h
//  Daily
//
//  Created by 小哲的DELL on 2018/12/19.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHDTop_storiesModel.h"

@interface ZHDCacheManager : NSObject

+ (instancetype)sharedManager;
- (BOOL)createNewsTable;
- (BOOL)insertNewsTableModel:(ZHDTotalJSONModel *)model;
- (NSMutableArray *)getNewsTitles;
- (BOOL)resetAllData;
- (NSMutableArray *)getCarouselTitles;
- (BOOL)insertCarouselImages:(NSMutableArray *)imageArray :(ZHDTotalJSONModel *)model;
- (NSMutableArray *)getCarouselImages;
- (NSMutableArray *)getNewsImages;
@end
