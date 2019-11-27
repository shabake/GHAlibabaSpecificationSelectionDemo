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
#import "ToastTool.h"
#import "GHSpecificationSelectionImageModel.h"
#import "GHPopView.h"

@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic , strong) NSMutableArray *dataArray;

@property (nonatomic , strong) GHAlibabaSpecificationSelection *alibabaSpecificationSelection;

@property (nonatomic , strong) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"GHAlibabaSpecificationSelection";
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.webView = webView;
    webView.scrollView.backgroundColor = [UIColor whiteColor];
    webView.delegate = self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"GHAlibabaSpecificationSelectionDemo" ofType:@"html"];
     [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    [self.view addSubview:webView];
    UIButton *show = [[UIButton alloc]init];
    [show setTitle:@"弹出" forState:UIControlStateNormal];
    [show setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [show sizeToFit];
    [show addTarget:self action:@selector(clickShow) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:show];
}

- (void)webViewDidStartLoad:(UIWebView *)webView API_DEPRECATED("No longer supported.", ios(2.0, 12.0)) {
    [ToastTool makeToastActivity:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView API_DEPRECATED("No longer supported.", ios(2.0, 12.0)) {
    [ToastTool hideToastActivity:self.view];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error API_DEPRECATED("No longer supported.", ios(2.0, 12.0)) {
    [ToastTool hideToastActivity:self.view];
}

- (void)clickShow {
    [self loadData];
}

- (void)loadData {
    [ToastTool makeToastActivity:self.view];
    weakself(self);
    NSString *url = @"http://mock-api.com/7zxXywz3.mock/data";
    [[GHHTTPSessionManager sharedManager] getGoodDetailsWithUrl:url finishedBlock:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *colors = dict[@"color"];
        NSArray *data = dict[@"data"];
        NSDictionary *sectePrice = dict[@"sectePrice"];
        NSMutableArray *specifications = [NSMutableArray array];
        for (NSDictionary *dataDict in data) {
            GHSpecificationSelectionModel *specificationSelectionModel = [GHSpecificationSelectionModel mj_objectWithKeyValues:dataDict];
            NSArray *images = dataDict[@"images"];
            NSMutableArray *imagesArray = [NSMutableArray array];
            for (NSDictionary *imageDict in images) {
                GHSpecificationSelectionImageModel *specificationSelectionImageModel = [GHSpecificationSelectionImageModel mj_objectWithKeyValues:imageDict];
                [imagesArray addObject:specificationSelectionImageModel];
            }
            specificationSelectionModel.images = imagesArray.copy;
            [specifications addObject:specificationSelectionModel];
        }
        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSInteger i = 0; i < colors.count; i++) {
            GHAlibabaSpecificationSelectionModel *alibabaSpecificationSelectionModel = [[GHAlibabaSpecificationSelectionModel alloc]init];
            NSString *colorStr = colors[i];
            for (NSInteger j = 0; j < specifications.count; j++) {
                GHSpecificationSelectionModel *specificationSelectionModel = specifications[j];
                NSMutableArray *dataArray = [NSMutableArray array];
                if ([specificationSelectionModel.color isEqualToString:colorStr]) {
                    [dataArray addObject:specificationSelectionModel];
                }
                alibabaSpecificationSelectionModel.specifications = dataArray.copy;
            }
            alibabaSpecificationSelectionModel.colorStr = colorStr;
            [dataArray addObject:alibabaSpecificationSelectionModel];
        }
        [ToastTool makeToastActivity:weakSelf.view toastToolCompleteBlock:^{
            [weakSelf.alibabaSpecificationSelection setSkuList:specifications colors:colors sectePrice:sectePrice];
            [weakSelf.alibabaSpecificationSelection show];
        }];
    }];
}

- (GHAlibabaSpecificationSelection *)alibabaSpecificationSelection {
    if (_alibabaSpecificationSelection == nil) {
        _alibabaSpecificationSelection = [[GHAlibabaSpecificationSelection alloc]init];
        _alibabaSpecificationSelection.contentViewHeight = 500;
        _alibabaSpecificationSelection.getDataBlock = ^(NSArray * _Nonnull dataArray) {
            NSLog(@"用户选择的数据%@",dataArray);
            NSMutableString *string = [NSMutableString string];
            for (NSDictionary *dict in dataArray) {
                [string appendFormat:@"颜色:%@  数量:%@  id:%@\n",dict[@"color"],dict[@"skuNum"],dict[@"skuId"]];
            }
            KAlert(@"用户选择的数据", string);
        };
    }
    return _alibabaSpecificationSelection;
}

@end
