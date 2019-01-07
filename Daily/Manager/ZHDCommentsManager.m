//
//  ZHDCommentsManager.m
//  Daily
//
//  Created by 小哲的DELL on 2018/11/24.
//  Copyright © 2018年 小哲的DELL. All rights reserved.
//

#import "ZHDCommentsManager.h"

static ZHDCommentsManager *manager = nil;

@implementation ZHDCommentsManager

+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[ZHDCommentsManager alloc] init];
        }
    });
    return manager;
}

- (void)requestCommentsWithID:(NSString *)ID Success:(ZHDGetComments)succeedBlock Failure: (ErrorHandel)failBlock {
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *url = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story-extra/%@", ID];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *requestDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            ZHDCommentsModel *commentsModel = [[ZHDCommentsModel alloc] initWithDictionary:requestDictionary error:nil];
            
            succeedBlock(commentsModel);
        } else{
            failBlock(error);
        }
        
    }];
    [dataTask resume];
}

-(void)requestLongCommentsContentWithID:(NSString *)ID Success:(ZHDGetCommentsContent)succeedBlock Failure: (ErrorHandel)failBlock {
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *url = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/long-comments", ID];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *requestDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            ZHDCommentsTotalModel *longCommentsModel = [[ZHDCommentsTotalModel alloc] initWithDictionary:requestDictionary error:nil];
            //        NSLog(@"%@=====", longCommentsModel);
            
            succeedBlock(longCommentsModel);
        } else {
            failBlock(error);
        }
        
    }];
    [dataTask resume];
}

-(void)requestShortCommentsContentWithID:(NSString *)ID Success:(ZHDGetCommentsContent)succeedBlock Failure: (ErrorHandel)failBlock {
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *url = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/short-comments", ID];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *requestDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            ZHDCommentsTotalModel *shortCommentsModel = [[ZHDCommentsTotalModel alloc] initWithDictionary:requestDictionary error:nil];
            
            succeedBlock(shortCommentsModel);
        } else {
            failBlock(error);
        }
        
    }];
    [dataTask resume];
}

@end
