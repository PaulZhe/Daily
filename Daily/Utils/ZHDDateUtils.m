//
//  ZHDDateUtils.m
//  Daily
//
//  Created by 小哲的DELL on 2018/11/6.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "ZHDDateUtils.h"

@implementation ZHDDateUtils

//获取分组头视图的月日及星期
+ (NSString *)getDate:(NSDate *)date :(NSInteger)i{
    NSString *dateString, *str;
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    date = [[NSDate alloc] initWithTimeIntervalSinceNow:i*60*60*24];
    comps =[calendar components:(NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday |NSCalendarUnitWeekdayOrdinal)
                       fromDate:date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"MM月dd日 "];
    switch (comps.weekday) {
        case 1:
            str = @"星期日";
            break;
        case 2:
            str = @"星期一";
            break;
        case 3:
            str = @"星期二";
            break;
        case 4:
            str = @"星期三";
            break;
        case 5:
            str = @"星期四";
            break;
        case 6:
            str = @"星期五";
            break;
        default:
            str = @"星期六";
            break;
    }
    dateString = [NSString stringWithFormat:@"%@%@", [dateFormatter stringFromDate:date], str];
    return dateString;
}

//获取过去的日期
+ (NSString *)dateStringBeforeDays:(NSInteger)days {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *before = [NSDate dateWithTimeIntervalSinceNow:-days*60*60*24];
    
    return [formatter stringFromDate:before];
}

// 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒
+ (NSString *)getDateStringWithTimeStr:(NSString *)str{
    NSTimeInterval time=[str doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}

@end
