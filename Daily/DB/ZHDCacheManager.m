//
//  ZHDCacheManager.m
//  Daily
//
//  Created by 小哲的DELL on 2018/12/19.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "ZHDCacheManager.h"
#import <FMDB.h>
#import <UIKit/UIKit.h>

@interface ZHDCacheManager ()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation ZHDCacheManager

static ZHDCacheManager *manager;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZHDCacheManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (BOOL)createNewsTable {
    NSString *docuPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"news.db"];
    NSLog(@"%@", docuPath);
    self.db = [FMDatabase databaseWithPath:dbPath];
    if (![_db open]) {
        NSLog(@"db open fail");
        return NO;
    }
    NSString *newsSql = @"CREATE TABLE 'news' ('title' VARCHAR(255), 'url' TEXT)";
    NSString *carouselSql = @"CREATE TABLE 'carousel' ('title' VARCHAR(255), 'image' BLOB)";
    BOOL isSuccess = NO;
    isSuccess = [_db executeUpdate:newsSql];
    isSuccess = [_db executeUpdate:carouselSql];
    NSLog(@"建表成功");
    [_db close];
    return isSuccess;
}

- (BOOL)insertNewsTableModel:(ZHDTotalJSONModel *)model {
    BOOL isSuccess = NO;
    if ([_db open]) {
        for (ZHDStoriesJSONModel *story in model.stories) {
            isSuccess = [self.db executeUpdate:@"INSERT INTO news (title, url) VALUES (?,?)", story.title, story.images[0]];
        }

        [_db close];
        isSuccess = YES;
    }
    return isSuccess;
}

- (BOOL)insertCarouselImages:(NSMutableArray *)imageArray :(ZHDTotalJSONModel *)model{
    BOOL isSuccess = NO;
    if ([_db open]) {
        int i = 0;
        for (ZHDTop_storiesModel *top_story in model.top_stories) {
            NSData *imageData = UIImagePNGRepresentation(imageArray[i]);
            isSuccess = [self.db executeUpdate:@"INSERT INTO carousel (title, image) VALUES (?,?)", top_story.title, imageData];
            i++;
        }
        [_db close];
        isSuccess = YES;
    }
    return isSuccess;
}

- (NSMutableArray *)getCarouselImages {
    NSMutableArray *resultArray = [NSMutableArray array];
    if ([_db open]) {
        NSString *sql = @"SELECT * FROM carousel";
        FMResultSet *resultSet = [_db executeQuery:sql];
        while ([resultSet next]) {
            UIImage *image = [UIImage imageWithData:[resultSet dataForColumn:@"image"]];
            [resultArray addObject:image];
        }
    } else {
        NSLog(@"打开失败");
    }
    return resultArray;
}

- (NSMutableArray *)getNewsTitles {
    NSMutableArray *resultArray = [NSMutableArray array];
    if ([_db open]) {
        NSString *sql = @"SELECT * FROM news";
        FMResultSet *resultSet = [_db executeQuery:sql];
        while ([resultSet next]) {
            [resultArray addObject:[resultSet stringForColumn:@"title"]];
        }
    } else {
        NSLog(@"打开失败");
    }
    return resultArray;
}

- (NSMutableArray *)getNewsImages {
    NSMutableArray *resultArray = [NSMutableArray array];
    if ([_db open]) {
        NSString *sql = @"SELECT * FROM news";
        FMResultSet *resultSet = [_db executeQuery:sql];
        while ([resultSet next]) {
            [resultArray addObject:[resultSet stringForColumn:@"url"]];
        }
    } else {
        NSLog(@"打开失败");
    }
    return resultArray;
}


- (NSMutableArray *)getCarouselTitles {
    NSMutableArray *resultArray = [NSMutableArray array];
    if ([_db open]) {
        NSString *sql = @"SELECT * FROM carousel";
        FMResultSet *resultSet = [_db executeQuery:sql];
        while ([resultSet next]) {
            [resultArray addObject:[resultSet stringForColumn:@"title"]];
        }
    } else {
        NSLog(@"打开失败");
    }
    return resultArray;
}

- (BOOL)resetAllData {
    BOOL isSuccess = NO;
    
    if ([_db open]) {
        isSuccess = [_db executeUpdate:@"DELETE FROM news"];
        isSuccess = [_db executeUpdate:@"DELETE FROM carousel"];
        [_db close];
    }
    
    return isSuccess;
}

@end
