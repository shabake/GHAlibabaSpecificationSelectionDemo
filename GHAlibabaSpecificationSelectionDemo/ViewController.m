//
//  ViewController.m
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import "ViewController.h"
#import "GHAlibabaSpecificationSelection.h"
#import "GHScrollView.h"

@interface ViewController ()<GHScrollViewScrollViewDelegate>
@property (nonatomic , strong) GHScrollView *scrollView;
@property (nonatomic, strong) NSArray *contents;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _contents = @[@"A", @"B", @"C", @"D", @"E",@"F",@"G",@"J",@"K"];

//    [self.view addSubview:self.scrollView];
//    self.scrollView.delegateForReuseableScrollView = self;
//    [self.scrollView setupViews];
}

-(UIView*)setupView:(UIView *)view toPage:(NSUInteger)toPage
{
    NSLog(@"toPage%lu",(unsigned long)toPage);
//    if (view == nil) {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
//        view = vc.view;
//    }
    UILabel *contentView = [[UILabel alloc]init];
    contentView.text = self.contents[toPage];
    return contentView;
}

-(NSUInteger)numOfPages
{
    return 10;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    GHAlibabaSpecificationSelection *alibabaSpecificationSelection = [[GHAlibabaSpecificationSelection alloc]init];
     [alibabaSpecificationSelection show];
}

- (GHScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[GHScrollView alloc]init];
         _scrollView.frame = CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
        _scrollView.backgroundColor = [UIColor redColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, 0);
        _scrollView.delegateForReuseableScrollView = self;
        _scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

@end
