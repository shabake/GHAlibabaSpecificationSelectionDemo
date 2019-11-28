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
#import "GHSpecificationSelectionTitleModel.h"
#import "GHSpecificationSelectionImageModel.h"
#import "GHPopView.h"
#import "UIView+ActivityIndicator.h"
#import "UIImage+ViewToImage.h"

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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"GHAlibabaSpecificationSelection" ofType:@"html"];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    [self.view addSubview:webView];
    UIButton *show = [[UIButton alloc]init];
    [show setTitle:@"弹出" forState:UIControlStateNormal];
    show.titleLabel.font = [UIFont systemFontOfSize:14];
    [show setTitleColor:KMainColor forState:UIControlStateNormal];
    [show sizeToFit];
    [show addTarget:self action:@selector(clickShow) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:show];
    [ToastTool makeToastActivity:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView API_DEPRECATED("No longer supported.", ios(2.0, 12.0)) {
    [ToastTool hideToastActivity:self.view];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error API_DEPRECATED("No longer supported.", ios(2.0, 12.0)) {
    [ToastTool hideToastActivity:self.view];
}

- (void)clickShow {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"GHAlibabaSpecificationSelection" message:@"选择类型" preferredStyle:UIAlertControllerStyleActionSheet];
    weakself(self);
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"带颜色导航器" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf loadDataWithNavColorMachine:YES];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"不带颜色导航器" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf loadDataWithNavColorMachine:NO];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)loadDataWithNavColorMachine:(BOOL)isHave {
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
            GHSpecificationSelectionModel *skuModel = [GHSpecificationSelectionModel mj_objectWithKeyValues:dataDict];
            NSArray *images = dataDict[@"images"];
            NSMutableArray *imagesArray = [NSMutableArray array];
            for (NSDictionary *imageDict in images) {
                GHSpecificationSelectionImageModel *specificationSelectionImageModel = [GHSpecificationSelectionImageModel mj_objectWithKeyValues:imageDict];
                [imagesArray addObject:specificationSelectionImageModel];
            }
            skuModel.images = imagesArray.copy;
            [specifications addObject:skuModel];
        }
        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSInteger i = 0; i < colors.count; i++) {
            GHSpecificationSelectionTitleModel *alibabaSpecificationSelectionModel = [[GHSpecificationSelectionTitleModel alloc]init];
            NSString *colorStr = colors[i];
            for (NSInteger j = 0; j < specifications.count; j++) {
                GHSpecificationSelectionModel *skuModel = specifications[j];
                NSMutableArray *dataArray = [NSMutableArray array];
                if ([skuModel.color isEqualToString:colorStr]) {
                    [dataArray addObject:skuModel];
                }
                alibabaSpecificationSelectionModel.skuList = dataArray.copy;
            }
            alibabaSpecificationSelectionModel.color = colorStr;
            [dataArray addObject:alibabaSpecificationSelectionModel];
        }
        [ToastTool makeToastActivity:weakSelf.view toastToolCompleteBlock:^{
            [weakSelf.alibabaSpecificationSelection setSkuList:specifications colors:isHave ? colors:nil sectePrice:sectePrice];
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
