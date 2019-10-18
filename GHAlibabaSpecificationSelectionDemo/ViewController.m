//
//  ViewController.m
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import "ViewController.h"
#import "GHAlibabaSpecificationSelection.h"
#import "GHHTTPSessionManager.h"
#import "MJExtension.h"
#import "GHSpecificationSelectionModel.h"
#import "GHAlibabaSpecificationSelectionModel.h"

#ifdef DEBUG
#define NSLog(format, ...) printf("%s\n", [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

@interface ViewController ()

@property (nonatomic , strong) NSMutableArray *dataArray;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)loadData {
    NSString *url = @"http://5da9613ee44c790014cd5598.mockapi.io/GHGoodDetails/mac";
    [[GHHTTPSessionManager sharedManager] getGoodDetailsWithUrl:url finishedBlock:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
         NSDictionary *dict = responseObject[0];
        NSArray *colors = dict[@"color"];
        NSArray *data = dict[@"data"];
        NSMutableArray *specifications = [NSMutableArray array];
        for (NSDictionary *dataDict in data) {
            GHSpecificationSelectionModel *specificationSelectionModel = [GHSpecificationSelectionModel mj_objectWithKeyValues:dataDict];
            [specifications addObject:specificationSelectionModel];
        }
//
        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSInteger i = 0; i < colors.count; i++) {
            GHAlibabaSpecificationSelectionModel *alibabaSpecificationSelectionModel = [[GHAlibabaSpecificationSelectionModel alloc]init];
            NSString *colorStr = colors[i];
            for (NSInteger j = 0; j < specifications.count; j++) {
                GHSpecificationSelectionModel *specificationSelectionModel = specifications[j];
                NSMutableArray *dataArray = [NSMutableArray array];
//                if ([specificationSelectionModel.color isEqualToString:colorStr]) {
                    [dataArray addObject:specificationSelectionModel];
//                }
                alibabaSpecificationSelectionModel.specifications = dataArray.copy;
            }
            alibabaSpecificationSelectionModel.colorStr = colorStr;
            [dataArray addObject:alibabaSpecificationSelectionModel];
        }
        self.dataArray = dataArray;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    GHAlibabaSpecificationSelection *alibabaSpecificationSelection = [[GHAlibabaSpecificationSelection alloc]init];
    alibabaSpecificationSelection.dataArray = self.dataArray;
    [alibabaSpecificationSelection show];
}

@end
