//
//  ZHDNowManager.m
//  Daily
//
//  Created by 小哲的DELL on 2018/11/1.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "ZHDNowManager.h"
#import "ZHDDateUtils.h"

static ZHDNowManager *manager = nil;

@implementation ZHDNowManager

+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[ZHDNowManager alloc] init];
        }
    });
    return manager;
}

- (void)requestNowStoriesWith:(NSInteger)days Success:(ZHDGetStories)succeedBlock Failure: (ErrorHandel)failBlock;{
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *url = nil;
    url = @"https://news-at.zhihu.com/api/4/news/latest";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *requestDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            ZHDTotalJSONModel *resultTotal = [[ZHDTotalJSONModel alloc] initWithDictionary:requestDictionary error:nil];
            
            succeedBlock(resultTotal);
        } else {
            failBlock(error);
        }
        
    }];
    [dataTask resume];
}

- (void)requestRecentStoriesWith:(NSInteger)days :(NSMutableArray *)mutableArray Success:(ZHDGetRecentStories)succeedBlock Failure: (ErrorHandel)failBlock {
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *url = nil;
    url = [@"https://news-at.zhihu.com/api/4/news/before/"
           stringByAppendingString:[ZHDDateUtils dateStringBeforeDays:days-1]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *requestDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSArray *storiesJSON = requestDictionary[@"stories"];
            NSMutableArray *stories = [NSMutableArray new];
            for (NSDictionary *json in storiesJSON) {
                ZHDStoriesJSONModel *story = [[ZHDStoriesJSONModel alloc] initWithJSON:json];
                [stories addObject:story];
            }
            [mutableArray addObject:[NSArray arrayWithArray:stories]];
            
            succeedBlock(mutableArray);
        } else{
            failBlock(error);
        }
       
    }];
    [dataTask resume];
}

- (void)requestRecentIDWith:(NSInteger)days :(NSMutableArray *)mutableArray Success:(ZHDGetRecentStories)succeedBlock Failure: (ErrorHandel)failBlock{
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *url = nil;
    url = [@"https://news-at.zhihu.com/api/4/news/before/"
           stringByAppendingString:[ZHDDateUtils dateStringBeforeDays:days-1]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            
            NSDictionary *requestDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSArray *storiesJSON = requestDictionary[@"stories"];
            for (NSDictionary *json in storiesJSON) {
                ZHDStoriesJSONModel *story = [[ZHDStoriesJSONModel alloc] initWithJSON:json];
                [mutableArray addObject:[NSString stringWithFormat:@"%@", story.id]];
            }
            
            succeedBlock(mutableArray);
        } else {
            failBlock(error);
        }
        
    }];
    [dataTask resume];
}

@end
