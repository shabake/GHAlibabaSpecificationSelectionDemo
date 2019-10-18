//
//  GHHTTPSessionManager.h
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/10/18.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^FinishedBlock)(id responseObject,NSError *error);

@interface GHHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

- (void)getGoodDetailsWithUrl:(NSString *)url finishedBlock:(FinishedBlock)finishedBlock;

@end

NS_ASSUME_NONNULL_END
