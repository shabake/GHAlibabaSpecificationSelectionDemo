//
//  GHHTTPSessionManager.m
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/10/18.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import "GHHTTPSessionManager.h"

@implementation GHHTTPSessionManager

+ (instancetype)sharedManager {
    
    static GHHTTPSessionManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseUrl = [NSURL URLWithString:@""];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = 30;
        [_instance.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        _instance = [[self alloc] initWithBaseURL:baseUrl sessionConfiguration:config];
        _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/plain", @"text/javascript", nil];
    });
    return _instance;
}

- (void)getGoodDetailsWithUrl:(NSString *)url finishedBlock:(FinishedBlock)finishedBlock {
    [[GHHTTPSessionManager sharedManager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finishedBlock(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finishedBlock(nil,error);
    }];
}

@end
