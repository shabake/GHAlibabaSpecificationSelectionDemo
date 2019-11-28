//
//  GHAlibabaSpecificationSelectionBottomView.m
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import "GHAlibabaSpecificationSelectionBottomView.h"
#import "GHSpecificationSelectionModel.h"
#import "GHSpecificationSelectionTitleModel.h"
#import "UIButton+Extension.h"

@interface GHAlibabaSpecificationSelectionBottomView()

@property (nonatomic , strong) UIView *line;

/**
 *  金额
 */
@property (nonatomic , strong) UILabel *amount;

/**
 *  确定
 */
@property (nonatomic , strong) UIButton *sure;

@end
@implementation GHAlibabaSpecificationSelectionBottomView

- (void)changeStatusWithTitles:(NSMutableArray *)titles {
    NSInteger count = 0;
    double amount = 0;
    for (NSInteger i = 0 ; i < titles.count; i ++) {
        GHSpecificationSelectionTitleModel *titleModel = titles[i ];
        for (NSInteger j = 0 ; j < titleModel.skuList.count; j++) {
            GHSpecificationSelectionModel *skuModel = titleModel.skuList[j];
            count += skuModel.count.integerValue;
            amount += [skuModel.activityType isEqualToString:@"1"] ?skuModel.count.doubleValue * skuModel.activity_price.doubleValue: skuModel.count.doubleValue * skuModel.sale_price.doubleValue;
        }
    }
    self.sure.enabled = count == 0 ? NO:YES;
    self.amount.text = [NSString stringWithFormat:@"共 %ld个￥%.2f",(long)count,amount];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        [self changeStatusWithTitles:@[].copy];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.top.right.equalTo(self);
       make.height.equalTo(@1);
    }];
    
    [self addSubview:self.amount];
    [self.amount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self.line).offset(5);
        make.height.equalTo(@20);
        make.left.equalTo(self).offset(20);
    }];
    
    [self addSubview:self.sure];
    [self.sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(@50);
        make.bottom.equalTo(self).offset(-kSafeAreaBottomHeight);
    }];
}

- (void)clickSure {
    if (self.didClickSureBlock) {
        self.didClickSureBlock();
    }
}

- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xe5e5e5);
    }
    return _line;
}

- (UILabel *)amount {
    if (_amount == nil) {
        _amount = [[UILabel alloc]init];
        _amount.textColor = KMainColor;
        _amount.font = [UIFont systemFontOfSize:14];
        _amount.textAlignment = NSTextAlignmentRight;
    }
    return _amount;
}

- (UIButton *)sure {
    if (_sure == nil) {
        _sure = [[UIButton alloc]init];
        [_sure setTitle:@"确 定" forState:UIControlStateNormal];
        [_sure setBackgroundColor:KMainColor forState:UIControlStateNormal];
        [_sure setBackgroundColor:UIColorFromRGB(0xe5e5e5) forState:UIControlStateDisabled];
        [_sure addTarget:self action:@selector(clickSure) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sure;
}

@end
