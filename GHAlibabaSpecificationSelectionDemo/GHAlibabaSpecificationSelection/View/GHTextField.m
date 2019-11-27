//
//  GHTextField.m
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import "GHTextField.h"

/** 加减按钮字体大小 */
CGFloat buttonFontSize = 14;
/** 边框宽度 */
CGFloat borderWidth = 1.0;

@interface GHTextField ()

/** 左按钮 */
@property (nonatomic , strong) UIButton *leftButton;
/** 右按钮 */
@property (nonatomic , strong) UIButton *rightButton;

@property(nonatomic,strong)UIView *leftContentView;
@property(nonatomic,strong)UIView *rightContentView;

@end
@implementation GHTextField

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - SetData
- (void)setCount:(NSInteger)count {
    _count = count;
    [self setButtonEnabled:_count];
    self.text = [NSString stringWithFormat:@"%ld",(long)count];
}

- (void)setMinCount:(NSInteger)minCount {
    _minCount = minCount;
    [self setButtonEnabled:_count];
}

- (void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
    [self setButtonEnabled:_count];
}

- (void)setMiniOrder:(NSInteger)miniOrder {
    _miniOrder = miniOrder;
}

- (void)setMiniOrderType:(GHCountFieldMiniOrderType)miniOrderType {
    _miniOrderType = miniOrderType;
}

- (void)setShowBorderLine:(BOOL)showBorderLine  {
    _showBorderLine = showBorderLine;
    if (_showBorderLine == YES) {
        self.layer.borderColor = UIColorFromRGB(0xF3F3F3).CGColor;
        self.layer.borderWidth = borderWidth;
    }
}

- (void)setButtonEnabled:(NSInteger)count{
    if (self.minCount == count && self.maxCount == count) {
        self.leftButton.enabled = NO;
        self.rightButton.enabled = NO;
    } else {
        if (count <= self.minCount) {
            self.leftButton.enabled = NO;
            self.rightButton.enabled = YES;
        } else if (count >= self.maxCount) {
            self.rightButton.enabled = NO;
            self.leftButton.enabled = YES;
        } else {
            self.leftButton.enabled = YES;
            self.rightButton.enabled = YES;
        }
    }
}

#pragma mark - Event

- (void)clickButton: (UIButton *)button {
    NSInteger oldCount = self.text.integerValue;
    
    NSInteger count = self.text.integerValue;
    GHCountFieldChangeType changeType = 0;
    if (button.tag == GHCountFieldChangeTypeAdd) {
        changeType = GHCountFieldChangeTypeAdd;
        if (self.miniOrder) {
            if (self.miniOrderType == GHCountFieldMiniOrderTypeMultiple) {
                count += self.miniOrder;
                if (count > self.maxCount) {
                    count = self.maxCount - (self.maxCount % self.miniOrder);
                    if (count == oldCount) {
                        count = oldCount;
                    }
                }
            }else {
                count ++;
            }
        }else {
            count ++;
        }
        [self setButtonEnabled:count];
    } else if (button.tag == GHCountFieldChangeTypeSub) {
        changeType = GHCountFieldChangeTypeSub;
        if (self.miniOrder) {
            if (self.miniOrderType == GHCountFieldMiniOrderTypeMultiple) {
                if (count % self.miniOrder != 0) {
                    count = count - (count % self.miniOrder);
                }else {
                    count -= self.miniOrder;
                }
            }else {
                count --;
            }
        }else {
            count --;
        }
        [self setButtonEnabled:count];
    }
    
    self.text = [NSString stringWithFormat:@"%ld",(long)count];
    if (self.countDidChangeBlock) {
        self.countDidChangeBlock(self.text.integerValue);
    }
}


- (void)textDidChange:(NSNotification *)noti {
    
    NSInteger count = self.text.integerValue;
    
    [self setButtonEnabled:count];
    
    NSLog(@"输入的数值为:%@", self.text);
    
    if (count > self.maxCount) {
        count = self.maxCount;
        if (self.miniOrder) {
            if (self.miniOrderType == GHCountFieldMiniOrderTypeMultiple) {
                count = self.maxCount - (self.maxCount % self.miniOrder);
            }else {
                count = self.maxCount;
            }
        }
    }
    
    
    if (count < self.minCount) {
        count = self.minCount;
    }
    
    NSLog(@"逻辑计算改变后的数值为:%@", @(count));
    
    self.count = count;
    
    if (self.countDidChangeBlock) {
        self.countDidChangeBlock(self.text.integerValue);
    }
}

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.keyboardType = UIKeyboardTypeNumberPad;
        self.font = [UIFont systemFontOfSize:12];
        self.textColor = UIColorFromRGB(0x333333);
        self.textAlignment = NSTextAlignmentCenter;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.rightViewMode = UITextFieldViewModeAlways;
        
        // 左按钮
        UIButton *leftButton = [[UIButton alloc] init];
        leftButton.tag = GHCountFieldChangeTypeSub;
        leftButton.imageView.contentMode = UIViewContentModeScaleToFill;
        [leftButton setTitle:@"-" forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [leftButton setTitleColor:UIColorFromRGB(0x333333)  forState:UIControlStateNormal];
        [leftButton setTitleColor:UIColorFromRGB(0xE4E3E4) forState:UIControlStateDisabled];
        
        leftButton.layer.borderWidth = borderWidth;
        leftButton.layer.borderColor = UIColorFromRGB(0xF3F3F3).CGColor;
        [leftButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        self.leftButton = leftButton;
        
        UIView *leftContentView = [[UIView alloc] init];
        leftContentView.backgroundColor = [UIColor whiteColor];
        [leftContentView addSubview:leftButton];
        self.leftContentView = leftContentView;
        self.leftView = leftContentView;
        
        // 右按钮
        UIButton *rightButton = [[UIButton alloc] init];
        rightButton.tag = GHCountFieldChangeTypeAdd;
        rightButton.imageView.contentMode = UIViewContentModeScaleToFill;
        [rightButton setTitle:@"+" forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [rightButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        [rightButton setTitleColor:UIColorFromRGB(0xE4E3E4) forState:UIControlStateDisabled];
//        [rightButton setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [rightButton setBackgroundColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        rightButton.layer.borderWidth = borderWidth;
        rightButton.layer.borderColor = UIColorFromRGB(0xF3F3F3).CGColor;
        [rightButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        self.rightButton = rightButton;
        
        UIView *rightContentView = [[UIView alloc] init];
        rightContentView.backgroundColor = [UIColor whiteColor];
        [rightContentView addSubview:rightButton];
        self.rightContentView = rightContentView;
        self.rightView = rightContentView;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                        selector:@selector(textDidChange:)
                                                            name:UITextFieldTextDidChangeNotification
                                                          object:self];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 重新根据控件的Frame布局设置两个按钮
    self.leftButton.frame = CGRectMake(0, 0, self.height+5, self.height);
    self.rightButton.frame = CGRectMake(0, 0, self.height+5, self.height);
    self.leftContentView.frame = CGRectMake(0, 0, self.height+5, self.height);
    self.rightContentView.frame = CGRectMake(0, 0, self.height+5, self.height);
    
    // 重新根据控件的Frame布局计算两个按钮的文字大小(比例计算为按钮宽高25时，字体为kFont(12))
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:buttonFontSize * self.height/25];
    self.rightButton.titleLabel.font =  [UIFont systemFontOfSize:buttonFontSize * self.height/25];
    
    [super layoutSubviews];
}

#pragma mark - 去掉长按手势
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if ([UIMenuController sharedMenuController]) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}


@end
