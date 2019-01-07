//
//  ZHDDateUtils.h
//  Daily
//
//  Created by 小哲的DELL on 2018/11/6.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHDDateUtils : NSObject

+ (NSString *)getDate:(NSDate *)date :(NSInteger)i;
+ (NSString *)dateStringBeforeDays:(NSInteger)days;
+ (NSString *)getDateStringWithTimeStr:(NSString *)str;

@end
