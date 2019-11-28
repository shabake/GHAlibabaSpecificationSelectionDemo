//
//  GHPopView.m
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import "GHPopView.h"

/**
 * 动画时间
 */
#define animateDuration 0.3

#define WS(weakSelf)            __weak __typeof(&*self)weakSelf = self;

#define kKeyWindow  [UIApplication sharedApplication].keyWindow

#define kScreenWidth                ([UIScreen mainScreen].bounds.size.width)   //屏幕宽度
#define kScreenHeight               ([UIScreen mainScreen].bounds.size.height)

#define IS_PhoneXAll \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define kSafeAreaBottomHeight       (IS_PhoneXAll ? 34.0f : 0.0f)

@interface GHPopView()

/**
 * 背景
 */
@property (nonatomic, strong) UIButton *backView;

@end
@implementation GHPopView

- (void)setContentViewHeight:(CGFloat)contentViewHeight {
    _contentViewHeight = contentViewHeight;
}

- (instancetype)init {
    if (self == [super init]) {
        [self configuration];
        [self configDefaultUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self configuration];
        [self configDefaultUI];
    }
    return self;
}

- (void)configuration {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
}

- (void)configDefaultUI {
    self.frame = kKeyWindow.bounds;
    [self addSubview:self.backView];
    [self.backView addSubview:self.contentView];
    [kKeyWindow addSubview:self];
}

#pragma mark - Event

- (void)backViewClicked {
    [self dismiss];
}

#pragma mark 显示
- (void)show {
    
    [kKeyWindow bringSubviewToFront:self];
    self.contentView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, self.contentViewHeight);
    WS(weakSelf);
    [UIView animateWithDuration:animateDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.contentView.frame = CGRectMake(0, kScreenHeight - weakSelf.contentViewHeight - kSafeAreaBottomHeight, kScreenWidth, weakSelf.contentViewHeight + kSafeAreaBottomHeight);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark 隐藏
- (void)dismiss {
    WS(weakSelf);
    [UIView animateWithDuration:animateDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        weakSelf.backgroundColor = [UIColor clearColor];
        weakSelf.contentView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, weakSelf.contentViewHeight);
    } completion:^(BOOL finished) {
        [weakSelf.contentView removeFromSuperview];
        [weakSelf.backView removeFromSuperview];
        for (UIView *view in weakSelf.subviews) {
            [view removeFromSuperview];
        }
        [weakSelf removeFromSuperview];
        if (weakSelf.dimissFinish) {
            weakSelf.dimissFinish();
        }
    }];
}

- (UIButton *)backView {
    if (_backView == nil) {
        _backView = [[UIButton alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        [_backView addTarget:self action:@selector(backViewClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backView;
}

- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

@end
