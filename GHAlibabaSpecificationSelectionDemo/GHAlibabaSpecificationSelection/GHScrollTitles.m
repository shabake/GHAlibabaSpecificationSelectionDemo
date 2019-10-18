//
//  GHScrollTitles.m
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import "GHScrollTitles.h"
#import "UIView+Extension.h"

@interface GHScrollTitles()

/**
 *  左侧剪头
 */
@property (nonatomic , strong) UIButton *leftButton;

/**
 *  右侧剪头
 */
@property (nonatomic , strong) UIButton *rightButton;
@property (nonatomic , strong) UIView *bottomLine;
@property (nonatomic , strong) UIScrollView *scrollView;

/**
 *  装label的数组
 */
@property (nonatomic , strong) NSMutableArray *labels;

/**
 *  记录当前序号
 */
@property (nonatomic , assign) NSInteger currentIndex;

/**
 *  指示器
 */
@property (nonatomic , strong) UIView *indicator;

@end
@implementation GHScrollTitles

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.bottomLine];
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)setTitles:(NSMutableArray *)titles {
    _titles = titles;
    
    for (UILabel *label in self.labels) {
        [label removeFromSuperview];
    }
    
    for (NSInteger index = 0 ; index < titles.count; index++) {
        UILabel *label = [[UILabel alloc]init];
        label.text = titles[index];
        label.tag = index;
        label.userInteractionEnabled = YES;
        label.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClick:)];
        [label addGestureRecognizer:tap];
        [self.labels addObject:label];
    }
    
    CGFloat width = self.scrollView.frame.size.width / 3.01f;
    self.scrollView.contentSize = CGSizeMake(width * titles.count, 0);
    [self.indicator removeFromSuperview];
    UIView *indicator = [[UIView alloc]init];
    self.indicator = indicator;
    indicator.backgroundColor = [UIColor redColor];
    indicator.frame = CGRectMake((width -width * 0.25) * 0.5,CGRectGetMaxY(self.leftButton.frame) - 1, width * 0.25, 1);
    [self.scrollView addSubview:indicator];
}

- (void)labelClick:(UITapGestureRecognizer *)tap{
    
    NSInteger index = (NSInteger)tap.view.tag;
    self.currentIndex = index;
    if (self.didClickTitleBlock) {
        self.didClickTitleBlock(index);
    }
}

- (void)setMenusScrollView:(CGPoint)contentOffset{
    
    CGFloat scale = contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    if (scale < 0 || scale > self.scrollView.subviews.count - 1 - 1) return;
    self.currentIndex = scale;
    for (UILabel *label in self.labels) {
        label.textColor = [UIColor blackColor];
    }
    
    UILabel *label = self.labels[self.currentIndex];
    label.textColor = [UIColor redColor];
    CGRect frame = self.indicator.frame;
    frame.origin.x =  label.x + (label.width - self.indicator.width) * 0.5;
    self.indicator.frame = frame;
}

- (void)setMenusScrollViewEnd:(CGPoint)endOffset{
    NSInteger index = endOffset.x / [UIScreen mainScreen].bounds.size.width;
    UILabel *label = self.labels[index];
    CGFloat width = self.scrollView.frame.size.width;
    CGPoint titleOffset = self.scrollView.contentOffset;
    titleOffset.x = label.center.x - width * 0.5;
    if (titleOffset.x < 0) titleOffset.x = 0;
    CGFloat maxTitleOffsetX = self.scrollView.contentSize.width - width;
    if (maxTitleOffsetX < titleOffset.x) titleOffset.x = maxTitleOffsetX;
    [self.scrollView setContentOffset:titleOffset animated:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.scrollView.frame.size.width / 3.01f;
    for (NSInteger index = 0; index < self.labels.count; index++) {
        UILabel *label = self.labels[index];
        label.frame = CGRectMake(index * width, 0, width, self.scrollView.frame.size.height);
        [self.scrollView addSubview:label];
    }
}

- (void)clicRightButton {
 
    if (self.currentIndex == self.labels.count - 1) {// 处理向左滚动越界
        return;
    }
    if (self.didClickRightBlock) {
        self.didClickRightBlock();
    }
}

- (void)clickLeftButton {
   if (self.currentIndex == 0) {// 处理向右滚动越界
        return;
    }
    if (self.didClickLeftBlock) {
        self.didClickLeftBlock();
    }
}

- (NSMutableArray *)labels {
    if (_labels == nil) {
        _labels = [NSMutableArray array];
    }
    return _labels;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = CGRectMake(CGRectGetMaxX(self.leftButton.frame), 0, [UIScreen mainScreen].bounds.size.width - CGRectGetMaxX(self.leftButton.frame) - 50 , 50);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 4, 0);
    }
    return _scrollView;
}

- (UIView *)bottomLine {
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = [UIColor lightGrayColor];
        _bottomLine.frame = CGRectMake(0,CGRectGetMaxY(self.leftButton.frame) - 1, [UIScreen mainScreen].bounds.size.width, 0.3);
    }
    return _bottomLine;
}

- (UIButton *)rightButton {
    if (_rightButton == nil) {
        _rightButton = [[UIButton alloc]init];
        _rightButton.frame =  CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 0, 50, 50);
        UIView *line = [[UIView alloc]init];
        line.frame = CGRectMake(0, 10, 0.3, 30);
        line.backgroundColor = [UIColor lightGrayColor];
        [_rightButton addSubview:line];
        [_rightButton setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(clicRightButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UIButton *)leftButton {
    if (_leftButton == nil) {
        _leftButton = [[UIButton alloc]init];
        [_leftButton setImage:[UIImage imageNamed:@"leftArrow"] forState:UIControlStateNormal];
        _leftButton.frame =  CGRectMake(0, 0, 50, 50);
        [_leftButton addTarget:self action:@selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
        UIView *line = [[UIView alloc]init];
        line.frame = CGRectMake(50 - 1, 10, 0.3, 30);
        line.backgroundColor = [UIColor lightGrayColor];
        [_leftButton addSubview:line];
    }
    return _leftButton;
}

@end
