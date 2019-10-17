//
//  GHAlibabaSpecificationSelection.m
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import "GHAlibabaSpecificationSelection.h"
#import "GHScrollTitles.h"
#import "GHTableView.h"
#import "GHScrollView.h"

#define weakself(self)          __weak __typeof(self) weakSelf = self

@interface GHSpecificationSelectionCell : UITableViewCell

@end

@implementation GHSpecificationSelectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end
@interface GHAlibabaSpecificationSelection()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

/**
 自定义view
 */
@property (nonatomic , strong) GHScrollTitles *scrollTitles;

/**
 自定义view
 */
@property (nonatomic , strong) UIView *backGround;
/**
 图标
 */
@property (nonatomic , strong) UIImageView *icon;
/**
 关闭
 */
@property (nonatomic , strong) UIButton *close;

/**
 sku标题
 */
@property (nonatomic , strong) UILabel *title;

/**
 sku价格
 */
@property (nonatomic , strong) UILabel *price;

/**
 最小起订量
 */
@property (nonatomic , strong) UILabel *minimumOrder;

/**
 *
 */
@property (nonatomic , strong) UIView *shadow;

/**
 *
 */
@property (nonatomic , strong) GHScrollView *scrollView;

/**
 *
 */
@property (nonatomic , strong) UIView *test;

@property (nonatomic , strong) NSMutableArray *arrays;

@property (nonatomic , assign) NSInteger currentPage;

@property (nonatomic , assign) int lastContentOffset;

@property (nonatomic , strong) UITableView *table;

@property (nonatomic , strong) UILabel *t;

@end
@implementation GHAlibabaSpecificationSelection


- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        
        [self addView:self.backGround];
        [self.backGround addSubview:self.icon];
        [self.backGround addSubview:self.close];
        [self.backGround addSubview:self.title];
        [self.backGround addSubview:self.price];
        [self.backGround addSubview:self.minimumOrder];
        [self.backGround addSubview:self.shadow];
        [self.backGround addSubview:self.scrollTitles];
        [self.backGround addSubview:self.scrollView];
        self.currentPage = 0;
        self.contentViewHeight = 500;
        self.scrollTitles.titles = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"].mutableCopy;
        [self setTableViews];
    }
    return self;
}

- (void)setTableViews {
    
    for (NSInteger index = 0; index < self.scrollTitles.titles.count; index++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.scrollView.frame.size.width * index  , 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = NO;
        [tableView registerClass:[GHSpecificationSelectionCell class] forCellReuseIdentifier:@"GHSpecificationSelectionCellID"];
        [self.scrollView addSubview:tableView];
    }
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.scrollTitles.titles.count, 0);
}

#pragma mark - 添加控件 结束
//- (void)sliderView:(FSSliderView *)sliderView index: (NSInteger)index {
///
//}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self.scrollTitles setMenusScrollViewEnd:scrollView.contentOffset];
    CGFloat x = self.scrollView.contentOffset.x;
    //    self.header.headerMData = [self.dataArray by_ObjectAtIndex:x / kScreenWidth];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
          [self scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        [self.scrollTitles setMenusScrollView:scrollView.contentOffset];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.scrollTitles.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GHSpecificationSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHSpecificationSelectionCellID"];
    cell.textLabel.text =  self.scrollTitles.titles[indexPath.row];
    return cell;
}

- (void)clickClose {
    [self dismiss];
}

- (GHScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[GHScrollView alloc]init];
        _scrollView.frame = CGRectMake(0,CGRectGetMaxY(self.scrollTitles.frame), [UIScreen mainScreen].bounds.size.width,500 -CGRectGetMaxY(self.scrollTitles.frame));
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor orangeColor];
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = YES;
    }
    return _scrollView;
}

- (GHScrollTitles *)scrollTitles {
    if (_scrollTitles == nil) {
        _scrollTitles = [[GHScrollTitles alloc]init];
        _scrollTitles.frame = CGRectMake(0, CGRectGetMaxY(self.shadow.frame) + 10, [UIScreen mainScreen].bounds.size.width, 50);
        weakself(self);
        _scrollTitles.didClickTitleBlock = ^(NSInteger tag) {
            CGPoint offset = weakSelf.scrollView.contentOffset;
            offset.x = [UIScreen mainScreen].bounds.size.width * tag;
            [weakSelf.scrollView setContentOffset:offset animated:YES];
        };
    }
    return _scrollTitles;
}

- (UIView *)backGround {
    if (_backGround == nil) {
        _backGround = [[UIView alloc]init];
        _backGround.backgroundColor = [UIColor whiteColor];
    }
    return _backGround;
}

- (UIImageView *)icon {
    if (_icon == nil) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, -20, 100, 100)];
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = 5;
        _icon.backgroundColor = [UIColor redColor];
    }
    return _icon;
}

- (UIButton *)close {
    if (_close == nil) {
        _close = [[UIButton alloc]init];
        [_close setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        _close.frame = CGRectMake(self.frame.size.width - 30 - 10, 20, 30, 30);
        [_close addTarget:self action:@selector(clickClose) forControlEvents:UIControlEventTouchUpInside];
    }
    return _close;
}

- (UIView *)shadow {
    if (_shadow == nil) {
        _shadow = [[UIView alloc]init];
        _shadow.frame = CGRectMake(0, CGRectGetMaxY(self.icon.frame) + 10, [UIScreen mainScreen].bounds.size.width, 10);
        _shadow.backgroundColor = [UIColor whiteColor];
        _shadow.layer.shadowColor = [UIColor blackColor].CGColor;
        _shadow.layer.shadowOffset = CGSizeMake(0, 5);
        _shadow.layer.shadowOpacity = 0.09;
    }
    return _shadow;
}

- (UILabel *)minimumOrder {
    if (_minimumOrder == nil) {
        _minimumOrder = [[UILabel alloc]init];
        _minimumOrder.frame = CGRectMake(CGRectGetMinX(self.price.frame), CGRectGetMaxY(self.price.frame) + 5, 100, 21);
        _minimumOrder.text = @"标题";
    }
    return _minimumOrder;
}

- (UILabel *)price {
    if (_price == nil) {
        _price = [[UILabel alloc]init];
        _price.frame = CGRectMake(CGRectGetMinX(self.title.frame), CGRectGetMaxY(self.title.frame) + 5, 100, 21);
        _price.text = @"标题";
    }
    return _price;
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.frame = CGRectMake(CGRectGetMaxX(self.icon.frame) + 20, 10, 100, 21);
        _title.text = @"标题";
    }
    return _title;
}

- (NSMutableArray *)arrays {
    if (_arrays == nil) {
        _arrays = [NSMutableArray array];
    }
    return _arrays;
}

@end
